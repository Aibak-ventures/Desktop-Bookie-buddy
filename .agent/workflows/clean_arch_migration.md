---
description: How to migrate a feature to Clean Architecture and verify dependencies
---

# Clean Architecture Migration Workflow

Follow these steps when migrating a legacy or loosely-structured feature into the project's strict Clean Architecture pattern.

### 1. Analyze Current State & Pre-Migration Core Check
- Identify the legacy `Service` (handles external API requests) and `Repository` (formats and manages data) methods that belong to this specific feature domain.
- Check current usages of these methods across the application to prepare for refactoring.
- **Core Dependency Check:** Audit the `core/` directory (widgets, models, services, util methods) used by the migrating feature.
  - Ask: *Is this widget/model/service exclusively used by this feature?*
  - If yes, propose to the user to move it from `core/` into `features/<feature_name>/...` to maximize feature cohesion.
  - If it is genuinely shared across multiple features, leave it in `core`.

### 2. Isolate Data Layer (`features/<feature_name>/data/`)
- Create `datasources/<feature>_remote_datasource.dart` to handle direct API endpoints (e.g., via `DioClient`).
- Create `repositories/<feature>_repository_impl.dart` to format, parse, and catch exceptions from the datasource.

### 3. Setup Domain Layer (`features/<feature_name>/domain/`)
- Create `repositories/i_<feature>_repository.dart` to define the abstract interface containing the expected methods.
- Create single-responsibility Use Cases inside `usecases/` for every distinct action. The Use Cases should accept the `I<Feature>Repository` interface via constructor.
- Move or create entity classes inside `models/`. The domain models represent the core business objects. These models can also be safely imported and used by other features when necessary, acting as the shared data structures for domain communication.

### 4. Refactor Presentation Layer (`features/<feature_name>/presentation/`)
- Rename any legacy `view_models/` directories to `presentation/bloc/` or `presentation/cubit/`.
- Rename any legacy `views/` directories to `presentation/pages/` and `presentation/widgets/`.
- Update all Blocs / Cubits to depend **strictly** on their respective Use Cases, stripping away any direct references to legacy services or the concrete repository implementation.

### 5. Update Dependency Injection
- In `lib/core/di/app_dependencies.dart`, register the new `<Feature>RemoteDatasource`, `I<Feature>Repository` (mapped to `<Feature>RepositoryImpl`), and all related Use Cases using `GetIt` (`_registerLazy`).

---

### 6. Verify Clean Architecture Boundaries (Crucial Verification)

Once the code is moved, it is imperative to verify that no architectural boundaries are being violated.

#### A. Intra-Feature Validation
Ensure the internal feature folders adhere to the dependency rule (dependencies must point inwards toward the domain):
- The `domain/` layer has **0 imports** from `data/` or `presentation/`.
- The `presentation/` layer imports the `domain/` layer (to use Use Cases) but has **0 direct imports** from the `data/` layer.
- The `data/` layer imports the `domain/` layer to implement the `I<Feature>Repository` interface.

#### B. Cross-Feature Dependency Validation
Check if any other feature or core module imports this newly migrated feature improperly. 
Run a global text search in the `lib` directory for: `import.*package:your_app_name/features/<feature_name>` (e.g., `grep -r "import.*features/settings" lib/`).

Analyze the results against these strict rules:

| Import Location | Allowed? | Reason / Condition |
| :--- | :--- | :--- |
| `core/routing/app_router.dart` | ✅ **Yes** | The core router needs to know about screen/page widgets to render routes. |
| `core/di/app_dependencies.dart` | ✅ **Yes** | The DI container must import data and domain classes to instantiate and inject them globally. |
| Another feature's `presentation` layer | ✅ **Yes (Conditional)** | Allowed **only** if importing a screen/page for UI navigation purposes, or importing a genuinely shared, isolated UI widget. |
| Another feature importing the `domain/models/` directory | ✅ **Yes** | Models defined in a domain layer represent core business entities. It's often necessary and acceptable for other features to import and utilize these models to share typed data across feature boundaries. |
| Another feature importing the `data` layer | ❌ **NO** | Feature A must never know how Feature B accesses its database or network API. |
| Another feature importing `domain/usecases/` or `domain/repositories/` | ❌ **NO (Usually)** | Features should be functionally cohesive. If Feature A needs Feature B's Use Cases or data repositories, consider whether the logic actually belongs in `core/` or if a shared parent domain is required. |

### 7. Final Cleanup
- Run `dart analyze` to catch any lingering semantic errors, unused imports, or broken enum references caused by the migration.
- If the feature utilizes code generation (like `freezed` or `json_serializable`), ensure you run `dart run build_runner build -d`.
