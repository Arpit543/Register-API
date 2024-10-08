import 'package:bloc_api/core/Model/Notes/GetNotes.dart';
import 'package:bloc_api/core/bloc/get_note_bloc/notes_bloc.dart';
import 'package:bloc_api/ui/view/Notes/upload_notes.dart';
import 'package:bloc_api/ui/view/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/service/shredPreferences.dart';
import '../../../core/service/urls.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ValueNotifier<GetNotes?> notes = ValueNotifier(null);
  ValueNotifier<bool> loader = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesBloc>(context).add(
      const UserNotesEvent(
        url: Urls.getNotes,
        userUuid: /*Preferences.getString(Preferences.userUuid) ?? ""*/
            "acdf96be-ae8f-4647-8c22-314141ef716f",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
        title: Text(
          "Hey, ${Preferences.getString(Preferences.userName)?.split(' ').first}",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Preferences.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: const Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<NotesBloc, NotesState>(
          listener: (context, state) {
            if (state is NotesLoading) {
              loader.value = true;
            } else if (state is NotesSuccess) {
              if (notes.value != null) {
                notes.value = state.getNotes;
              }
              loader.value = false;
            } else if (state is NotesFailed) {
              loader.value = false;
            }
          },
          builder: (context, state) {
            if (state is NotesLoading || state is NotesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotesSuccess) {
              notes.value = state.getNotes;
              return ValueListenableBuilder(
                valueListenable: notes,
                builder: (context, getNotes, _) {
                  return getNotes != null && getNotes.data!.data.isNotEmpty
                      ? ValueListenableBuilder(
                          valueListenable: loader,
                          builder: (context, loading, _) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: getNotes.data!.data.length,
                              itemBuilder: (context, index) {
                                final notes = getNotes.data!.data[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(children: [
                                            const TextSpan(
                                              text: "Name :",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " ${notes.user!.name}",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ]),
                                        ),
                                        Text.rich(
                                          TextSpan(children: [
                                            const TextSpan(
                                              text: "Uuid :",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " ${notes.user!.uuid}",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ]),
                                        ),
                                        Text.rich(
                                          TextSpan(children: [
                                            const TextSpan(
                                              text: "Role :",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " ${notes.user!.role}",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text("Data"),
                        );
                },
              );
            } else if (state is NotesFailed) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const Center(
                child: Text("noDataFound"),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const UploadNotes());
        },
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
