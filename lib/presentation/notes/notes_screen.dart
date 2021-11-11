import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:note_app/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Note',
          style: TextStyle(fontSize: 28),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.dehaze),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddEditNoteScreen(note: null)),
          );
        },
        child: const Icon(Icons.add),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          children: state.notes
              .map((note) => Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(note.color),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEditNoteScreen(
                                    note: note,
                                  )),
                        );
                      },
                      title: Text(
                        note.title,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        note.content,
                        style:
                            const TextStyle(fontSize: 21, color: Colors.black),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        color: Colors.black,
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
