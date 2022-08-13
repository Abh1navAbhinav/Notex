// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notex/main.dart';
import 'package:notex/notex_model/note_model.dart';

abstract class NoteDbFunctions {
  Future<void> addNoteDb(NoteModel obj);
  Future<List<NoteModel>> getAllNote();
  Future<void> deleteNote(String id);
  Future<void> refreshNoteUi();
}

class NoteDb implements NoteDbFunctions {
  NoteDb._internal();
  static NoteDb instance = NoteDb._internal();

  factory NoteDb() {
    return instance;
  }

  @override
  Future<void> addNoteDb(NoteModel obj) async {
    final dB = await Hive.openBox<NoteModel>(noteDbName);
    await dB.add(obj);
    refreshNoteUi();
  }

  @override
  Future<void> deleteNote(String id) async {
    final dB = await Hive.openBox<NoteModel>(noteDbName);
    await dB.deleteAt(0);

    log(id);
    refreshNoteUi();
  }

  @override
  Future<List<NoteModel>> getAllNote() async {
    final dB = await Hive.openBox<NoteModel>(noteDbName);
    return dB.values.toList();
  }

  @override
  Future<void> refreshNoteUi() async {
    var noteList = await getAllNote();
    noteList = noteList.reversed.toList();
    noteModelNotifier.value.clear();
    noteModelNotifier.value.addAll(noteList);
    noteModelNotifier.notifyListeners();
  }
}
