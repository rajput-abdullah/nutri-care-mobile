import 'dart:io';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../ml/cbc_classifier.dart';
import '../../../../../../ml/tokenizer.dart';
import '../../../../../../res/common_widgets.dart';
import '../../../../../../res/res.dart';


class ReportScannerScreen extends StatefulWidget {
  const ReportScannerScreen({super.key});

  @override
  State<ReportScannerScreen> createState() => _ReportScannerScreenState();
}
class _ReportScannerScreenState extends State<ReportScannerScreen> {
  File? _pickedImage;
  String _recognizedText = '';
  String _classificationResult = '';
  String _summaryText = '';
  DocumentScannerOptions documentOptions = DocumentScannerOptions(
    documentFormat: DocumentFormat.jpeg, // set output document format
    mode: ScannerMode.filter, // to control what features are enabled
    pageLimit: 1, // setting a limit to the number of pages scanned
    isGalleryImport: true, // importing from the photo gallery
  );

  final openAI = OpenAI.instance.build(
    token: dotenv.env['OPENAI_API_KEY'] ?? '',
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)),
  );

  late CBCWordIndex _wordIndex;
  late CBCClassifier _classifier;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _wordIndex = CBCWordIndex();
    _classifier = CBCClassifier();
    _initResources();
  }

  Future<void> _initResources() async {
    await _wordIndex.loadWordIndex();
    await _classifier.load();
  }

  Future<void> _startDocumentScanner() async {
    _isLoading = true;
    final scanner = DocumentScanner(options: documentOptions);
    try {
      final result = await scanner.scanDocument();
      if (result.images.isNotEmpty) {
        final scannedImage = result.images.first;
        setState(() {
          _pickedImage = File(scannedImage);
          _recognizedText = '';
          _classificationResult = '';
          _summaryText = '';
        });
        print("walah-1-scannedImage");
        await _scanText(File(scannedImage));
      }
    } catch (e) {
      print("started scanning");

      debugPrint('Scanning failed: $e');
    }
  }

  Future<void> _scanText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);
    setState(() {
      _recognizedText = recognizedText.text;
      print("walah-2-_recognizedText-->$_recognizedText");

    });
    textRecognizer.close();

    await _classifyText(_recognizedText);
  }

//   Future<void> _classifyText(String text) async {
//     final tokens = _wordIndex.textToSequence(text, maxLen: _classifier.maxLen);
//     final input = [tokens.map((e) => e.toDouble()).toList()];
//
//     final result = await _classifier.classify(input);
//
//     final predictedLabel = result["label"];
//     final confidence = result["confidence"];
//     print("Predicted: $predictedLabel with confidence: $confidence");
//
//     setState(() {
//       _classificationResult = "$predictedLabel (Confidence: ${(confidence * 100).toStringAsFixed(2)}%)";
//     });
//
//     if (predictedLabel == "CBC" && confidence > 0.80) {
//       await _generateSummary(text);
//     } else {
//       setState(() {
//         _summaryText = """
// <h2>Invalid Report Detected</h2>
// <p>This does not appear to be a CBC or valid blood report.</p>
// <p>Please scan a proper laboratory blood test document.</p>
// """;
//       });
//     }
//
//   }
  Future<void> _classifyText(String text) async {
    try {
      print("Starting classification...");

      // Tokenization
      final tokens = _wordIndex.textToSequence(text, maxLen: 100)
          .map((e) => e < 5000 ? e : 1) // 1 = <OOV> token index
          .toList();
      final input = [tokens];
      // Classification
      print("Input shape: ${input.length} x ${input[0].length}");

      final result = await _classifier.classify(input);

      if (result.isEmpty || !result.containsKey("label") || !result.containsKey("confidence")) {
        throw Exception("Model output is incomplete or malformed.");
      }

      final predictedLabel = result["label"];
      final confidence = result["confidence"];
      print("Predicted: $predictedLabel with confidence: ${confidence.toStringAsFixed(2)}");

      setState(() {
        _classificationResult =
        "$predictedLabel (Confidence: ${(confidence * 100).toStringAsFixed(2)}%)";
      });

      // If it's a valid CBC report
      if (predictedLabel == "CBC" && confidence > 0.80 && text.contains(RegExp(r'(hemoglobin|wbc|rbc|platelet|hematocrit)', caseSensitive: false))) {
        print("Detected valid CBC report. Generating summary...");
        await _generateSummary(text);
      } else {
        print("Invalid or low-confidence report detected.");
        setState(() {
          _summaryText = """
<h2>Invalid Report Detected</h2>
<p>This does not appear to be a CBC or valid blood report.</p>
<p>Please scan a proper laboratory blood test document.</p>
""";
        });
      }
    } catch (e, stacktrace) {
      print("❌ Error during classification: $e");
      print("🔧 Stack trace:\n$stacktrace");

      setState(() {
        _classificationResult = "Error classifying the input.";
        _summaryText = """
<h2>Classification Failed</h2>
<p>Something went wrong while analyzing the document.</p>
<p>Please try again or re-upload the report.</p>
""";
      });
    }
  }
bool containsCBCKeywords(String text) {
  final keywords = [
    "hemoglobin", "platelet", "wbc", "rbc", "cbc", "hematocrit", "blood", "count"
  ];
  final lowerText = text.toLowerCase();
  return keywords.any((word) => lowerText.contains(word));
}

  Future<void> _generateSummary(String parsedReport) async {
    final summaryPrompt = """
You are an expert medical report summarizer.

Below is a patient's Complete Blood Count (CBC) and other related blood test results:

$parsedReport

Your task is to carefully analyze the actual test values in this report and generate a personalized, detailed HTML summary. The summary must include:

- An overall health interpretation in a paragraph.
- Section headings for each key test (like Hemoglobin, WBC, Platelet Count, RBC, Hematocrit, Blood Glucose, Cholesterol, etc.).
- For each test, explain the result: is it normal, high, or low? Compare to the normal range, explain what this means in simple terms for the patient.
- End with an overall recommendation or follow-up advice.
- Use clean, semantic HTML tags (<h2>, <h3>, <p>).

Only include the final summary in HTML. Do not repeat the raw report.

Example style (DO NOT COPY TEXT, write new content based on the actual results):

<h2>Blood Test Report Summary</h2>
<h3>Overall</h3>
<p>Brief general interpretation...</p>
<h3>Hemoglobin</h3>
<p>Detailed result and what it means...</p>
...
<h3>Meaning</h3>
<p>Final interpretation and advice...</p>

Make sure your summary is clear, medically accurate, and easy for a patient to understand.
""";

    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages: [
        {"role": "user", "content": summaryPrompt}
      ],
      maxToken: 1000,
    );

    final response = await openAI.onChatCompletion(request: request);
    final summary = response?.choices.first.message?.content;
    print("summary-->$summary");
    _isLoading = false;
    setState(() {
      _summaryText = summary??"";
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading:false,
        elevation: 0.5,
        title: CustomText(
          text: "Report Scanner Screen",
          fontWeight: FontWeight.normal,
          fontSize: sizes?.fontSize24,
          alignment: Alignment.center,
          color: AppColors.blackTextColor,
          fontFamily: 'Inter Tight',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_pickedImage != null) Image.file(_pickedImage!, height: 200),
            SizedBox(height: 20),

            if (_pickedImage != null)SizedBox(height: 70,child: Text("️️⚠️ The results provided are generated by AI and may not be fully accurate. Always consult a qualified healthcare professional for medical advice and diagnosis.")),

            Expanded(
              child: SingleChildScrollView(
                child: _summaryText.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 1.0, vertical: 8.0),
                  child: Container(
                    // height: sizes!.height * 0.25,
                    width: sizes!.width,
                    padding: EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                        child: Html(
                                          data: _summaryText,
                                          extensions: [
                        TagExtension(
                          tagsToExtend: {"flutter"},
                          child: const FlutterLogo(),
                        ),
                                          ],
                                          style: {
                        "p.fancy": Style(
                          textAlign: TextAlign.center,
                          padding: HtmlPaddings.all(16),
                          backgroundColor: Colors.grey,
                          margin: Margins(left: Margin(50, Unit.px), right: Margin.auto()),
                          width: Width(300, Unit.px),
                          fontWeight: FontWeight.bold,
                        ),
                                          },
                                        ),
                      ),
                    )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _isLoading?
                    Skeletonizer(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1.0, vertical: 8.0),
                        child: Container(
                          // height: sizes!.height * 0.25,
                          width: sizes!.width,
                          padding: EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: sizes!.height*0.29,
                                child: ListView.builder(
                                    itemCount: 6, // or any dynamic count
                                    itemBuilder: (context, index) {
                                      return Padding(padding: EdgeInsets.only(
                                          bottom: 5
                                      ),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:

                                            "️️⚠️ The results provided are generated by AI and may not be fully accurate. Always consult a qualified healthcare professional for medical advice and diagnosis.",



                                          style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                "️️⚠️ The results provided are generated by AI and may not be fully accurate. Always consult a qualified healthcare professional for medical advice and diagnosis.",                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),);
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ):
                        Column(
                          children: [
                            SizedBox(height: 150,),
                            CustomText(
                              text: "No text recognized yet.",
                              fontWeight: FontWeight.bold,
                              fontSize: sizes?.fontSize20,
                              alignment: Alignment.center,
                              color: AppColors.blackTextColor,
                              fontFamily: 'Inter Tight',
                            ),
                            SizedBox(height: 50,),
                            CustomButton(label: "Scan Now",
                              onPressed: (){
                                _startDocumentScanner();

                              },),
                          ],
                        )


                  ],
                ),
              ),
            ),
            if (_pickedImage != null)
            SizedBox(height: 55,child:
            CustomButton(label: "Scan Again",

              onPressed: (){
                _startDocumentScanner();

              },),)

          ],
        ),
      ),
    );


  }
}
