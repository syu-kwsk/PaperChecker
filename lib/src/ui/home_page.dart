import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paper_checker/src/controller/paper_list_controller.dart';
import 'package:paper_checker/src/model/paper.dart';
import 'package:paper_checker/src/utils/app_colors.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        centerTitle: true,
        title: Text(title, style: const TextStyle(color: AppColors.fontMain),),
      ),
      body: Column(
        children: const [
          Padding(padding: EdgeInsets.all(8.0), child: SearchField(),),
          Flexible(child: PaperListView(),),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.only(left: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.bgMain,
        border: Border.all(color: AppColors.appBar, width: 2.0),
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '検索ワード',
          hintStyle: TextStyle(fontSize: 16.0, color: AppColors.fontMain),
        ),
      ),
    );
  }
}

class PaperListView extends ConsumerWidget {
  const PaperListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paperList = ref.watch(paperListProvider);
    return paperList.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) {
        debugPrint('$stack');
        return Text('Error: $err');
      },
      data: (paperList) {
        return ListView.builder(
          itemCount: paperList.length,
          itemBuilder: (BuildContext context, int index) {
            return PaperCard(paper: paperList[index],);
          },
        );
      },
    );
  }
}

class PaperCard extends StatelessWidget {
  const PaperCard({Key? key, required this.paper}) : super(key: key);
  final Paper paper;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appBar),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(paper.title, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
          const SizedBox(height: 8.0,),
          Text("date: ${paper.date}"),
          const SizedBox(height: 8.0,),
          Text("publisher: ${paper.doi}"),
          const SizedBox(height: 8.0,),
          Text("link: ${paper.link}"),
        ],
      ),
    );
  }
}
