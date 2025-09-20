NutriCare (Flutter)

AI-powered nutrition assistant that personalizes diet suggestions, checks food/medicine suitability against a user’s medical profile, and explains blood reports in plain language.

Platform: Flutter (mobile)

Core features: Nutrition plan (GPT-4.1 nano fine-tuned), Item suitability checker, Report Scanner (OCR + CBC classifier), AI chat, Profile & medical history

Owner: Abdullah Shahbaz (MSc AI, University of Huddersfield)

✨ Features

Personalized nutrition plan

Considers medical, diet, religious, physical, age, and gender info

Backed by a fine-tuned GPT-4.1 nano model

Item suitability checker

Scan or search a medicine/food item → get “good/avoid” with rationale

Report Scanner

ML Kit OCR to extract text from lab reports

Local CBC classifier (TFLite) to confirm if a document is a CBC

Automatically generates a patient-friendly HTML summary of key metrics

AI chat about nutrition

Ask follow-ups, dietary alternatives, and plan adjustments

Profile & medical background

Store conditions, allergies, and preferences

Fast UX

Nutrition response: ~6s after fine-tuning (was 22s)

Report summary: ~2–4s (was 6–10s)

🏗️ Architecture Overview

Flutter UI

lib/features/home/report_scanner_screen.dart – OCR + classify + HTML summary

Future: chat history screen (backend ready)

On-device ML

TFLite CBC classifier detects CBC vs. non-CBC reports

Assets in assets/model/:

cbc_model.tflite

cbc_labels.txt

tokenizer.json

Flutter bindings:

lib/ml/cbc_classifier.dart

lib/ml/word_index.dart

LLM integration

Fine-tuned GPT-4.1 nano (nutrition suggestions + summaries)

Config via --dart-define (no secrets in code)

OCR

ML Kit for robust on-device text extraction

📁 Project Structure (Flutter)
lib/
features/
home/
report_scanner_screen.dart
ml/
cbc_classifier.dart
word_index.dart
...
assets/
model/
cbc_model.tflite
cbc_labels.txt
tokenizer.json


Ensure these assets are declared in pubspec.yaml (see below).

🔧 Prerequisites

Flutter (stable) 3.x and Dart 3.x

Android Studio or VS Code + Flutter/Dart extensions

Android SDK & emulator (or device)

ML Kit (for OCR)

Access to your fine-tuned GPT-4.1 nano deployment (API key / endpoint)

📦 Setup

Clone & install

git clone https://github.com/<you>/nutricare-flutter.git
cd nutricare-flutter
flutter clean
flutter pub get


Add assets to pubspec.yaml

flutter:
uses-material-design: true
assets:
- assets/model/cbc_model.tflite
- assets/model/cbc_labels.txt
- assets/model/tokenizer.json


Configure secrets (don’t hardcode!)

Use --dart-define to inject secrets at build/run time:

OPENAI_API_KEY

OPENAI_BASE_URL (if using a gateway / proxy)

MODEL_NAME (e.g., your fine-tuned model id)

Example:

flutter run \
--dart-define=OPENAI_API_KEY=sk-xxxx \
--dart-define=OPENAI_BASE_URL=https://api.openai.com/v1 \
--dart-define=MODEL_NAME=gpt-4.1-nano-finetuned-nutricare


For release builds:

flutter build apk \
--dart-define=OPENAI_API_KEY=sk-xxxx \
--dart-define=OPENAI_BASE_URL=https://api.openai.com/v1 \
--dart-define=MODEL_NAME=gpt-4.1-nano-finetuned-nutricare


Android configuration

Ensure ML Kit dependencies are present (in your android/app/build.gradle).

If using internet access for the LLM, make sure android/app/src/main/AndroidManifest.xml includes:

<uses-permission android:name="android.permission.INTERNET" />

▶️ Running

Debug

flutter run --dart-define=... # as above


Release APK

flutter build apk --release --dart-define=...

🔐 Security & Privacy

Never commit API keys, keystores (.jks), or local.properties.

Add/keep these in .gitignore:

.gradle/
build/
**/build/
local.properties
*.iml
.idea/
keystore.properties
*.jks
*.keystore


CBC model and tokenizer are non-sensitive but should remain unchanged for reproducibility.

Report summaries are generated locally then enriched via the LLM—ensure compliance with your data policies before sending PII to external services.

🧪 Testing Notes

Validate OCR with varied CBC report images (lighting, orientation).

CBC classifier edge cases:

Missing common CBC keywords

Mixed multi-page PDFs (only 1 page scanned currently)

Nutrition plan scenarios:

Multiple comorbidities (e.g., diabetes + CKD)

Religious dietary constraints

Allergy conflicts in suggested foods

🗺️ Roadmap

Frontend Chat History screen (backend ready)

Offline cache of common food/medicine facts

Multi-page report scanning

Export/share HTML report summary

CI for builds + unit/widget tests

Localization (EN → multi-lang)

🧩 Troubleshooting

Model not found: Confirm assets/model/* paths and pubspec.yaml entries, then flutter clean && flutter pub get.

Slow responses: Check network latency, confirm you’re using the fine-tuned nano model, and verify your gateway/base URL.

OCR poor quality: Try higher-res images, better lighting, and ensure camera permissions are granted.

TFLite errors: ABI issues on some devices—ensure default Flutter NDK config or add needed ABIs in Gradle.

🤝 Contributing

Create a feature branch: git checkout -b feature/<name>

Commit changes: git commit -m "feat: ..."

Push: git push origin feature/<name>

Open a PR

Please avoid committing secrets or large binaries.

📄 License

This project is for academic/dissertation use. Consider adding an explicit LICENSE file if you plan public releases.

🙏 Acknowledgements

University of Huddersfield — MSc AI

Supervisor: Mohamed Kentour

Examiner: Dr. Emmanuel Papakojis

📬 Contact

Abdullah Shahbaz — Maintainer
Issues & feature requests via GitHub Issues.