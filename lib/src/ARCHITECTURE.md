# Clean Architecture Structure

This document explains the new folder structure and architectural patterns used in this project.

## 📁 Folder Structure

```
lib/
├── src/                          # All source code
│   ├── core/                     # Core utilities & shared code
│   │   ├── constants/            # App-wide constants
│   │   ├── errors/               # Error definitions (failures.dart)
│   │   ├── platform/             # Platform abstractions
│   │   ├── theme/                # Theme configuration
│   │   ├── usecases/             # Base use case interface
│   │   └── utils/                # Utility functions
│   │
│   ├── di/                       # Dependency Injection
│   │   ├── injection.dart        # Main DI configuration
│   │   └── modules/              # Modular DI setup
│   │       ├── network_module.dart
│   │       ├── storage_module.dart
│   │       └── auth_module.dart
│   │
│   ├── data/                     # Data Layer
│   │   ├── datasources/          # Remote & local data sources
│   │   ├── models/               # DTOs (Data Transfer Objects)
│   │   └── repositories/         # Repository implementations
│   │
│   ├── domain/                   # Domain Layer (Business Logic)
│   │   ├── entities/             # Domain entities
│   │   ├── repositories/         # Repository interfaces
│   │   └── usecases/             # Business use cases
│   │
│   ├── presentation/             # Presentation Layer (UI)
│   │   ├── blocs/                # BLoC state management
│   │   ├── routes/               # Navigation/routing
│   │   └── widgets/              # Reusable widgets
│   │
│   ├── app.dart                  # App widget
│   └── main_desktop.dart         # Desktop entrypoint
│
└── main.dart                     # Legacy entrypoint (to be migrated)
```

## 🏗️ Clean Architecture Layers

### 1. **Presentation Layer** (`src/presentation/`)
- **Responsibility**: UI and user interaction
- **Contains**: Screens, widgets, BLoCs
- **Rule**: Can only depend on domain layer

Example:
```dart
// lib/src/presentation/blocs/auth/auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;  // ✅ Depends on domain
  
  AuthBloc(this._loginUseCase);
}
```

### 2. **Domain Layer** (`src/domain/`)
- **Responsibility**: Business logic and rules
- **Contains**: Entities, use cases, repository interfaces
- **Rule**: NO dependencies on other layers (pure Dart)

Example:
```dart
// lib/src/domain/usecases/auth/login_usecase.dart
class LoginUseCase extends UseCase<User, LoginParams> {
  final AuthRepository repository;  // ✅ Depends on interface only
  
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.phone, params.password);
  }
}
```

### 3. **Data Layer** (`src/data/`)
- **Responsibility**: Data access and storage
- **Contains**: API clients, local storage, repository implementations
- **Rule**: Implements domain repository interfaces

Example:
```dart
// lib/src/data/repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  
  @override
  Future<Either<Failure, User>> login(String phone, String password) async {
    try {
      final userModel = await remoteDataSource.login(phone, password);
      return Right(userModel.toEntity());  // Convert DTO to Entity
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
```

## 🔄 Data Flow

```
User Interaction
      ↓
   Widget
      ↓
   BLoC (emits event)
      ↓
   Use Case (business logic)
      ↓
   Repository Interface (domain)
      ↓
   Repository Implementation (data)
      ↓
   Data Source (API/Database)
      ↓
   Model (DTO)
      ↓
   Entity (domain)
      ↓
   BLoC (emits state)
      ↓
   Widget (rebuilds)
```

## 🎯 Key Principles

### 1. Dependency Rule
- **Inner layers don't know about outer layers**
- Domain layer is pure Dart (no Flutter imports)
- Use dependency inversion (interfaces)

### 2. Single Responsibility
- Each class has one reason to change
- Use cases handle ONE business operation
- Repositories handle ONE entity

### 3. Error Handling
- Use `Either<Failure, Success>` pattern
- Define specific failure types
- No exceptions crossing layer boundaries

### 4. Dependency Injection
- Use GetIt for DI
- Register in modular fashion
- Easy to mock for testing

## 🧪 Testing Strategy

### Unit Tests
```dart
test/unit/
├── domain/usecases/          # Test use cases
├── data/repositories/        # Test repositories
└── data/models/              # Test model conversions
```

### Widget Tests
```dart
test/widget/
└── presentation/             # Test UI components
```

### Integration Tests
```dart
integration_test/
└── features/                 # Test complete user flows
```

## 📝 Naming Conventions

### Files
- `snake_case` for filenames
- `feature_bloc.dart`, `feature_event.dart`, `feature_state.dart`
- `feature_usecase.dart`
- `feature_repository.dart`

### Classes
- `PascalCase` for class names
- Suffix with type: `LoginUseCase`, `AuthRepository`, `UserEntity`
- BLoC files: `AuthBloc`, `AuthEvent`, `AuthState`

### Variables
- `camelCase` for variables and methods
- Prefix private with underscore: `_repository`
- Be descriptive: `userEntity` not `data`

## 🚀 Migration Guide

### From Old Structure to New

1. **Move BLoCs**:
   ```
   lib/features/auth/view_model/bloc_auth/
   → lib/src/presentation/blocs/auth/
   ```

2. **Extract Use Cases**:
   - Move business logic from BLoCs to use cases
   - Create use case for each operation

3. **Create Entities**:
   - Extract domain entities from models
   - Keep DTOs in data layer

4. **Repository Interfaces**:
   - Create interface in domain
   - Move implementation to data

## 📚 Additional Resources

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)
- [BLoC Pattern](https://bloclibrary.dev)
