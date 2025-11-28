# Flutter-Squillo

A Flutter-based mobile application for recipe management and cooking technique learning, powered by an AI-driven educational engine.

## Prerequisites

- Flutter SDK 3.10.0 or higher
- Dart SDK (included with Flutter)
- Android Studio / Xcode (for mobile development)
- FastAPI-Squillo backend running locally or deployed

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Flutter-Squillo
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```

4. **Configure environment variables**

   Create a `.env` file in the project root with backend configuration:
   ```env
   API_BASE_URL=http://localhost:8000
   ```

## Running the App

Run the app in debug mode (with hot reload):

```bash
flutter run
```

Run in release mode:

```bash
flutter run --release
```

Select your target device when prompted, or specify a device:

```bash
flutter run -d android       # Android
flutter run -d ios           # iOS (macOS only)
```

## Development

### Code Quality

**Analyze code:**
```bash
flutter analyze
```
**All code must pass analysis with zero warnings before committing.**

**Format code:**
```bash
dart format .
```

**Run tests:**
```bash
flutter test                           # All tests
flutter test test/widget_test.dart     # Specific test
```

**Clean build artifacts:**
```bash
flutter clean
```

### API Management

**Update OpenAPI spec from backend:**
```bash
make update-openapi
```
Requires the FastAPI-Squillo backend running on `http://localhost:8000`

### Building

**Build Android APK:**
```bash
flutter build apk
```

**Build iOS (macOS only):**
```bash
flutter build ios
```

**Build for web:**
```bash
flutter build web
```

## Project Structure

This project follows a **domain-driven architecture with Bloc** pattern:

```
lib/
├── main.dart                    # Application entry point
├── app/                         # App configuration
├── core/                        # Shared utilities, constants, network
├── features/                    # Feature modules (auth, recipes, etc.)
│   └── [feature]/
│       ├── bloc/                # State management
│       ├── data/                # Repositories, models
│       └── presentation/        # Screens, widgets
└── shared/                      # Shared widgets, themes
```

## Technologies

- **Flutter** - Cross-platform UI framework
- **Bloc** - State management
- **Dio** - HTTP client for API communication
- **GetIt** - Dependency injection
- **Equatable** - Value equality for Bloc events/states

## Coding Standards

This project follows strict coding standards documented in [CLAUDE.md](CLAUDE.md).

Key principles:
- **SOLID principles** and clean architecture
- **Domain-driven design** with clear feature boundaries
- **Bloc pattern** for all state management
- **Repository pattern** for data access
- **Zero warnings policy** - all code must pass `flutter analyze`
- **Comprehensive testing** - unit, widget, and integration tests
- **Package imports only** - never use relative imports

## API Integration

The app connects to the FastAPI-Squillo backend. Always reference [openapi.json](openapi.json) for API contract details:

- Recipe import and management
- User authentication and profiles
- AI-powered cooking technique recommendations
- Educational content delivery

## Testing

Run all tests before committing:

```bash
flutter test
```

The project maintains:
- **Unit tests** for business logic
- **Widget tests** for UI components
- **Bloc tests** for state management
- **Integration tests** for user flows

**Zero test failures policy** - all tests must pass.

## Contributing

1. Follow the coding standards in [CLAUDE.md](CLAUDE.md)
2. Run `flutter analyze` - fix all warnings
3. Run `flutter test` - ensure all tests pass
4. Format code with `dart format`
5. Write tests for new features
6. Update documentation as needed
