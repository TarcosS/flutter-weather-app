import 'package:flutter/material.dart';
import 'package:weather_app/components/slide_animation.dart';
import 'package:weather_app/pages/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7EA9E9),
              Color(0xFF131C6C),
            ],
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 90,
          title: const Text(
            'Weather App',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontSize: 32,
              fontWeight: FontWeight.w700
            ),
          ),
          leading: IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                fixedSize: MaterialStateProperty.all<Size>(const Size(40, 40)),
              ),
              icon: const Icon(
                Icons.add,
                size: 24,
                weight: 32,
                color: Color(0xFF7EA9E9),
              ),
              onPressed: () => Navigator.push(
                context, 
                SlideAnimationRoute(page: const Home(), route: const Search())
              ),
          ),
          actions: [
            Padding(padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(40, 40)),
                ),
                icon: const Icon(
                  Icons.grid_view_rounded,
                  color: Color(0xFF7EA9E9),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
        body: ListView(
          children: [

          ]
        )
      )
    );
  }
}
