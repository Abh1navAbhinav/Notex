import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notex/database/db_functions.dart';
import 'package:notex/main.dart';
import 'package:notex/notex_model/note_model.dart';
import 'package:notex/widgets/snack_bar.dart';

class AllController extends GetxController {
  NoteModel? model;
  int? index;
  final noteControlr = Get.put(NoteDb());

  final titleController = TextEditingController();
  final contentController = TextEditingController();



  Future<void> addNote(context) async {
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
    isEditing.value
        ? model!.updateNoteDb(noteModel)
        : noteControlr.addNoteDb(noteModel);
    noteControlr.refreshNoteUi();

    Get.back();
    showSnackbar(
      context: context,
      text: isEditing.value
          ? 'Note updated succefully'
          : 'Note added succesfully',
      textcolor: Colors.green,
    );
  }
}
