import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/features/home/data/repositories/home_repository_impl.dart';
import 'package:movie_nti_aug/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:movie_nti_aug/features/nav/presentation/screens/nav_screen.dart';

import '../../../../core/network/dio_client.dart';
import '../../../home/data/data_sources/home_remote_data_source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    goToHome();
  }

  void goToHome() {
    Future.delayed(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) {
                  return HomeCubit(
                    HomeRepositoryImpl(
                      HomeRemoteDataSourceImpl(
                        DioClient(),
                      ),
                    ),
                  );
                },
                child: const NavScreen(),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242A32),
      body: Center(
        child: Image.asset(
          "assets/images/splash.png",
        ),
      ),
    );
  }
}