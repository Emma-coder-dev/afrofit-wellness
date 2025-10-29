# 🏋️ AfroFit Wellness - Fitness App for Africa

![AfroFit Wellness](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-green.svg)

A comprehensive fitness and wellness mobile application specifically designed for African users, featuring culturally relevant content, African food database, and personalized workout plans.

---

## 📱 Features

### 🎯 Core Features
- **Personalized Onboarding** - Custom fitness plans based on body goals
- **African Food Database** - 50+ authentic African foods with accurate nutrition data
- **Workout Library** - 60+ bodyweight exercises with instructions
- **Live Workout Tracking** - Timer and rep counter for real-time tracking
- **Progress Charts** - Visual weight tracking with line graphs
- **Nutrition Tracking** - Log meals with customizable servings
- **Water Intake Tracking** - Quick-add water consumption
- **Profile Management** - Edit goals and preferences
- **Truth Facts** - Educational myth-busting content
- **Notifications** - Stay motivated with reminders

### 🌍 Culturally Relevant
- African food database (Ugali, Jollof Rice, Fufu, etc.)
- Local food names in multiple languages
- Realistic portion sizes
- Body-positive approach for African body types
- No equipment needed (bodyweight exercises)

---

## 🛠️ Tech Stack

### Frontend
- **Framework:** Flutter 3.0+
- **Language:** Dart
- **State Management:** Riverpod (ready for implementation)
- **Local Storage:** Hive
- **Charts:** FL Chart
- **UI Components:** Material Design 3

### Architecture
- **Pattern:** Feature-first Clean Architecture
- **Structure:** Modular with separation of concerns
- **Data Flow:** Repository Pattern

---

## 📂 Project Structure
```
lib/
├── app/                          # App-level configuration
│   ├── providers/                # Global state providers
│   └── routes/                   # Navigation routes
├── core/                         # Core utilities
│   ├── constants/                # App constants
│   ├── theme/                    # Theme configuration
│   └── utils/                    # Helper utilities
├── features/                     # Feature modules
│   ├── dashboard/                # Home dashboard
│   ├── nutrition/                # Food tracking
│   ├── workouts/                 # Exercise tracking
│   ├── progress/                 # Progress visualization
│   ├── profile/                  # User profile
│   └── onboarding/               # User onboarding
└── shared/                       # Shared resources
    ├── services/                 # Shared services
    └── widgets/                  # Reusable widgets
```

---

## 🚀 Getting Started

### Prerequisites
```bash
Flutter SDK: >=3.0.0 <4.0.0
Dart SDK: >=3.0.0 <4.0.0
Android Studio / VS Code
Android SDK (for Android)
Xcode (for iOS - macOS only)
```

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/afrofit_wellness.git
cd afrofit_wellness
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate necessary files**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```bash
# Android
flutter run

# iOS (macOS only)
flutter run -d ios

# Web (for testing only)
flutter run -d chrome
```

---

## 📦 Dependencies
```yaml
dependencies:
  flutter_riverpod: ^2.4.9         # State management
  hive: ^2.2.3                     # Local database
  hive_flutter: ^1.1.0             # Hive Flutter support
  google_fonts: ^6.1.0             # Custom fonts
  fl_chart: ^0.65.0                # Charts
  intl: ^0.18.1                    # Internationalization
  uuid: ^4.2.1                     # Unique IDs
  path_provider: ^2.1.1            # File paths
  shared_preferences: ^2.2.2       # Simple storage

dev_dependencies:
  build_runner: ^2.4.7             # Code generation
  hive_generator: ^2.0.1           # Hive type adapters
  flutter_lints: ^3.0.0            # Linting
```

---

## 🏗️ Build for Production

### Android (APK)
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

Output location: `build/app/outputs/`

### iOS (IPA)
```bash
# Build for iOS
flutter build ios --release

# Build IPA (requires Xcode)
flutter build ipa --release
```

---

## 🌐 Deployment Options

### Option 1: Google Play Store (Android)

**Requirements:**
- Google Play Developer Account ($25 one-time fee)
- App signing key
- Privacy policy
- Store listing assets

**Steps:**
1. Create app in Google Play Console
2. Generate release build
3. Upload APK/AAB
4. Complete store listing
5. Submit for review

**Resources:**
- [Google Play Console](https://play.google.com/console)
- [Publishing Guide](https://docs.flutter.dev/deployment/android)

---

### Option 2: Apple App Store (iOS)

**Requirements:**
- Apple Developer Account ($99/year)
- macOS with Xcode
- App Store Connect access
- Privacy policy

**Steps:**
1. Create app in App Store Connect
2. Configure certificates & profiles
3. Build IPA
4. Upload via Xcode or Transporter
5. Submit for review

**Resources:**
- [App Store Connect](https://appstoreconnect.apple.com)
- [Publishing Guide](https://docs.flutter.dev/deployment/ios)

---

### Option 3: Firebase Hosting (Web Version - Demo Only)

**Note:** This app is designed for mobile. Web version is for demo purposes only.

**Setup:**
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase
firebase init hosting

# Build for web
flutter build web

# Deploy
firebase deploy
```

**Resources:**
- [Firebase Hosting](https://firebase.google.com/docs/hosting)
- [Flutter Web Guide](https://docs.flutter.dev/deployment/web)

---

### Option 4: Self-Hosting (Web Demo)

**Vercel:**
```bash
# Install Vercel CLI
npm install -g vercel

# Build
flutter build web

# Deploy
cd build/web
vercel
```

**Netlify:**
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Build
flutter build web

# Deploy
cd build/web
netlify deploy --prod
```

**Render:**
- Connect GitHub repository
- Set build command: `flutter build web`
- Set publish directory: `build/web`

---

## 🔥 Firebase Integration (Optional)

### Why Add Firebase?
- User authentication (login/signup)
- Cloud storage (sync across devices)
- Push notifications
- Analytics
- Crashlytics

### Setup Steps

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Create new project
   - Add Android/iOS apps

2. **Install FlutterFire CLI**
```bash
dart pub global activate flutterfire_cli
```

3. **Configure Firebase**
```bash
flutterfire configure
```

4. **Add Firebase Dependencies**
```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  firebase_storage: ^11.5.6
```

5. **Initialize in Code**
```dart
// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AfroFitWellnessApp());
}
```

---

## 🎨 Customization

### Theme Colors
Edit `lib/core/theme/color_palette.dart`:
```dart
class ColorPalette {
  static const Color primary = Color(0xFF2E7D32);      // Green
  static const Color secondary = Color(0xFFFF6F00);    // Orange
  static const Color accent = Color(0xFF6A1B9A);       // Purple
  // ... customize as needed
}
```

### Fonts
Edit `lib/core/theme/app_theme.dart`:
```dart
textTheme: GoogleFonts.poppinsTextTheme(
  Theme.of(context).textTheme,
),
```

### App Name & Icon
- **Name:** Edit `android/app/src/main/AndroidManifest.xml`
- **Icon:** Replace `android/app/src/main/res/mipmap-*/ic_launcher.png`
- Use [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)

---

## 📊 Data Storage

### Local Storage (Hive)
- User profile data
- Daily logs (meals, workouts)
- Progress entries
- Notifications

### Storage Location
- **Android:** `/data/data/com.yourapp.afrofit/`
- **iOS:** App sandbox directory

### Data Backup
Users can export/import data (feature can be added):
```dart
// Export all data
final allData = await LocalStorageService.exportAllData();

// Import data
await LocalStorageService.importData(jsonData);
```

---

## 🧪 Testing

### Run Tests
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/
```

### Test Coverage
```bash
flutter test --coverage
```

---

## 🐛 Troubleshooting

### Common Issues

**1. Hive initialization error**
```dart
await Hive.initFlutter();
```

**2. Build runner issues**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**3. Gradle build failure (Android)**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter build apk
```

**4. CocoaPods issues (iOS)**
```bash
cd ios
pod install
cd ..
flutter clean
flutter build ios
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 👥 Authors

- **Neema Kageni** - *Initial work* - [YourGitHub](https://github.com/Emma-coder-dev)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- African food nutrition data from various sources
- Exercise descriptions from fitness experts
- Community feedback and testing

---

## 📞 Contact & Support

- **Email:** support@afrofitwellness.com
- **Website:** https://afrofitwellness.com
- **Issues:** [GitHub Issues](https://github.com/Emma-coder.dev/afrofit_wellness/issues)

---

## 🗺️ Roadmap

### Version 1.1 (Next Release)
- [ ] Firebase authentication
- [ ] Cloud data sync
- [ ] Before/after photos
- [ ] Meal planning
- [ ] Recipe database

### Version 1.2 (Future)
- [ ] Social features (share progress)
- [ ] Challenges & competitions
- [ ] Workout videos
- [ ] AI meal suggestions
- [ ] Wearable device integration

---

## 📈 App Statistics

- **Total Screens:** 20+
- **Features:** 100+
- **African Foods:** 50+
- **Exercises:** 60+
- **Lines of Code:** ~15,000+

---


## 🔐 Privacy & Security

- All data stored locally on device
- No data shared with third parties
- No user tracking or analytics (unless Firebase added)
- GDPR compliant (with proper privacy policy)

---

## ⚠️ Disclaimer

This app is for informational and educational purposes only. It is not a substitute for professional medical advice, diagnosis, or treatment. Always consult with a qualified healthcare provider before starting any fitness or nutrition program.

---


---

*Last Updated: October 2025*
=======
# afrofit-wellness
