import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:todolistapp/commons/route/app_route.dart';
import 'package:todolistapp/feature/home/presentation/pages/home_page.dart';


import '../bloc/splashcubit.dart';
import '../bloc/splashstate.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.withOpacity(0.5),
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccessState) {
            AppRoute().navigateTo(context, HomePage());
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Carousel displaying two images
              CarouselSlider(
                options: CarouselOptions(
                  height: 400, // Height of the carousel
                  autoPlay: true, // Enable auto play
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,// Enlarge the active item
                  autoPlayInterval: Duration(seconds: 3), // Interval for auto play
                ),
                items: [
                  // First image
                  Image.asset(
                    'assets/images/img.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  // Second image
                  Image.asset(
                    'assets/images/img_1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Image.asset(
                    'assets/images/img_2.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
