import 'package:flutter/material.dart';
import 'package:koko_offline_database/models/note.dart';
import 'package:koko_offline_database/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();
  //create a note
  void createNote() {
    textController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteDatabase>().addNote(textController.text);
              Navigator.of(context).pop();
            },
            child: const Text('CREATE'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('CANCEL'),
          ),
        ],
      ),
    );
  }

  //read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //update a note
  void updateNote(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Note'),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);

              //clear controller
              //textController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('UPDATE'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('CANCEL'),
          )
        ],
      ),
    );
  }

  //delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readNotes();
  }

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();
    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          //get individual note
          final note = currentNotes[index];
          return ListTile(
              title: Text(note.text),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => updateNote(note),
                    icon: const Icon(Icons.edit),
                  ),
                  //delete button
                  IconButton(
                    onPressed: () => deleteNote(note.id),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
