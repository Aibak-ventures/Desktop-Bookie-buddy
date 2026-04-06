# Contributing to Bookie Buddy Web

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to the project.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Architecture Guidelines](#architecture-guidelines)
- [Testing Requirements](#testing-requirements)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers and help them learn
- Focus on constructive feedback
- Respect differing viewpoints and experiences

## Getting Started

### Prerequisites
- Flutter SDK 3.24.5 or higher
- Dart SDK 3.5.0 or higher
- Git
- IDE: VS Code or Android Studio (recommended)

### Setup
1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/bookie_buddy_web.git
   cd bookie_buddy_web
   ```
3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/Aibak-ventures/Desktop-Bookie-buddy.git
   ```
4. Install dependencies:
   ```bash
   flutter pub get
   ```
5. Verify setup:
   ```bash
   flutter analyze
   flutter test
   ```

## Development Workflow

### Branching Strategy

We follow a feature branch workflow:

```
main (production-ready)
  ↑
dev (integration branch)
  ↑
feat/feature-name (your work)
```

#### Branch Naming Convention
- `feat/description` - New features
- `fix/description` - Bug fixes
- `docs/description` - Documentation changes
- `test/description` - Test additions/changes
- `refactor/description` - Code refactoring
- `chore/description` - Maintenance tasks

#### Creating a Feature Branch
```bash
# Update your local dev branch
git checkout dev
git pull upstream dev

# Create your feature branch
git checkout -b feat/your-feature-name
```

### Making Changes

1. **Keep changes focused**: One feature/fix per branch
2. **Write tests first**: Follow TDD when possible
3. **Follow architecture**: See [ARCHITECTURE.md](./lib/src/ARCHITECTURE.md)
4. **Run checks frequently**:
   ```bash
   dart format .
   flutter analyze
   flutter test
   ```

## Architecture Guidelines

This project follows **Clean Architecture** with strict layer separation:

### Layer Structure
```
lib/src/
├── domain/          # Business logic (pure Dart)
│   ├── entities/    # Business objects
│   ├── repositories/# Repository interfaces
│   └── usecases/    # Business logic operations
├── data/            # Data handling
│   ├── models/      # Data models (entities + JSON)
│   ├── datasources/ # API, local storage
│   └── repositories/# Repository implementations
├── presentation/    # UI layer
│   ├── blocs/       # State management
│   ├── widgets/     # Reusable UI components
│   └── pages/       # Full screens
└── core/            # Shared utilities
```

### Key Principles

#### 1. Dependency Rule
- **Domain layer**: No dependencies on other layers (pure Dart)
- **Data layer**: Depends on domain only
- **Presentation layer**: Depends on domain only
- **Core**: Can be used by all layers

#### 2. Error Handling
Use `Either<Failure, Success>` pattern:
```dart
Future<Either<Failure, User>> login(String phone, String password) async {
  if (phone.isEmpty) {
    return Left(ValidationFailure(message: 'Phone required'));
  }
  // ... API call
  return Right(user);
}
```

#### 3. Business Logic Location
- ✅ **Use Cases**: Business logic goes here
- ❌ **BLoCs**: Only coordinate UI and use cases
- ❌ **Repositories**: Only data access, no business rules

#### 4. Dependency Injection
Use GetIt with modular pattern:
```dart
// lib/src/di/modules/feature_module.dart
class FeatureModule {
  static Future<void> register() async {
    final getIt = GetIt.instance;
    
    // Data sources
    getIt.registerLazySingleton<FeatureDataSource>(
      () => FeatureDataSourceImpl(dio: getIt()),
    );
    
    // Repositories
    getIt.registerLazySingleton<FeatureRepository>(
      () => FeatureRepositoryImpl(dataSource: getIt()),
    );
    
    // Use cases
    getIt.registerLazySingleton(() => GetFeatureUseCase(repository: getIt()));
    
    // BLoCs
    getIt.registerFactory(() => FeatureBloc(useCase: getIt()));
  }
}
```

## Testing Requirements

### Minimum Coverage
- **Overall**: 80%+
- **Domain layer**: 90%+ (critical business logic)
- **Use cases**: 100% (must test all scenarios)
- **BLoCs**: 80%+

### Test Structure
```
test/
├── unit/                    # Fast, isolated tests
│   ├── domain/
│   │   └── usecases/       # UseCase tests (mocktail)
│   └── presentation/
│       └── blocs/          # BLoC tests (bloc_test)
├── widget/                 # Widget tests
└── integration/            # E2E tests
```

### Writing Tests

#### Use Case Tests
```dart
void main() {
  late MyUseCase useCase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    useCase = MyUseCase(repository: mockRepository);
  });

  group('MyUseCase', () {
    test('should return success when operation succeeds', () async {
      // Arrange
      when(() => mockRepository.doSomething())
          .thenAnswer((_) async => Right(expectedValue));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, Right(expectedValue));
      verify(() => mockRepository.doSomething()).called(1);
    });

    test('should return failure when operation fails', () async {
      // Arrange
      when(() => mockRepository.doSomething())
          .thenAnswer((_) async => Left(SomeFailure()));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, Left(SomeFailure()));
    });
  });
}
```

#### BLoC Tests
```dart
blocTest<MyBloc, MyState>(
  'should emit [Loading, Success] when event succeeds',
  build: () {
    when(() => mockUseCase(any()))
        .thenAnswer((_) async => Right(value));
    return MyBloc(useCase: mockUseCase);
  },
  act: (bloc) => bloc.add(MyEvent()),
  expect: () => [Loading(), Success(value)],
  verify: (_) {
    verify(() => mockUseCase(any())).called(1);
  },
);
```

### Running Tests
```bash
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific file
flutter test test/unit/domain/usecases/my_usecase_test.dart

# Watch mode (requires flutter_test_runner)
flutter test --watch
```

## Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `test`: Adding/updating tests
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `chore`: Maintenance tasks
- `ci`: CI/CD changes

### Examples
```bash
feat(auth): add biometric authentication support

- Implement fingerprint authentication
- Add face recognition for iOS
- Update auth flow to check for biometric capability

Closes #123
```

```bash
fix(booking): correct date validation logic

The previous logic allowed bookings in the past.
Now validates against current date before submission.

Fixes #456
```

```bash
test(auth): add unit tests for login use case

- Test successful login flow
- Test validation failures
- Test network error handling

Coverage increased to 95%
```

## Pull Request Process

### Before Submitting
1. **Update your branch**:
   ```bash
   git checkout dev
   git pull upstream dev
   git checkout your-branch
   git rebase dev
   ```

2. **Run all checks**:
   ```bash
   dart format .
   flutter analyze
   flutter test --coverage
   ```

3. **Verify no warnings**:
   ```bash
   flutter analyze --fatal-infos --fatal-warnings
   ```

### Submitting PR

1. **Push your branch**:
   ```bash
   git push origin your-branch
   ```

2. **Create PR** on GitHub:
   - Target `dev` branch (not `main`)
   - Fill out the PR template completely
   - Link related issues
   - Add screenshots for UI changes

3. **PR Checklist**:
   - [ ] Tests pass locally
   - [ ] Code formatted (`dart format`)
   - [ ] No analyzer warnings
   - [ ] Documentation updated
   - [ ] ARCHITECTURE.md updated (if needed)
   - [ ] Follows architecture guidelines
   - [ ] Commit messages follow convention

### Review Process

1. **Automated Checks**: CI must pass (analyze, test, build)
2. **Code Review**: At least 1 approval required
3. **Changes Requested**: Address feedback and push updates
4. **Merge**: Squash and merge into `dev`

### After Merge
1. **Delete your branch**:
   ```bash
   git branch -d your-branch
   git push origin --delete your-branch
   ```

2. **Update local dev**:
   ```bash
   git checkout dev
   git pull upstream dev
   ```

## IDE Setup

### VS Code Extensions
- Flutter
- Dart
- GitLens
- Error Lens
- Better Comments
- Bracket Pair Colorizer

### Recommended Settings
Create `.vscode/settings.json`:
```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  },
  "dart.lineLength": 100,
  "dart.analysisServerFolding": true,
  "[dart]": {
    "editor.rulers": [100],
    "editor.selectionHighlight": false
  }
}
```

## Getting Help

- **Documentation**: Check [ARCHITECTURE.md](./lib/src/ARCHITECTURE.md) first
- **Issues**: Search existing issues before creating new ones
- **Discussions**: Use GitHub Discussions for questions
- **Code Review**: Tag maintainers for architectural questions

## Recognition

Contributors are recognized in:
- GitHub contributors page
- Release notes (for significant contributions)
- Project README (for major features)

Thank you for contributing! 🎉
