import 'package:bloc_api/core/Model/Notes/GetNotes.dart';
import 'package:bloc_api/core/bloc/get_note_bloc/notes_bloc.dart';
import 'package:bloc_api/ui/view/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    BlocProvider.of<NotesBloc>(context).add(const UserNotesEvent(
      url: Urls.getNotes,
      userUuid: "acdf96be-ae8f-4647-8c22-314141ef716f",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
        title: Text(
          "Hey, ${Preferences.getString(Preferences.userName)}",
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
              return const CircularProgressIndicator();
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              itemBuilder: (context, index) {
                                final notes = getNotes.data!.data[index];

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                          color: const Color(0xffF3F3F3)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Title: --- ${notes.user!.collegeName}, \n Description: --- ${notes.user!.name}",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
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
          /*builder: (context, state) {
            if (state is NotesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotesSuccess) {
              return ValueListenableBuilder<GetNotes?>(
                valueListenable: notes,
                builder: (context, value, _) {
                  if (value != null && value.data!.data.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.data!.data.length,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        final college = value.data!.data[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border:
                                  Border.all(color: const Color(0xffF3F3F3)),
                            ),
                            child: Text(
                              "${college.uuid}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("No Data Found"));
                  }
                },
              );
            } else if (state is NotesFailed) {
              return const Center(child: Text("Failed to load notes"));
            } else {
              return const Center(child: Text("No Data Found"));
            }
          },*/
        ),
      ),
    );
  }
}
