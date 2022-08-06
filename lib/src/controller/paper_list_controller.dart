import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paper_checker/src/model/paper.dart';
import 'package:paper_checker/src/repository/paper_repository.dart';

final paperListProvider = FutureProvider<List<Paper>>((ref) async {
  final repository = MockPaperRepository();
  return await repository.getPapers(keyword: "keyword");
});
