import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart';

import '../models/cases.dart';

class ApiService {
  final String url = 'http://10.211.55.8:8080/flutter'; //Android
  //final String url = 'http://localhost:8080/flutter'; //iOS


  Future<List<Cases>> allCases() async {
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      dev.log("inspection: ${dev.inspect(body)}");

      List<Cases> cases = body.map((e) => Cases.fromJson(e)).toList();

      dev.log("List of cases: ${cases.toString()}");

      return cases;
    }
    throw "Failed to load API resources";
  }

  Future<Cases> findCaseById(String id) async {
    final response = await get(Uri.parse('$url/$id'));

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    }

    throw Exception("Unable to find a case");
  }

  Future<Cases> createCase(Cases cass) async {
    Map data = {
      'name': cass.name,
      'gender': cass.gender,
      'age': cass.age,
      'address': cass.address,
      'city': cass.city,
      'country': cass.country,
      'status': cass.status
    };

    final Response response = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create the case.');
  }

  Future<Cases> updateCase(int id, Cases cass) async {
    Map data = {
      'name': cass.name,
      'gender': cass.gender,
      'age': cass.age,
      'address': cass.address,
      'city': cass.city,
      'country': cass.country,
      'status': cass.status
    };

    final Response response = await put(
      Uri.parse('$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    }
    throw Exception("Unable to update the case.");
  }

  void deleteCase(int? id) async {
    Response response = await delete(Uri.parse('$url/$id'));

    if (response.statusCode == 200) {
      dev.log("Case has been successfully deleted!");
    }
  }

}
