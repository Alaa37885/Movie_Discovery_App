import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/cubits/home_cubit/home_cubit.dart';
import "package:carousel_slider/carousel_slider.dart";
// import 'package:movie_nti_aug/cubits/home_cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var isShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242A32),

      appBar: AppBar(
        backgroundColor: const Color(0xff242A32),
        title: const Text(
          "What do you want to watch?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
              children: [

                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    fillColor: const Color(0xff67686D),
                    filled: true,
                    suffixIcon: const Icon(Icons.search),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                //
                // ElevatedButton(
                //   onPressed: () {
                //     context.read<HomeCubit>().greet();
                //       isShow = !isShow;
                //
                //   },
                //   child: const Text("Get Started"),
                // ),
                //
                // if (isShow)
                //   const Text(
                //     "🤙",
                //     style: TextStyle(fontSize: 45),
                //   ),
                //
                // const SizedBox(height: 20),
                //
                // Row(
                //   children: [
                //     Image.asset(
                //       "assets/images/movie-1.png",
                //       width: 150,
                //       height: 210,
                //     ),
                //
                //     const SizedBox(width: 70),
                //
                //     Image.asset(
                //       "assets/images/movie-2.png",
                //       width: 150,
                //       height: 210,
                //     ),
                //   ],
                //
                // ),

                SizedBox(
                  height: 310,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeCarouselMovieLoading){
                        return CircularProgressIndicator();
                      }

                      return CarouselSlider(
                        items: [
                          Image.asset(
                            "assets/images/movie-1.png",
                            width: 150,
                            height: 210,
                            fit: BoxFit.cover,
                          ),

                          Image.asset(
                            "assets/images/movie-2.png",
                            width: 150,
                            height: 210,
                            fit: BoxFit.cover,
                          ),

                          Image.asset(
                            "assets/images/movie-1.png",
                            width: 150,
                            height: 210,
                            fit: BoxFit.cover,
                          ),
                        ],

                        options: CarouselOptions(
                          height: 300,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.5,
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
      )
    );
  }
}


// Rest API
// bloc provider على اعلى مستوى branch اول نقطه عندى فى الكود هو object screen
// bloc make a customize staet neither than set state عشوائية
// bloc builder اقدر اديها الكمية الل اعملها عادة بناء
// emit تقوم بعمل اعادة بناء لل state
// 1 plugin add , add packge (flutter bloc) , bloc provider , bloc builder
// expanded , listview , builder , separated (sized box)

