import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/env/env_config.dart';
import 'core/service_locator/service_locator.dart';
import 'common/theme/app_theme.dart';
import 'features/auth/presentation/ui/onboarding_screen.dart';
import 'features/auth/presentation/state/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables based on flavor
  await _loadEnvironment();
  
  // Validate configuration
  if (!EnvConfig.validateConfig()) {
    throw Exception('Invalid environment configuration');
  }
  
  // Print current environment configuration
  EnvConfig.printCurrentConfig();
  
  // Initialize dependencies
  await serviceLocatorInit();
  
  runApp(const MyApp());
}

Future<void> _loadEnvironment() async {
  // Get flavor from build arguments or SharedPreferences
  const String flavor = String.fromEnvironment('FLAVOR', defaultValue: 'development');
  
  // Determine which .env file to load
  String envFile;
  switch (flavor.toLowerCase()) {
    case 'production':
    case 'prod':
      envFile = '.env.production';
      break;
    case 'staging':
    case 'stage':
      envFile = '.env.staging';
      break;
    case 'development':
    case 'dev':
    default:
      envFile = '.env.development';
      break;
  }
  
  try {
    await dotenv.load(fileName: envFile);
    print('✅ Loaded environment: $envFile');
  } catch (e) {
    print('⚠️ Failed to load $envFile, falling back to .env.development');
    await dotenv.load(fileName: '.env.development');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone 13 Pro design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: MaterialApp(
            title: EnvConfig.appName,
            theme: _buildTheme(),
            home: const OnboardingScreen(),
            debugShowCheckedModeBanner: !EnvConfig.isProduction,
          ),
        );
      },
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppTheme.primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppTheme.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppTheme.textPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: AppTheme.textPrimaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.primaryColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppTheme.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppTheme.textSecondaryColor.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppTheme.textSecondaryColor.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
    );
  }
}
