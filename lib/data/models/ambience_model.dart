import 'package:hive/hive.dart';

part 'ambience_model.g.dart';

@HiveType(typeId: 0)
class Ambience extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String tag;

  @HiveField(2)
  final int duration;

  @HiveField(3)
  final String audio;

  Ambience({
    required this.title,
    required this.tag,
    required this.duration,
    required this.audio,
  });

  factory Ambience.fromJson(Map<String, dynamic> json) {
    return Ambience(
      title: json['title'],
      tag: json['tag'],
      duration: json['duration'],
      audio: json['audio'],
    );
  }
}