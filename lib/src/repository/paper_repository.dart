import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:paper_checker/src/api/api.dart';
import 'package:paper_checker/src/api/mock.dart';
import 'package:paper_checker/src/model/paper.dart';

abstract class PaperRepository {
  Future<List<Paper>> getPapers({required String keyword});
}

class RestApiPaperRepository implements PaperRepository {
  RestApiPaperRepository({required this.api, required this.client});
  final CiNiiPaperAPI api;
  final http.Client client;

  @override
  Future<List<Paper>> getPapers({required String keyword}) async {
    final response = await client.get(api.papers(keyword));
    if (response.statusCode != 200) {
      throw Exception("Error occurred while using CiNii API");
    }
    final data = json.decode(response.body);
    final List<Map<String, dynamic>> items = data["items"];
    return items.map((e) => Paper.fromJson(e)).toList();
    }
}

class MockPaperRepository implements PaperRepository {
  MockPaperRepository();

  @override
  Future<List<Paper>> getPapers({required String keyword}) async {
    final data = mockHttpResponse;
    final List<Map<String, dynamic>> items = data["items"];
    return items.map((e) => Paper.fromJson(e)).toList();
  }
}
