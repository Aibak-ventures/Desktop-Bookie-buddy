/// This file defines the IAppDependency interface, which is used to
/// register dependencies for different features in the application.
/// Each feature will implement this interface to provide its own dependencies,
/// and the AppDependencies class will call the register method of each
/// feature to set up the dependency injection.
abstract interface class IAppDependency {
  void register();
}
