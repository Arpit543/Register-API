import 'package:flutter/material.dart';

class UploadNotes extends StatefulWidget {
  const UploadNotes({super.key});

  @override
  State<UploadNotes> createState() => _UploadNotesState();
}

class _UploadNotesState extends State<UploadNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Upload Notes"),
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
