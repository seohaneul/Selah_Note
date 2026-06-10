class BibleBook {
  final int bookId;
  final String bookName;
  final int chapter;
  final List<Verse> verses;

  BibleBook({
    required this.bookId,
    required this.bookName,
    required this.chapter,
    required this.verses,
  });

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    return BibleBook(
      bookId: json['bookId'],
      bookName: json['bookName'],
      chapter: json['chapter'],
      verses: (json['verses'] as List)
          .map((v) => Verse.fromJson(v))
          .toList(),
    );
  }
}

class Verse {
  final int verse;
  final String text;

  Verse({
    required this.verse,
    required this.text,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      verse: json['verse'],
      text: json['text'],
    );
  }
}
