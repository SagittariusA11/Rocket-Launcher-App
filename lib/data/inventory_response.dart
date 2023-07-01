
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../view models/inventoryViewModel.dart';

class InventoryService {
  static Future<List<RocketListInventory>> fetchallRockets() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/rockets'));
    if (response.statusCode == 200) {
      final rocketJson = json.decode(response.body) as List<dynamic>;
      final rockets = rocketJson.map((json) => RocketListInventory.fromJson(json)).toList();
      return rockets;
    } else {
      throw Exception('Failed to fetch upcoming launches.');
    }
  }

  static Future<List<StarlinkListInventory>> fetchallStarlink() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/starlink'));
    if (response.statusCode == 200) {
      final starlinksJson = json.decode(response.body) as List<dynamic>;
      final starlinks = starlinksJson.map((json) => StarlinkListInventory.fromJson(json)).toList();
      return starlinks;
    } else {
      throw Exception('Failed to fetch upcoming launches.');
    }
  }

}