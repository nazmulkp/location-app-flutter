# Location App

Location Data Flutter app

<img src="https://github.com/user-attachments/assets/c492c6da-ef6b-4286-9c7b-f64178c46b60" alt="Simulator Screenshot" width="300" height="600">

Video preview:
https://drive.google.com/file/d/1e-BegY9Hzr9U-aVoJH8nUGz8AGPkUa5p/view?usp=sharing

Apk link 
https://drive.google.com/file/d/16CytPNrauuSfUK4F6kYzaHSpvp-nE0gQ/view?usp=sharing


---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production


To build this project 

```sh
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```






