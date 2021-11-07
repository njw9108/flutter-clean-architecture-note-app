import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:note_app/ui/colors.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  late Color selectColor;
  late String title;
  late String content;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      selectColor = Color(widget.note!.color);
    } else {
      selectColor = roseBud;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();
    List<Color> colors = [roseBud, primrose, wisteria, skyBlue, illusion];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: selectColor,
        child: SafeArea(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: colors.map((e) => buildColors(e)).toList(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter title...',
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 15,
                  style: TextStyle(fontSize: 25, color: Colors.black),
                  decoration: InputDecoration(
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

  Widget buildColors(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: (selectColor == color)
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
}
