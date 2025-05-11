📱 GPA Calculator - Flutter App
A sleek and user-friendly GPA Calculator built with Flutter, designed for engineering students to compute SGPA (Semester GPA) and CGPA (Cumulative GPA) effortlessly. The app dynamically loads subjects based on the selected department and semester.

✨ Features
🎓 Calculate SGPA and CGPA

🏫 Select your branch and semester

📚 Auto-load subjects and credits based on selection

💡 Clean and intuitive UI design

🔒 No sign-in required (lightweight and fast)

📱 Mobile responsive layout (Android support)

📸 Screenshots
(Add screenshots here if available: assets/screenshots/home.png, etc.)

🚀 Getting Started
📦 Prerequisites
Flutter SDK

Dart >= 2.18.0

Android Studio or VS Code

🛠️ Installation
bash
Copy
Edit
git clone https://github.com/your-username/gpa-calculator-flutter.git
cd gpa-calculator-flutter
flutter pub get
flutter run
🏗️ App Structure
bash
Copy
Edit
lib/
│
├── main.dart                # App entry point
├── pages/
│   ├── home_page.dart       # Landing page (SGPA / CGPA)
│   ├── sgpa_input.dart      # SGPA calculation page
│   ├── cgpa_input.dart      # CGPA calculation page
│
├── widgets/                 # Custom reusable UI widgets
├── models/                 # Subject & branch models
└── utils/                  # Helper functions, constants
🔧 Customization
To update the branch/semester data, edit the files in models/ folder.

To change UI styles, modify theme or widgets/.

📜 License
This project is licensed under the MIT License - see the LICENSE file for details.

🙌 Acknowledgements
Flutter and Dart team

Open-source contributors
