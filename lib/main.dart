import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/core/theme/app_theme.dart';
import 'package:movie_nti_aug/features/watchlist/presentation/cubits/watchlist_cubit/watchlist_cubit.dart';
import 'package:movie_nti_aug/features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchlistCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        theme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
