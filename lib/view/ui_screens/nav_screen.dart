import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/cubits/search_cubit/search_cubit.dart';
import 'package:movie_nti_aug/view/ui_screens/search_screen.dart';
import 'package:movie_nti_aug/view/ui_screens/watch_list_screen.dart';
import 'home_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int index = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const WatchListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xff242A32)),
        backgroundColor: const Color(0xff242A32),
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontSize: 18),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home Screen", ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Watch List"),
          ],

          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
          backgroundColor: const Color(0xff242A32),
          selectedItemColor: const Color(0xff0296E5),
          unselectedItemColor: const Color(0xff67686D),
        ),
      ),
    );
  }
}
