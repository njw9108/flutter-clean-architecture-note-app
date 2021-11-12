import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:note_app/presentation/notes/components/note_list_widget.dart';
import 'package:note_app/presentation/notes/notes_event.dart';
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
        onPressed: () async {
          bool? isChanged = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const AddEditNoteScreen(note: null)),
          );
          if (isChanged != null && isChanged) {
            viewModel.onEvent(const NotesEvent.loadNotes());
          }
        },
        child: const Icon(Icons.add),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          children: state.notes
              .map((note) => NoteListWidget(
                    note: note,
                    onNoteTap: (note) async {
                      await _noteTap(context, note, viewModel);
                    },
                    onDeleteTap: (note) {
                      _noteDelete(viewModel, note, context);
                    },
                  ))
              .toList()),
    );
  }

  void _noteDelete(NotesViewModel viewModel, Note note, BuildContext context) {
    viewModel.onEvent(NotesEvent.deleteNote(note));
    final snackBar = SnackBar(
      content: const Text('선택한 노트를 삭제 했습니다.'),
      action: SnackBarAction(
        label: '취소',
        onPressed: () {
          viewModel.onEvent(const NotesEvent.restoreNote());
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _noteTap(
      BuildContext context, Note note, NotesViewModel viewModel) async {
    bool? isChanged = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditNoteScreen(note: note)),
    );
    if (isChanged != null && isChanged) {
      viewModel.onEvent(const NotesEvent.loadNotes());
    }
  }
}
