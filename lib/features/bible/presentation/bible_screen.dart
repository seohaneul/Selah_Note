import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/bible_model.dart';
import 'widgets/verse_widget.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({Key? key}) : super(key: key);

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  BibleBook? bibleBook;

  @override
  void initState() {
    super.initState();
    _loadBibleData();
  }

  Future<void> _loadBibleData() async {
    // 실제 에셋 파일에서 읽어옵니다.
    final String response = await rootBundle.loadString('assets/bible_genesis_1.json');
    final data = await json.decode(response);
    setState(() {
      bibleBook = BibleBook.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (bibleBook == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${bibleBook!.bookName} ${bibleBook!.chapter}장'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        itemCount: bibleBook!.verses.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final verse = bibleBook!.verses[index];
          return VerseWidget(verse: verse, bookId: bibleBook!.bookId, chapter: bibleBook!.chapter);
        },
      ),
    );
  }
}
