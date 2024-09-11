import 'package:flutter/material.dart';
import 'package:google_keep/functions/functions.dart';
import 'package:google_keep/models/data.dart';

class Editpage extends StatefulWidget {
  String? title;
  String? description;
  int index;
  Editpage({
    super.key,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                onSubmitted: (value) {
                  updateAll();
                  Navigator.pop(context);
                },
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), 
                        ),
                      ],
                    ),
                    child: TextField(
                      onSubmitted: (value) {
                        updateAll();
                        Navigator.pop(context);
                      },
                      controller: _descriptionController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Enter your description here...',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     updateAll();
                  //   },
                  //   child: Text("Edit"),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateAll() async {
    final titlee = _titleController.text;
    final descriptione = _descriptionController.text;

    final update = Data(title: titlee, description: descriptione);
    editData(widget.index, update);
  }
}
