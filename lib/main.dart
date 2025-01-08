import 'package:flutter/material.dart';
import 'package:koko_offline_database/models/note_database.dart';
import 'package:koko_offline_database/pages/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize(); //initialize database
  runApp(
    ChangeNotifierProvider(
      create: (_) => NoteDatabase(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
