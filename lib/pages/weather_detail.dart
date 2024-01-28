import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/components/photo_hero.dart';

class WeatherDetail extends StatefulWidget {
  final place;
  const WeatherDetail({super.key, required this.place}) ;

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  @override
  Widget build(BuildContext context){
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
          leadingWidth: 70,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
              icon: const Icon(
                Icons.chevron_left_outlined,
                size: 32,
                weight: 32,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
          ),
          title: Text(
            widget.place["location"]["name"],
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontSize: 32,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        body: Container(
          child: WeatherDetailHeader(
            child: ListView(
              children: [
                ListContainer(widget.place)
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  Container ListContainer(country) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      margin: const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 18, 24, 32),
              Color.fromARGB(255, 51, 60, 140),
            ],
          )
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country["current"]["temp_c"].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 64,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    const Text(
                      "°C",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 32,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
                Text(
                  country["location"]["name"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 36,
                    fontWeight: FontWeight.w600
                  )
                ),
                Text(
                  country["current"]["last_updated"].split(" ")[1] + " PM",
                  style: const TextStyle(
                    color: Color(0xFFE4E4E4),
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w300
                  )
                )
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'images${country["current"]["condition"]["icon"].split("64x64")[1].split(".")[0]}.png',
                  width: 130,
                  fit: BoxFit.cover,
                ),
                Text(
                  country["current"]["condition"]["text"],
                  style: const TextStyle(
                    color: Color(0xFFE4E4E4),
                    fontFamily: "Roboto",
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}