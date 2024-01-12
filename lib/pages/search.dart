import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _searchKey = "";
  Iterable<Map<String, dynamic>> _productMap = [];
  
  @override
  void updateList() {
    fetchAlbum(search: _searchKey).then((value) {
      if (mounted) {
        if (value.statusCode == 200) {
          setState(() => _productMap = (convert.jsonDecode(value.body) as List<dynamic>).map((e) => {"place": e["name"]}));
        } else {
          setState(() => _productMap = []);
        }
      }
    });
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
          leadingWidth: 70,
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
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 42),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 32)),
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
                onChanged: (value) => setState(
                  // ignore: unnecessary_set_literal
                  () => {
                    _searchKey = value,
                    updateList()
                  }),
              ),
              Expanded(
                child: ListView(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 34)),
                  ..._getBody()
                ],
              )
              )
            ]
          )
        )
      )
    );
  }

  Future<http.Response> fetchAlbum({search}) {
    var response = http.get(Uri.parse('http://api.weatherapi.com/v1/search.json?key=f263e85559074b09be3192915241201&q=$search'));
    return response;
  }

  _getBody() {
    return _productMap.map((e) => Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.25),
            width: 1
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e["place"],
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontSize: 18,
              fontWeight: FontWeight.normal
            ),
          ),
          IconButton(
            onPressed: () {}, 
            icon:  const Icon(
              Icons.add,
              size: 24,
              weight: 32,
              color: Colors.white,
            ),
          )
        ],
      ),
    ));
  }
}
// f263e85559074b09be3192915241201