// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member


import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notex/main.dart';
import 'package:notex/notex_model/note_model.dart';

class NoteDb extends GetxController {
 List<NoteModel> noteModelList = [];
  
  // NoteDb._internal();
  // static NoteDb instance = NoteDb._internal();

  // factory NoteDb() {
  //   return instance;
  // }

  Future<void> addNoteDb(NoteModel obj) async {
    final dB = await Hive.openBox<NoteModel>(noteDbName);
    await dB.put(obj.id, obj);
    refreshNoteUi();
    update();
  }

  // @override
  // Future<void> updateNote({required index, required value}) async {
  //   final dB = await Hive.openBox<NoteModel>(noteDbName);
  //   await dB.putAt(index, value);
  //   refreshNoteUi();
  // }

  Future<void> deleteNote(String id) async {
    final dB = await Hive.openBox<NoteModel>(noteDbName);
    await dB.delete(id);

   
    refreshNoteUi();
    update();
  }

  Future<List<NoteModel>> getAllNote() async {
    final dB = await Hive.openBox<NoteModel>(noteDbName);
    update();
    return dB.values.toList();
  }

  Future<void> refreshNoteUi() async {
    var noteList = await getAllNote();
    noteList = noteList.reversed.toList();
    noteModelList.clear();
    noteModelList.addAll(noteList);
    // noteModelList.notifyListeners();
    update();
  }
  
}
