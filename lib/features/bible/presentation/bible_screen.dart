import 'package:flutter/material.dart';
import '../../data/bible_model.dart';
import 'widgets/verse_widget.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({Key? key}) : super(key: key);

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  // 샘플 데이터
  late BibleBook sampleBook;

  @override
  void initState() {
    super.initState();
    sampleBook = BibleBook(
      bookId: 1,
      bookName: "창세기",
      chapter: 1,
      verses: [
        Verse(verse: 1, text: "태초에 하나님이 천지를 창조하시니라"),
        Verse(verse: 2, text: "땅이 혼돈하고 공허하며 흑암이 깊음 위에 있고 하나님의 영은 수면 위에 운행하시니라"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${sampleBook.bookName} ${sampleBook.chapter}장'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sampleBook.verses.length,
        itemBuilder: (context, index) {
          final verse = sampleBook.verses[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: VerseWidget(verse: verse),
          );
        },
      ),
    );
  }
}
