import 'package:flutter/material.dart';
import 'package:weather_app/components/photo_hero.dart';
import 'package:weather_app/components/slide_animation.dart';
import 'package:weather_app/pages/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weather_app/pages/weather_detail.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> _selectedCountries = [];

  @override
  void initState() {
    super.initState();
    updateSelectedCountries();
  }
  
  void updateSelectedCountries() {
    getSelectedCountries().then((countries) {
      setState(() {
        _selectedCountries = countries;
      });
    });
  }

  getSelectedCountries({country}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? selectedCountries = prefs.getStringList('selectedCountries');
    if(selectedCountries != null) {
      return selectedCountries;
    } else {
      return [];
    }
  }

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
          title: (const Text(
            'Weather App',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontSize: 32,
              fontWeight: FontWeight.w700
            ),
          )),
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
                SlideAnimationRoute(page: const Home(), route: Search(updateHomeFunction: updateSelectedCountries))
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 29),
          child: RefreshIndicator(
            child: true ? _getBody() : Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("No cities added yet!", style: TextStyle(color: Colors.white60, fontSize: 16),)],),
            color: Colors.blue.shade900,
            onRefresh: () {
              updateSelectedCountries();
              return Future<void>.value();
            },              
          )
        )
      )
    );
  }

  _getBody() {
    return ListView.builder(
    itemCount: _selectedCountries.length,
    itemBuilder: (context, index) {
      return Dismissible (
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        movementDuration: Duration(milliseconds: 500),
        background: Container(
          color: Colors.red.shade400,
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child:  Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontSize: 18,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onDismissed: (DismissDirection direction) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String>? selectedCountries = prefs.getStringList('selectedCountries');
          if(selectedCountries != null) {
            selectedCountries.remove(_selectedCountries[index]);
            prefs.setStringList('selectedCountries', selectedCountries);
          } else {
            [];
          }
        },
        child: FutureBuilder(
          future: fetchOnlyWeather(query: _selectedCountries[index]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // loading spinner
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var country = convert.jsonDecode(snapshot.data!.body);

              return GestureDetector(
                onTap: () => {
                  
                },
                child: WeatherDetailHeader(
                  child: ListContainer(country),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<void>( builder: (context) => WeatherDetail(place: country)));
                  },
                ),
              );
            }
          },
        ),
      );
    },
  );
  }

  Container ListContainer(country) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.3),
            width: 1.5
          )
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

  Future<http.Response> fetchOnlyWeather({query}) {
    var response = http.get(Uri.parse('http://api.weatherapi.com/v1/current.json?key=f263e85559074b09be3192915241201&q=$query'));
    return response;
  }
}
