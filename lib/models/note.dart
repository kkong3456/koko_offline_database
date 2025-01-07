import 'package:isar/isar.dart';

part 'note.g.dart';

//this line is needed to generate file
//then run in termial : dart run build_runner build
@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
