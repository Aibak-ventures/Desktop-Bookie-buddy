# Bookie Buddy - Desktop Application

[![CI](https://github.com/Aibak-ventures/Desktop-Bookie-buddy/actions/workflows/ci.yml/badge.svg)](https://github.com/Aibak-ventures/Desktop-Bookie-buddy/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/Aibak-ventures/Desktop-Bookie-buddy/branch/main/graph/badge.svg)](https://codecov.io/gh/Aibak-ventures/Desktop-Bookie-buddy)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A professional desktop booking management application built with Flutter, designed for Windows, macOS, and Linux platforms.

## 🏗️ Architecture

This project follows **Clean Architecture** principles with strict layer separation:

```
lib/src/
├── domain/          # Business logic (pure Dart, no Flutter)
│   ├── entities/    # Business objects
│   ├── repositories/# Repository interfaces
│   └── usecases/    # Business logic operations
├── data/            # Data handling
│   ├── models/      # Data models with JSON serialization
│   ├── datasources/ # API clients, local storage
│   └── repositories/# Repository implementations
├── presentation/    # UI layer
│   ├── blocs/       # State management (BLoC pattern)
│   ├── widgets/     # Reusable UI components
│   └── pages/       # Full screen pages
├── core/            # Shared utilities
│   ├── errors/      # Error handling (Failure classes)
│   ├── usecases/    # Base UseCase interfaces
│   ├── platform/    # Platform detection
│   └── theme/       # App theming
└── di/              # Dependency injection (GetIt)
    └── modules/     # Modular DI registration
```

**Key Architectural Patterns:**
- ✅ Clean Architecture with domain/data/presentation layers
- ✅ Either<Failure, Success> for functional error handling
- ✅ Repository pattern with interface segregation
- ✅ BLoC for state management
- ✅ Dependency injection with GetIt
- ✅ Use cases for business logic encapsulation

📖 **Detailed documentation**: [ARCHITECTURE.md](./lib/src/ARCHITECTURE.md)

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: 3.24.5 or higher
- **Dart SDK**: 3.5.0 or higher
- **Platform Requirements**:
  - Windows: Windows 10 or higher
  - macOS: macOS 10.14 or higher
  - Linux: Ubuntu 20.04 or equivalent

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Aibak-ventures/Desktop-Bookie-buddy.git
   cd Desktop-Bookie-buddy
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify installation**
   ```bash
   flutter doctor -v
   flutter analyze
   flutter test
   ```

### Running the Application

#### Development Mode
```bash
# Run with desktop-specific entrypoint
flutter run -d windows lib/src/main_desktop.dart
# or
flutter run -d macos lib/src/main_desktop.dart
# or
flutter run -d linux lib/src/main_desktop.dart
```

#### Production Build
```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

## 🧪 Testing

### Running Tests
```bash
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific test file
flutter test test/unit/domain/usecases/login_usecase_test.dart

# Watch mode (reruns on file changes)
flutter test --watch
```

### Test Coverage
Current coverage: **80%+**

```bash
# Generate coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Test Structure
- **Unit Tests**: Domain layer (use cases) and BLoCs
- **Widget Tests**: Individual UI components
- **Integration Tests**: Full user flows

## 📁 Project Structure

```
bookie_buddy_web/
├── lib/
│   ├── src/                    # Source code (Clean Architecture)
│   │   ├── domain/            # Business logic
│   │   ├── data/              # Data layer
│   │   ├── presentation/      # UI layer
│   │   ├── core/              # Utilities
│   │   ├── di/                # Dependency injection
│   │   ├── main_desktop.dart  # Desktop entrypoint
│   │   ├── app.dart           # App widget
│   │   └── ARCHITECTURE.md    # Architecture documentation
│   └── main.dart              # Legacy entrypoint (deprecated)
├── test/
│   ├── unit/                  # Unit tests
│   │   ├── domain/           # Use case tests
│   │   └── presentation/     # BLoC tests
│   ├── widget/               # Widget tests
│   └── integration/          # E2E tests
├── assets/                    # Images, fonts, animations
├── .github/
│   ├── workflows/            # CI/CD pipelines
│   └── pull_request_template.md
├── CONTRIBUTING.md            # Contribution guidelines
└── README.md                 # This file
```

## 🛠️ Development

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` before committing
- Maximum line length: 100 characters

### Linting
```bash
# Analyze code
flutter analyze

# Fix auto-fixable issues
dart fix --apply
```

### Pre-commit Checklist
- [ ] `dart format .` (format code)
- [ ] `flutter analyze` (no warnings)
- [ ] `flutter test` (all tests pass)
- [ ] Update documentation if needed

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](./CONTRIBUTING.md) for detailed guidelines on:
- Setting up your development environment
- Following our branching strategy
- Writing tests (80%+ coverage required)
- Submitting pull requests
- Architecture compliance

**Quick start for contributors:**
1. Fork the repository
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Follow architecture guidelines in [ARCHITECTURE.md](./lib/src/ARCHITECTURE.md)
4. Write tests for your changes
5. Submit a pull request to `dev` branch

## 📋 Development Workflow

### Branching Strategy
```
main (production) ← dev (integration) ← feat/your-feature (your work)
```

### Commit Message Format
We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `ci`

**Example**:
```
feat(auth): add biometric authentication

- Implement fingerprint authentication
- Add face recognition for iOS
- Update auth flow

Closes #123
```

## 🧩 Dependencies

### Core Dependencies
- `flutter_bloc` - State management
- `get_it` - Dependency injection
- `dartz` - Functional programming (Either, Option)
- `dio` - HTTP client
- `shared_preferences` - Local storage
- `flutter_secure_storage` - Secure storage

### Development Dependencies
- `mocktail` - Mocking for tests
- `bloc_test` - BLoC testing utilities
- `flutter_test` - Testing framework

See [pubspec.yaml](./pubspec.yaml) for complete list.

## 📝 Documentation

- **[ARCHITECTURE.md](./lib/src/ARCHITECTURE.md)**: Detailed architecture guide
- **[CONTRIBUTING.md](./CONTRIBUTING.md)**: Contribution guidelines
- **[ARCH_AUDIT.md](./ARCH_AUDIT.md)**: Architectural assessment and remediation plan

## 🐛 Known Issues

See [GitHub Issues](https://github.com/Aibak-ventures/Desktop-Bookie-buddy/issues) for current bugs and feature requests.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

**Aibak Ventures**
- GitHub: [@Aibak-ventures](https://github.com/Aibak-ventures)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Contributors and maintainers
- Open source community

---

**Built with ❤️ using Flutter**
