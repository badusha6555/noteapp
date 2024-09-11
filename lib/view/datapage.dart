import 'package:flutter/material.dart';
import 'package:google_keep/models/data.dart';

class dataPage extends StatefulWidget {
  String? title;
  String? description;

  dataPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<dataPage> createState() => _dataPageState();
}

class _dataPageState extends State<dataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Note'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    widget.title ?? "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.description ?? "",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
