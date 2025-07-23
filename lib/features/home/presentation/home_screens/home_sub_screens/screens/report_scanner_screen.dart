import 'dart:io';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nutri_care_mobile/core/widgets/custom_button.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../profile/presentation/nutrition/widgets/scan_options_modal.dart';
import '../../../../../../res/common_widgets.dart';
import '../../../../../../res/loader.dart';
import '../../../../../../res/res.dart';
class ReportScannerScreen extends StatefulWidget {
  final ScanType? scanType;
  const ReportScannerScreen({super.key, this.scanType});

  @override
  _ReportScannerScreenState createState() => _ReportScannerScreenState();
}

class _ReportScannerScreenState extends State<ReportScannerScreen>
    with SingleTickerProviderStateMixin {
  final openAiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  File? _pickedImage;
  String _recognizedText = '';
  String _summaryText = '';
  DocumentScannerOptions documentOptions = DocumentScannerOptions(
    documentFormat: DocumentFormat.jpeg, // set output document format
    mode: ScannerMode.filter, // to control what features are enabled
    pageLimit: 1, // setting a limit to the number of pages scanned
    isGalleryImport: true, // importing from the photo gallery
  );

  final openAI = OpenAI.instance.build(
    token: dotenv.env['OPENAI_API_KEY'] ?? '';,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)),
  );

  Future<void> _startDocumentScanner() async {
    DocumentScanner documentScanner = DocumentScanner(options: documentOptions);

    try {
      // Show a loader if you have one
      Loader().showLoader(context: context);

      DocumentScanningResult result = await documentScanner.scanDocument();
      if (result.images.isNotEmpty) {
        final scannedImage = result.images.first;

        setState(() {
          _pickedImage = File(scannedImage);
          _recognizedText = '';
          _summaryText = '';
        });

        await _scanText(File(scannedImage));
      } else {
        Loader().hideLoader(context);
        // User cancelled
      }
    } catch (e) {
      Loader().hideLoader(context);
      print('Document scanning failed: $e');
    }
  }

  Future<void> _scanText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);
    final scannedText = recognizedText.text;
    textRecognizer.close();

    await _processWithChatGPT(scannedText);
  }

  Future<void> _processWithChatGPT(String scannedText) async {
    final prompt = """
You are a medical report parser.
Check if the following text is a Complete Blood Count (CBC) report.
If it is, return it wrapped as JSON in this format:-
{"reportText": "Patient Name: John Doe Date of Birth: 1985-03-15 Report Date: 2025-07-15 TEST NAME RESULT UNIT REFERENCE RANGE Hemoglobin 14.5 g/dL 13.5 - 17.5 WBC (White Blood Cells) 6.2 x10^3/uL 4.0 - 10.0 Platelet Count 250 x10^3/uL 150 - 450 RBC (Red Blood Cells) 5.1 x10^6/uL 4.5 - 5.9 Hematocrit 43.2 % 40 - 50 MCV 84.5 fL 80 - 100 MCH 28.3 pg 27 - 33 MCHC 33.4 g/dL 32 - 36 RDW 13.1 % 11.5 - 14.5 Blood Glucose (Fasting) 92 mg/dL 70 - 100 Total Cholesterol 185 mg/dL < 200 LDL Cholesterol 110 mg/dL < 130 HDL Cholesterol 52 mg/dL > 40 Triglycerides 130 mg/dL < 150 Creatinine (Serum) 0.9 mg/dL 0.7 - 1.3 BUN 15 mg/dL 7 - 20 ALT (SGPT) 25 U/L 7 - 56 AST (SGOT) 22 U/L 10 - 40 Comments: Patient is in normal health. No significant deviations noted in current test values. Recommended to continue current lifestyle and follow up in 6 months unless symptoms develop. End of Report"}

If it is NOT, reply only with: "INVALID"

The text is:
$_recognizedText
""";


    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages: [
        {
          "role": "user",
          "content": prompt,
        }
      ],
      maxToken: 500,
    );

    final response = await openAI.onChatCompletion(request: request);

    final content = response!.choices.first.message!.content;

    if (content.trim() == "INVALID") {
      _showInvalidReportDialog();
      Loader().hideLoader(context);
    } else {
      await _generateSummary(_recognizedText);
    }
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
    final summary = response!.choices.first.message!.content;
    print("summary-->$summary");
    Loader().hideLoader(context);
    setState(() {
      _summaryText = summary;
    });
  }


  void _showInvalidReportDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Invalid Report'),
        content: Text('Kindly scan your blood test report.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _recognizedText = '';
    _summaryText = '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startDocumentScanner();
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

            if (_pickedImage != null)SizedBox(height: 70,child: Text("The results provided are generated by AI and may not be fully accurate. Always consult a qualified healthcare professional for medical advice and diagnosis.")),

            Expanded(
              child: SingleChildScrollView(
                child: _summaryText.isNotEmpty
                    ? Html(
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
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}