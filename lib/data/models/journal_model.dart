import 'package:hive/hive.dart';

part 'journal_model.g.dart';

@HiveType(typeId: 0)
class JournalEntry extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  String mood;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String ambience;

  JournalEntry({
    required this.text,
    required this.mood,
    required this.date,
    required this.ambience,
  });
}