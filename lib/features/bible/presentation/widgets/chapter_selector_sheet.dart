import 'package:flutter/material.dart';
import '../../data/bible_repository.dart';

class ChapterSelectorSheet extends StatefulWidget {
  final String initialBook;
  final Function(int chapterIndex, int verseNumber) onVerseSelected;

  const ChapterSelectorSheet({
    Key? key,
    required this.initialBook,
    required this.onVerseSelected,
  }) : super(key: key);

  @override
  State<ChapterSelectorSheet> createState() => _ChapterSelectorSheetState();
}

class _ChapterSelectorSheetState extends State<ChapterSelectorSheet> {
  late String _selectedBook;
  int? _selectedChapter; // null이면 권/장 선택 단계, 숫자가 있으면 절 선택 단계

  @override
  void initState() {
    super.initState();
    _selectedBook = widget.initialBook;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_selectedChapter == null)
                  const Text(
                    '이동할 장 선택',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                else
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            _selectedChapter = null;
                          });
                        },
                      ),
                      Text(
                        '${BibleRepository.getFullName(_selectedBook)} $_selectedChapter장 - 절 선택',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _selectedChapter == null ? _buildBookChapterSelector() : _buildVerseSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookChapterSelector() {
    return Row(
      children: [
        SizedBox(
          width: 130,
          child: ListView.builder(
            itemCount: BibleRepository.books.length,
            itemBuilder: (context, index) {
              final book = BibleRepository.books[index];
              final isSelected = book == _selectedBook;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedBook = book;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
                  child: Text(
                    BibleRepository.getFullName(book),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black87,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: BibleRepository.bookMaxChapters[_selectedBook] ?? 0,
            itemBuilder: (context, index) {
              final chapter = index + 1;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedChapter = chapter;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$chapter',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVerseSelector() {
    String chapKey = "$_selectedBook$_selectedChapter";
    int maxVerse = BibleRepository.chapterMaxVerses[chapKey] ?? 0;
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.0,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: maxVerse,
      itemBuilder: (context, index) {
        final verse = index + 1;
        return InkWell(
          onTap: () {
            final targetIndex = BibleRepository.allChapters.indexWhere(
              (entry) => entry.key == _selectedBook && entry.value == _selectedChapter
            );
            if (targetIndex != -1) {
              widget.onVerseSelected(targetIndex, verse);
              Navigator.pop(context);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            ),
            alignment: Alignment.center,
            child: Text(
              '$verse',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
