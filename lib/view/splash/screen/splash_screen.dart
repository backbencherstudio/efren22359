import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/services/token_storage.dart';
import '../../../cors/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TokenStorage _tokenStorage = TokenStorage();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));

      final String? token = await _tokenStorage.getToken();

      if (token != null) {
        Navigator.pushReplacementNamed(context, RouteName.sellerParentScreen);
      } else {
        Navigator.pushReplacementNamed(context, RouteName.onboardingScreen);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5D18EB),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/launcher.png',
            height: 236.h,
            width: 117.w,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
