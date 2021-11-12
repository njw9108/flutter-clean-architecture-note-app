import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';

class NoteListWidget extends StatelessWidget {
  final Note note;
  final void Function(Note note)? onDeleteTap;
  final void Function(Note note)? onNoteTap;

  const NoteListWidget({
    Key? key,
    required this.note,
    this.onDeleteTap,
    this.onNoteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(note.color),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: ListTile(
        onTap: () async {
          onNoteTap?.call(note);
        },
        title: Text(
          note.title,
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text(
          note.content,
          style: const TextStyle(fontSize: 21, color: Colors.black),
        ),
        trailing: IconButton(
          onPressed: () {
            onDeleteTap?.call(note);
          },
          icon: const Icon(Icons.delete),
          color: Colors.black,
        ),
      ),
    );
  }
}
