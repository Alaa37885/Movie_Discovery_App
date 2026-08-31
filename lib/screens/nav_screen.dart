import 'package:flutter/material.dart';
import 'package:movie_nti_aug/screens/home_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int index = 0;
  List<Widget>screens=[
    HomeScreen(),
    Container(
        child: Center(child: Text("Search" , style: TextStyle(color: Colors.white,),),
  ))  ,
    Container(
        child: Center(child: Text("BookMark" , style: TextStyle(color: Colors.white,),),
  ))

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff242A32),),
      backgroundColor: Color(0xff242A32) ,
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home) , label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search) , label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark) , label: ""),
        ],

        onTap: (value){
          print(value);
          index = value;
          setState(() {

          });
        },

        currentIndex: index,
        backgroundColor: Color(0xff242A32),
        selectedItemColor:  Color(0xff0296E5) ,
        unselectedItemColor: Color(0xff67686D),

      ),
    );
  }
}
