import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/database/db_functions.dart';
import 'package:notex/main.dart';
import 'package:notex/screens/all_in_one.dart';
import 'package:notex/styles/styles.dart';
import 'package:notex/widgets/note_grid.dart';

import '../notex_model/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    NoteDb.instance.refreshNoteUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: Styles().scaffoldColor()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 97, 103),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Note',
                  style: GoogleFonts.chewy(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 0, 230, 246),
                  ),
                ),
                TextSpan(
                  text: 'X',
                  style: GoogleFonts.chewy(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 8, 42, 58),
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          leading: const Icon(Icons.home_rounded),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                  valueListenable: noteModelNotifier,
                  builder: (BuildContext context, List<NoteModel> newList, _) {
                    return newList.isEmpty
                        ? const Center(child: Text('No Notes Added'))
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: newList.length,
                            itemBuilder: (context, index) {
                              final values = newList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      title = values.title;
                                      isViewing = true;
                                      isEditing = true;
                                    });
                                    Get.to(
                                      () => AllInOneScreen(
                                        index: index,
                                        model: values,
                                      ),
                                    );
                                  },
                                  child: NoteGrid(
                                    content: values.content,
                                    title: values.title,
                                    id: values.id,
                                  ),
                                ),
                              );
                            },
                          );
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 8, 42, 58),
          onPressed: () {
            setState(() {
              isEditing = false;
              isViewing = false;
              title = 'Add New Note';
            });
            // NoteDb.instance.refreshNoteUi();
            Get.to(() => AllInOneScreen());
          },
          label: const Text('Add'),
          icon: const Icon(Icons.note_alt_outlined),
        ),
      ),
    );
  }
}
