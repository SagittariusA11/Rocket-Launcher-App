import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                searchLaunches(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by launch name, launchpad name, or rocket name',
              ),
            ),
          ),
          _isLoading
              ? CircularProgressIndicator()
              : Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]['name']),
                  onTap: () { },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> searchLaunches(String keyword) async {
    setState(() {
      _isLoading = true;
    });

    final launchesResponse = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches'));
    final rocketsResponse = await http.get(Uri.parse('https://api.spacexdata.com/v4/rockets'));
    final launchpadsResponse = await http.get(Uri.parse('https://api.spacexdata.com/v4/launchpads'));

    if (launchesResponse.statusCode == 200 &&
        rocketsResponse.statusCode == 200 &&
        launchpadsResponse.statusCode == 200) {
      final launchesData = json.decode(launchesResponse.body);
      final rocketsData = json.decode(rocketsResponse.body);
      final launchpadsData = json.decode(launchpadsResponse.body);

      // Filter launches based on keyword
      List<dynamic> filteredLaunches = launchesData.where((launch) {
        final launchName = launch['name'].toString().toLowerCase();
        final rocketName = rocketsData.firstWhere((rocket) => rocket['id'] == launch['rocket'])['name'].toString().toLowerCase();
        final launchpadName = launchpadsData.firstWhere((launchpad) => launchpad['id'] == launch['launchpad'])['name'].toString().toLowerCase();
        final searchKeyword = keyword.toLowerCase();

        return launchName.contains(searchKeyword) ||
            rocketName.contains(searchKeyword) ||
            launchpadName.contains(searchKeyword);
      }).toList();

      setState(() {
        _searchResults = filteredLaunches;
        _isLoading = false;
      });
    } else {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
    }
  }
}
