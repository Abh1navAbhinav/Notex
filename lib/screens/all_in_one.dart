// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex/database/db_functions.dart';
import 'package:notex/notex_model/note_model.dart';
import 'package:notex/styles/styles.dart';
import 'package:notex/widgets/snack_bar.dart';
import '../main.dart';

class AllInOneScreen extends StatefulWidget {
  AllInOneScreen({
    Key? key,
    this.model,
  }) : super(key: key);

  NoteModel? model;

  @override
  State<AllInOneScreen> createState() => _AllInOneScreenState();
}

class _AllInOneScreenState extends State<AllInOneScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    if (isEditing) {
      titleController.text = widget.model!.title;
      contentController.text = widget.model!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Styles().scaffoldColor(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 97, 103),
          title: Text.rich(
            TextSpan(
              children: [
                !isViewing
                    ? TextSpan(
                        text: 'Edit : ',
                        style: GoogleFonts.signikaNegative(
                          fontSize: 25,
                          color: const Color.fromARGB(255, 0, 230, 246),
                        ),
                      )
                    : const TextSpan(
                        text: '',
                      ),
                TextSpan(
                  text: title,
                  style: GoogleFonts.quicksand(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            isViewing
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        title = widget.model!.title;
                        isEditing = true;
                        isViewing = false;
                      });
                    },
                    icon: const Icon(
                      Icons.edit_note_rounded,
                    ),
                  )
                : const Text(''),
          ],
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 19,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 8,
                  ),
                  child: !isViewing
                      ? Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 8, 42, 58),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: titleController,
                            readOnly: isViewing,
                            decoration: InputDecoration(
                              hintText: 'Title',
                              hintStyle:
                                  GoogleFonts.roboto(color: Colors.white60),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                        )
                      : const SizedBox(
                          height: 20,
                        )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 19,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 0, 230, 246),
                  ),
                  child: TextFormField(
                    controller: contentController,
                    readOnly: isViewing,
                    decoration: InputDecoration(
                      hintText: 'Enter the notes...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                    ),
                    maxLines: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 19,
                  left: MediaQuery.of(context).size.width / 1.5,
                  right: 8,
                ),
                child: isViewing
                    ? null
                    : isEditing
                        ? FloatingActionButton.extended(
                            onPressed: () {
                              addNote();
                            },
                            label: const Text(
                              'Update',
                            ),
                            icon: const Icon(Icons.update_rounded),
                            backgroundColor:
                                const Color.fromARGB(255, 8, 42, 58),
                          )
                        : FloatingActionButton.extended(
                            onPressed: () {
                              addNote();
                            },
                            label: const Text(
                              'Submit',
                            ),
                            icon: const Icon(Icons.upload_file_outlined),
                            backgroundColor:
                                const Color.fromARGB(255, 8, 42, 58),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addNote() async {
    final noteTitle = titleController.text;
    final noteContent = contentController.text;

    if (noteTitle.isEmpty) {
      return showSnackbar(
        context: context,
        text: 'Note title is empty',
      );
    }
    if (noteContent.isEmpty) {
      return showSnackbar(
        context: context,
        text: 'Note Content is empty',
      );
    }
    final noteModel = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: noteTitle,
      content: noteContent,
    );
    isEditing
        ? NoteDb.instance.updateNote(value: noteModel)
        : NoteDb.instance.addNoteDb(noteModel);
    NoteDb.instance.refreshNoteUi();

    Get.back();
    showSnackbar(
      context: context,
      text: isEditing ? 'Note updated succefully' : 'Note added succesfully',
      textcolor: Colors.green,
    );
  }
}
