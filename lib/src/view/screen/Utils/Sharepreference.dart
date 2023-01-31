import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/productItem.dart';

class MyPrefferenc {
  static SharedPreferences? _preferences;
  static Future onit() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future savetoken(String n) {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized.');
    }
    return _preferences!.setString("token", n);
  }

  static String? gettoken() {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized.');
    }
    return _preferences!.getString("token") ?? "";
  }

  static Future saveId(int n) {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized.');
    }
    return _preferences!.setInt("id", n);
  }

  static int? getId() {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized.');
    }
    return _preferences!.getInt("id") ?? 0;
  }

  static saveCart(data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('data', jsonEncode(data));
  }

  static getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('data');
    if (data != null) {
      final decodedData = jsonDecode(data);
      return decodedData;
    }
    return [];
  }

  static clear() async {
    await _preferences!.clear();
  }
}


// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../model/productItem.dart';

// class MyPrefferenc {
//   static SharedPreferences? _preferences;
//   static Future onit() async {
//     _preferences = await SharedPreferences.getInstance();
//   }

//   static Future savetoken(String n) {
//     if (_preferences == null) {
//       throw Exception('SharedPreferences not initialized.');
//     }
//     return _preferences!.setString("token", n);
//   }

//   static String? gettoken() {
//     if (_preferences == null) {
//       throw Exception('SharedPreferences not initialized.');
//     }
//     return _preferences!.getString("token") ?? "";
//   }

//   static Future saveId(int n) {
//     if (_preferences == null) {
//       throw Exception('SharedPreferences not initialized.');
//     }
//     return _preferences!.setInt("id", n);
//   }

//   static int? getId() {
//     if (_preferences == null) {
//       throw Exception('SharedPreferences not initialized.');
//     }
//     return _preferences!.getInt("id") ?? 0;
//   }

//   static Future<void> saveResultsToSharedPreferences(
//       List<Results> results) async {
//     final resultsJson = json.encode(results);
//     _preferences!.setString('results', resultsJson);
//   }

// // Load the list from SharedPreferences
//   static Future<List<Results>> loadResultsFromSharedPreferences() async {
//     final resultsJson = _preferences!.getString('results');
//     if (resultsJson != null) {
//       return (json.decode(resultsJson) as List)
//           .map((result) => Results.fromJson(result))
//           .toList();
//     } else {
//       return [];
//     }
//   }
//   // static saveCart(data) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   prefs.setString('data', jsonEncode(data));
//   // }

//   // static getCart() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final data = prefs.getString('data');
//   //   if (data != null) {
//   //     final decodedData = jsonDecode(data);
//   //     return decodedData;
//   //   }
//   //   return [];
//   // }

//   static clear() async {
//     await _preferences!.clear();
//   }
// }
