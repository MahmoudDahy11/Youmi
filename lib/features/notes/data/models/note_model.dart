import 'package:isar/isar.dart';

part 'note_model.g.dart';

@Collection()
class NoteModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String title;

  late String markdownContent;

  List<String> tags = [];

  @Index()
  late bool pinned;

  late DateTime createdAt;

  late DateTime updatedAt;
}
