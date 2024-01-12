import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Search for City',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontSize: 32,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 42, 24, 42),
          child: ListView(
            children: [
              TextField(
                  style: const TextStyle(
                    color: Color.fromRGBO(140, 140, 140, 1),
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for a city...',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(140, 140, 140, 1),
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color.fromRGBO(140, 140, 140, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
            ]
          )
        )
      )
    );
  }
}
