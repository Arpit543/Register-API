import 'dart:io';

import 'package:bloc_api/core/bloc/upload_notes_bloc/note_upload_bloc.dart';
import 'package:bloc_api/core/service/shredPreferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/bloc/subject_bloc/subject_bloc.dart';
import '../../../core/service/urls.dart';
import '../../widget/common_button.dart';
import '../../widget/common_snackbar.dart';
import '../../widget/common_textfield.dart';
import 'dash_board.dart';

class UploadNotes extends StatefulWidget {
  const UploadNotes({super.key});

  @override
  State<UploadNotes> createState() => _UploadNotesState();
}

class _UploadNotesState extends State<UploadNotes> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController subjectsController = TextEditingController();

  late final ImagePicker imagePicker = ImagePicker();
  File? imageFile;
  File? audioFile;
  File? pdfFile;
  String? subjectUuid;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SubjectBloc>(context).add(UserSubjectEvent(
      url: Urls.subject,
      uuid: Preferences.getString(Preferences.streamUuid) ?? "",
    ));
  }

  void _pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Use FileType.custom
      allowedExtensions: ['mp3', 'mp4'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        audioFile = File(result.files.first.path!);
      });
    }
  }

  void _pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Use FileType.custom
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        pdfFile = File(result.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text("Upload Notes", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomField(
                  controller: subjectsController,
                  hint: "Subject",
                  autofillHints: const [AutofillHints.postalAddress],
                  keyboardType: TextInputType.text,
                  isBottomSpace: true,
                  readOnly: true,
                  onTap: subjectBottomSheet,
                ),
                const SizedBox(height: 20),
                CustomField(
                  controller: titleController,
                  hint: "Title",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                CustomField(
                  controller: descriptionController,
                  hint: "Description",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                _buildFilePickerCard(
                    imageFile != null
                        ? imageFile!.path.split('/').last
                        : 'Select Images',
                    Icons.image,
                    _pickImage),
                const SizedBox(height: 20),
                _buildFilePickerCard(
                    audioFile != null
                        ? audioFile!.path.split('/').last
                        : 'Select Audio',
                    Icons.audio_file,
                    _pickAudio),
                const SizedBox(height: 20),
                _buildFilePickerCard(
                    pdfFile != null
                        ? pdfFile!.path.split('/').last
                        : 'Select PDF',
                    Icons.picture_as_pdf,
                    _pickPDF),
                const SizedBox(height: 20),
                BlocListener<NoteUploadBloc, NoteUploadState>(
                  listener: (context, state) {
                    if (state is NoteUploadSuccess) {
                      showSnackBar(
                          isError: false,
                          message: state.commonModel.message!,
                          context: context);
                      Get.to(const DashboardScreen());
                    } else if (state is NoteUploadFailed) {
                      showSnackBar(
                          isError: true,
                          message: state.error,
                          context: context);
                    }
                  },
                  child: CustomBtn(
                    loading: false,
                    name: "Upload Note",
                    onTap: () {
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        BlocProvider.of<NoteUploadBloc>(context).add(
                          UserUploadEvent(
                            url:
                                "http://theguruchela.sumayinfotech.com/api/upload-notes",
                            body: {
                              "user_uuid":
                                  Preferences.getString(Preferences.userUuid),
                              "subject_uuid": subjectUuid,
                              "title": titleController.text,
                              "description": descriptionController.text,
                              "image_file": imageFile!.path,
                              "pdf_file": pdfFile!.path,
                              "audio_file": audioFile!.path,
                            },
                          ),
                        );
                        Get.to(const DashboardScreen());
                      } else {
                        showSnackBar(
                            isError: false,
                            message: "Please fill & select all field!",
                            context: context);
                      }
                    },
                    borderColor: Colors.black,
                    textColor: Colors.white,
                    btnColor: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card _buildFilePickerCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      color: Colors.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black26),
        ),
        trailing: Icon(icon, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void subjectBottomSheet() {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Subjects",
                        style: TextStyle(
                            fontSize: 20, overflow: TextOverflow.ellipsis),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 5, color: Colors.black),
                Expanded(
                  child: BlocBuilder<SubjectBloc, SubjectState>(
                    builder: (context, state) {
                      if (state is SubjectLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SubjectSuccess) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.subject.data!.length,
                          itemBuilder: (context, index) {
                            final name = state.subject.data![index].title ?? "";
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(name),
                                  onTap: () {
                                    subjectsController.text = name;
                                    subjectUuid =
                                        state.subject.data![index].uuid ?? "";
                                    Navigator.pop(context);
                                  },
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          },
                        );
                      } else if (state is SubjectFailed) {
                        return const Center(
                            child: Text("Failed to load subjects"));
                      } else {
                        return const Center(child: Text("No subjects found"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
