// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notex/main.dart';
import 'package:notex/notex_model/note_model.dart';

class NoteDb {
  NoteDb._internal();
  static NoteDb instance = NoteDb._internal();

  factory NoteDb() {
    return instance;
  }

  Future<void> addNoteDb(NoteModel obj) async {
    final dB = await Hive.openBox<NoteModel>(noteDbName);
    await dB.put(obj.id, obj);
    refreshNoteUi();
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

    log(id);
    refreshNoteUi();
  }

  Future<List<NoteModel>> getAllNote() async {
    final dB = await Hive.openBox<NoteModel>(noteDbName);
    return dB.values.toList();
  }

  Future<void> refreshNoteUi() async {
    var noteList = await getAllNote();
    noteList = noteList.reversed.toList();
    noteModelNotifier.value.clear();
    noteModelNotifier.value.addAll(noteList);
    noteModelNotifier.notifyListeners();
  }
}
