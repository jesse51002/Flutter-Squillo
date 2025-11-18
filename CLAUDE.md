# Flutter-Squillo Coding Standards

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## General Principles

**SOLID Principles**
- Single Responsibility: Each widget/class has one well-defined purpose
- Open/Closed: Open for extension, closed for modification
- Liskov Substitution: Subtypes must be substitutable for their base types
- Interface Segregation: Many specific interfaces over one general-purpose
- Dependency Inversion: Depend on abstractions, not concretions

**Other Core Principles**
- DRY (Don't Repeat Yourself): Single source of truth for each piece of logic
- KISS (Keep It Simple): Favor simplicity over complexity
- YAGNI (You Aren't Gonna Need It): Don't add features until needed
- Separation of Concerns: Separate UI, business logic, and data layers

## Development Commands

### Building and Running
- `flutter run` - Run the app in debug mode (hot reload enabled)
- `flutter run --release` - Run the app in release mode
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build for iOS (requires macOS and Xcode)

### Development Tools
- `flutter analyze` - Run static analysis and linting
- `flutter test` - Run all tests
- `flutter test test/widget_test.dart` - Run specific test file
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies
- `flutter clean` - Clean build artifacts

## Dart Standards

**Imports**
- **ALWAYS use package imports** - never use relative imports
- Good: `import 'package:app_name/features/auth/bloc/auth_bloc.dart';`
- Bad: `import '../bloc/auth_bloc.dart';`
- Bad: `import './auth_bloc.dart';`

**Naming Conventions**
- Files/packages: `auth_bloc.dart`, `user_repository.dart`
- Classes: `AuthBloc`, `UserRepository`
- Functions/variables: `getUserById`, `userCount`
- Constants: `kMaxConnections`, `kApiTimeout`
- Private: `_internalVar`, `_privateMethod`
- Blocs: `FeatureBloc`, `FeatureEvent`, `FeatureState`

**Formatting**
- Max 80 characters per line
- Use `dart format` for consistent formatting
- Trailing commas for better diffs

**Type Hints**
- Always use type annotations for function parameters and return values
- Use generics appropriately (`List<String>`, `Map<String, int>`)
- Use nullable types with `?` for optional values
- Create type aliases for complex types

**Code Complexity & Nesting**
- **Limit deep nesting**
- **Extract methods when nesting gets complex** - create helper methods
- Good: Extract nested logic into separate, well-named private methods
- Bad: Deep nesting makes code hard to read and maintain

**DateTime Handling**
- Use local timezone for UI display and local operations
- **Convert to UTC when sending to backend**
- Good: `DateTime.now()` for local use, `.toUtc()` for API requests
- Backend stores UTC, frontend converts to local for display

**HTTP Requests**
- **ALWAYS add timeout to HTTP requests (default to 30 seconds)**
- Good: `dio.get(url, options: Options(receiveTimeout: Duration(seconds: 30)))`
- Bad: HTTP requests without timeout (can hang indefinitely)
- Use custom timeouts for specific endpoints if needed

## Project Structure

**Domain-Driven Architecture with Bloc**
```
lib/
├── main.dart                    # Application entry point
├── app/                         # App configuration
│   ├── app.dart                 # MaterialApp setup
│   └── routes.dart              # Route definitions
├── core/                        # Shared utilities
│   ├── constants/
│   ├── errors/
│   ├── network/
│   └── utils/
├── features/                    # Feature modules
│   ├── auth/
│   │   ├── bloc/                # Bloc, Events, States
│   │   │   ├── auth_bloc.dart
│   │   │   ├── auth_event.dart
│   │   │   └── auth_state.dart
│   │   ├── data/                # Repositories, data sources
│   │   │   ├── repositories/
│   │   │   └── models/
│   │   └── presentation/        # Screens, widgets
│   │       ├── screens/
│   │       └── widgets/
│   └── home/
│       └── ...
└── shared/                      # Shared widgets, themes
    ├── widgets/
    └── themes/
```

**Why Domain-Driven**
- Clear boundaries between business domains
- Easy to scale and maintain
- Teams can work independently
- Promotes separation of concerns

## State Management with Bloc

**Bloc Patterns**
- One Bloc per feature/screen
- Events describe user actions or system events
- States represent UI state at any point
- Use `Equatable` for Events and States
- Use `sealed` classes for States when appropriate
- Keep Blocs focused - split if handling too many concerns

**Bloc Best Practices**
- **Never emit state in constructor** - use `on<Event>` handlers
- **Use `transformEvents`** for debouncing/throttling
- **Close streams** in `close()` method
- **Test Blocs thoroughly** - they contain business logic
- **Use BlocObserver** for logging/analytics

**Layer Separation**
- Screen → Bloc → Repository → Data Source
- Screen handles UI concerns and user interactions
- Bloc handles business logic and state management
- Repository handles data access and caching
- Never skip layers

## Error Handling

**Exception Strategy**
- Create custom exception hierarchy in `core/errors/`
- Blocs catch exceptions and emit error states
- Widgets display user-friendly error messages
- Log errors for debugging

**Logging and Exception Strategy**
- **Bloc layer**: Use logging package to log errors with stack traces
  - Good: `log('Auth failed', error: e, stackTrace: stackTrace)`
  - Log before emitting error state to capture full context
- **Repository/Service layers**: Just throw exceptions with relevant messages
  - Good: `throw NetworkException('Failed to fetch user data')`
  - Focus on clear, descriptive exception messages
- **Layer Separation**: Blocs log + handle, Repositories throw + describe

**Bloc Error Handling**
```dart
on<FetchDataRequested>((event, emit) async {
  emit(DataLoading());
  try {
    final data = await repository.fetchData();
    emit(DataLoaded(data));
  } on NetworkException catch (e) {
    emit(DataError(e.message));
  }
});
```

## Testing

**Test Structure**
- Use `flutter_test` and `bloc_test` packages
- Separate unit, widget, and integration tests
- Fixtures for common setup
- One test file per module

**Test Types**
- **Unit tests**: Blocs, repositories, utilities
- **Widget tests**: Individual widgets and screens
- **Integration tests**: Full user flows
- Test error conditions and edge cases

**Testing Requirements**
- **Zero Test Failures**: All tests must pass - NO EXCEPTIONS
- **Test Coverage**: Aim for 80%+ coverage
- **Test Organization**: Tests mirror the lib/ folder structure in test/
- **Mock Usage**: Proper mocking of repositories and services
- **Continuous Testing**: Run `flutter test` before any commit

**Bloc Testing**
```dart
blocTest<AuthBloc, AuthState>(
  'emits [loading, authenticated] when login succeeds',
  build: () => AuthBloc(authRepository: mockAuthRepo),
  act: (bloc) => bloc.add(LoginRequested(email, password)),
  expect: () => [AuthLoading(), Authenticated(user)],
);
```

## Code Quality

**IMPORTANT: Always run `flutter analyze` after making code changes**
- Run before committing any changes
- Fix ALL warnings and errors
- This ensures code quality and consistency

### Zero Warnings Policy
- **NEVER USE DEPRECATED METHODS**: Always use the latest non-deprecated alternatives
- **Fix All Warnings**: If `flutter analyze` shows ANY warnings, they must be fixed immediately
- **Stay Current**: Use modern Flutter/Dart APIs (e.g., use `.withValues()` instead of `.withOpacity()`)

### Widget Architecture Principles
- **Single Responsibility**: Each widget has one clear purpose
- **No Complex Conditional Rendering**: Replace complex if/else with dedicated widgets
- **Separation of Concerns**: UI separated from business logic (use Bloc)
- **Composition over Inheritance**: Use widget composition for complex UIs
- **NO HARDCODING**: Never hardcode data values, strings, or configurations in widgets

### Production-Ready Standards
- **Comprehensive Testing**: Every feature must have corresponding tests
- **Error Handling**: All widgets/blocs handle edge cases gracefully
- **Null Safety**: Full null safety compliance
- **Performance**: Efficient widget rebuilds, use `const` constructors
- **Maintainability**: Clear naming conventions and documentation

## Dependencies

**Dependency Management**
- **ALWAYS use `flutter pub add <package>`** to add dependencies
- **NEVER manually modify pubspec.yaml** for dependencies
- Use `flutter pub add --dev <package>` for dev dependencies

**Core Dependencies**
- `flutter_bloc` - State management
- `equatable` - Value equality for Events/States
- `get_it` - Service locator/dependency injection
- `dio` - HTTP client

## Security

**Input Validation**
- Always validate user input
- Sanitize data before display
- Use parameterized queries for local databases

**Configuration**
- Environment variables for secrets (use `flutter_dotenv`)
- Never commit API keys or secrets
- HTTPS only for network requests

## Documentation

**Code Documentation**
- Docstrings for all public functions/classes
- Document parameters, return values, exceptions
- Keep documentation updated with code changes

## Code Quality Checklist

- [ ] Follows SOLID principles
- [ ] Uses Bloc for state management
- [ ] Type annotations on all functions
- [ ] Feature-based project structure
- [ ] Repository pattern for data access
- [ ] Bloc for business logic
- [ ] Comprehensive tests (unit, widget, bloc)
- [ ] Proper error handling
- [ ] No hardcoded values
- [ ] `flutter analyze` passes with no warnings
- [ ] All tests pass
- [ ] No secrets in code

**Remember: Code is read more often than written. Prioritize clarity, modularity, and maintainability.**
