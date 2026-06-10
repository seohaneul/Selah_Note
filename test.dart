import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('assets/bible.json');
  final content = file.readAsStringSync();
  final data = json.decode(content) as Map<String, dynamic>;
  final regex = RegExp(r'^([^\d]+)\d+:\d+');
  final Set<String> prefixes = {};
  for (var key in data.keys) {
    final match = regex.firstMatch(key);
    if (match != null) {
      prefixes.add(match.group(1)!);
    }
  }
  print(prefixes.toList().join(', '));
}
