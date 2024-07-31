# Location App

Location Data Flutter app

---
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

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
