import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notetakingapp/db/db_helper.dart';
import 'package:notetakingapp/models/notes_models.dart';
import 'package:notetakingapp/util/app_colors.dart';

import '../view/Screen/note/models/colos_choices_options.dart';

class AddNoteCtrl extends GetxController {
  var notesList = <NotesModels>[].obs;
  var isLoading = false.obs;

  var singleList = <NotesModels>[].obs;

  //change colors
  Color changeColors(int index) {
    return colorsoptionslist[index];
  }

  Color textColors(int index) {
    if (index == 1) {
      log(index.toString());
      return kBlackColors;
    } else if (index == 6) {
      return kBlackColors;
    } else {
      return kWhite;
    }
  }

//addNotes
  Future<int> addNotes({required NotesModels notesModels}) async {
    return await SqlDbHelper.addNoteToDb(notesModels);
  }

  //
  getNotes() async {
    isLoading = false.obs;
    try {
      isLoading = false.obs;
      List<Map<String, dynamic>> notes = await SqlDbHelper.getallNoteFromDb();
      log(notes.toString());
      notesList.assignAll(notes.map((items) => NotesModels.fromJson(items)));
      isLoading = true.obs;
    } catch (err) {
      log(err.toString());
    }
    update();
  }

  //getNotesbyid
  getNotesById(int id) async {
    try {
      List<Map<String, dynamic>> notes = await SqlDbHelper.getTheNotesbyId(id);
      // singleList = <NotesModels>[].obs;
      singleList.assignAll(notes.map((items) => NotesModels.fromJson(items)));
    } catch (err) {
      log("Error $err");
    }

    update();
  }

  //delets notes by id
  deletsNotesById(int id) async {
    try {
      int value = await SqlDbHelper.deleteById(id);
      log(" this is $value");
    } catch (err) {
      log(err.toString());
    }
  }

//UPDATE NOTES BY ID

  updateNotes({required NotesModels notesModels}) async {
    log("this is editsIndex ${notesModels.id}");
    try {
      int value = await SqlDbHelper.updateNotes(notesModels);
      log("return values $value");
    } catch (err) {
      log(err.toString());
    }
    update();
  }
}
