import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:note_app/ui/colors.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  StreamSubscription? _streamSubscription;

  final colorList = [
    roseBud.value,
    primrose.value,
    wisteria.value,
    skyBlue.value,
    illusion.value
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();

      //구독
      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(
            saveNote: () {
              Navigator.pop(context,true);
            },
            showSnackBar: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.black,
                ),
              );
            });
      });

      if(widget.note!=null){
        _titleController.text = widget.note!.title;
        _contentController.text = widget.note!.content;
        viewModel.onEvent(AddEditNoteEvent.changeColor(widget.note!.color));
      }

    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.onEvent(AddEditNoteEvent.saveNote(
            widget.note?.id,
            _titleController.text,
            _contentController.text,
          ));
        },
        child: const Icon(Icons.save),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: AnimatedContainer(
          color: Color(viewModel.color),
          duration: const Duration(milliseconds: 500),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: colorList
                    .map((color) => InkWell(
                          onTap: () {
                            _changeBackgroundColor(color);
                          },
                          child: buildBackgroundSelector(
                              color, viewModel.color == color),
                        ))
                    .toList(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _titleController,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter title...',
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _contentController,
                  maxLines: 15,
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter some content',
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackgroundSelector(int color, bool selected) {
    return Container(
      decoration: BoxDecoration(
        color: Color(color),
        shape: BoxShape.circle,
        border: (selected == true)
            ? Border.all(color: Colors.black, width: 3)
            : null,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      margin: const EdgeInsets.all(10),
      width: 50,
      height: 50,
    );
  }

  void _changeBackgroundColor(int color) {
    final viewModel = context.read<AddEditNoteViewModel>();
    viewModel.onEvent(AddEditNoteEvent.changeColor(color));
  }
}
