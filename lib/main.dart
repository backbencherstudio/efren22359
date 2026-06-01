import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'cors/provider/app_provider.dart';
import 'cors/routes/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.openBox('userBox');
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.getProviders(),
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: AppRoutes.routes,
            // Use the static routes map directly
            onUnknownRoute: (settings) {
              debugPrint(
                'Attempted to navigate to unknown route: ${settings.name}',
              );
              return MaterialPageRoute(
                builder:
                    (context) => Scaffold(
                  appBar: AppBar(title: const Text('Route Error')),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No route defined for: ${settings.name}'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed:
                              () => Navigator.pushNamed(context, '/'),
                          child: const Text('Go to Home'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            navigatorObservers: [HeroController()],
          );
        },
      ),
    );
  }
}