import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notetakingapp/controller/add_note_ctrl.dart';
import 'package:notetakingapp/models/notes_models.dart';

import 'package:notetakingapp/util/app_colors.dart';
import 'package:notetakingapp/util/extensions.dart';
import 'package:notetakingapp/view/Screen/Home/home_screen.dart';

import '../../../widgets/custome_inputs.dart';
import '../models/colos_choices_options.dart';
import '../models/piroraty_button_list.dart';

class EditsNoteScreen extends StatefulWidget {
  const EditsNoteScreen({super.key, required this.id});

  final int id;

  @override
  State<EditsNoteScreen> createState() => _EditsNoteScreenState();
}

class _EditsNoteScreenState extends State<EditsNoteScreen> {
  final addNoteCtrl = Get.put(AddNoteCtrl());
  final _editsNoteskey = GlobalKey<FormState>();

  int piroratybtnIndex = 0;
  int colorChoseIndex = 0;
  final titleCtrl = TextEditingController();
  final descriptionsCtrl = TextEditingController();

  _editsNotes() async {
    log(widget.id.toString());
    if (_editsNoteskey.currentState!.validate()) {
      await addNoteCtrl.updateNotes(
          notesModels: NotesModels(
              id: widget.id,
              title: titleCtrl.text,
              descriptions: descriptionsCtrl.text,
              priority: piroratybtnIndex,
              colors: colorChoseIndex));

      Get.to(() => const HomeScreen());
    } else {
      log("enter all feilds");
    }
  }

  @override
  void initState() {
    addNoteCtrl.getNotesById(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descriptionsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _appbars(context),
        body: SafeArea(
          child: Container(
            color: addNoteCtrl.changeColors(addNoteCtrl.singleList[0].colors),
            height: double.infinity,
            width: double.infinity,
            padding:
                EdgeInsets.symmetric(horizontal: 0.005.toResponsive(context)),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 0.01.h(context),
                ),
                //piroratybtn_choose
                piroraty_btnchoose(context),
                SizedBox(
                  height: 0.02.h(context),
                ),
                colorChose(context),
                SizedBox(
                  height: 0.02.h(context),
                ),

                Form(
                    key: _editsNoteskey,
                    child: Column(
                      children: [
                        //title
                        CustomeInputs(
                          height: 0.08.h(context),
                          width: 1.0.w(context),
                          hintText: addNoteCtrl.singleList[0].title,
                          isMultiLine: false,
                          index: addNoteCtrl.singleList[0].colors,
                          textEditingController: titleCtrl,
                          validators: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter the Title";
                            }

                            return null;
                          },
                        ),

                        SizedBox(
                          height: 0.02.h(context),
                        ),
                        CustomeInputs(
                          height: 0.15.h(context),
                          width: 1.0.w(context),
                          hintText: addNoteCtrl.singleList[0].descriptions,
                          isMultiLine: true,
                          index: addNoteCtrl.singleList[0].colors,
                          textEditingController: descriptionsCtrl,
                          validators: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter the descriptions ";
                            }

                            return null;
                          },
                        )
                      ],
                    ))
              ]),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appbars(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,
            color: addNoteCtrl.textColors(addNoteCtrl.singleList[0].colors)),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor:
          addNoteCtrl.changeColors(addNoteCtrl.singleList[0].colors),
      title: Text(
        "Edits Notes",
        style: TextStyle(
            color: addNoteCtrl.textColors(addNoteCtrl.singleList[0].colors),
            fontSize: 0.020.toResponsive(context),
            fontFamily: "Abhaya",
            fontWeight: FontWeight.w900),
      ),
      actions: [
        IconButton(
            onPressed: _editsNotes,
            icon: Icon(
              Icons.save,
              color: addNoteCtrl.textColors(addNoteCtrl.singleList[0].colors),
            )),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "NoteTaking",
                        style: TextStyle(
                            color: primaryColors,
                            fontSize: 0.020.toResponsive(context),
                            fontFamily: "Noto",
                            fontWeight: FontWeight.w900),
                      ),
                      content: Text(
                        "Are sure you want's to delete the notes",
                        style: TextStyle(
                            color: kBlackColors,
                            fontSize: 0.015.toResponsive(context),
                            fontFamily: "Noto",
                            fontWeight: FontWeight.w500),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 0.015.toResponsive(context),
                                  fontFamily: "Noto",
                                  fontWeight: FontWeight.w700),
                            )),
                        TextButton(
                            onPressed: () {
                              addNoteCtrl.deletsNotesById(
                                  addNoteCtrl.singleList[0].id ?? 0);

                              Get.to(() => const HomeScreen());
                            },
                            child: Text(
                              "ok",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 0.015.toResponsive(context),
                                  fontFamily: "Noto",
                                  fontWeight: FontWeight.w700),
                            )),
                      ],
                    );
                  });
            },
            icon: Icon(
              Icons.delete,
              color: addNoteCtrl.textColors(addNoteCtrl.singleList[0].colors),
            ))
      ],
    );
  }

  SizedBox piroraty_btnchoose(BuildContext context) {
    return SizedBox(
      height: 0.06.h(context),
      width: 1.0.w(context),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: piroratybtnlist.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  piroratybtnIndex = index;
                });
              },
              child: Container(
                height: 0.8.h(context),
                width: 0.3.w(context),
                decoration: BoxDecoration(
                    color: piroratybtnIndex == index
                        ? primaryColors
                        : const Color.fromARGB(255, 202, 221, 248),
                    border: Border.all(
                        width: 1,
                        color: piroratybtnIndex != index
                            ? Color.fromARGB(255, 99, 240, 5)
                            : Colors.black),
                    borderRadius: BorderRadius.all(
                        Radius.circular(0.008.toResponsive(context)))),
                margin: EdgeInsets.only(
                    left: index == 0 ? 0 : 0.012.toResponsive(context)),
                child: Center(
                  child: Text(
                    piroratybtnlist[index],
                    style: TextStyle(
                        color: piroratybtnIndex != index
                            ? Colors.blue
                            : Colors.white,
                        fontFamily: "Abhaya",
                        fontSize: 0.014.toResponsive(context),
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            );
          }),
    );
  }

  SizedBox colorChose(BuildContext context) {
    return SizedBox(
      height: 0.06.h(context),
      width: 1.0.w(context),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colorsoptionslist.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  colorChoseIndex = index;
                });
              },
              child: Container(
                height: 0.8.h(context),
                width: 0.12.w(context),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.3, color: Colors.black),
                  shape: BoxShape.circle,
                  color: colorsoptionslist[index],
                ),
                margin: EdgeInsets.only(
                    left: index == 0 ? 0 : 0.024.toResponsive(context)),
                child: Center(
                    child: colorChoseIndex == index
                        ? Icon(
                            Icons.check,
                            color: addNoteCtrl.textColors(index),
                          )
                        : const Text("")),
              ),
            );
          }),
    );
  }
}
