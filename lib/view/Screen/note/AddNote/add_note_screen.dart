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

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  int piroratybtnIndex = 0;
  int colorChoseIndex = 0;
  final addNoteCtrl = Get.put(AddNoteCtrl());
  final _key = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptions = TextEditingController();

  _addNotes() async {
    if (_key.currentState!.validate()) {
      int value = await addNoteCtrl.addNotes(
          notesModels: NotesModels(
              title: titleController.text,
              descriptions: descriptions.text,
              priority: piroratybtnIndex,
              colors: colorChoseIndex));

      log("Value:$value");

      Get.to(() => const HomeScreen());
    } else {
      log("enter all feilds");
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(addNoteCtrl.textColors(colorChoseIndex).toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: addNoteCtrl.textColors(colorChoseIndex)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: addNoteCtrl.changeColors(colorChoseIndex),
        title: Text(
          "Add Notes",
          style: TextStyle(
              color: addNoteCtrl.textColors(colorChoseIndex),
              fontSize: 0.020.toResponsive(context),
              fontFamily: "Abhaya",
              fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
              onPressed: _addNotes,
              icon: Icon(
                Icons.save,
                color: addNoteCtrl.textColors(colorChoseIndex),
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: addNoteCtrl.textColors(colorChoseIndex),
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          color: addNoteCtrl.changeColors(colorChoseIndex),
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
                  key: _key,
                  child: Column(
                    children: [
                      //title
                      CustomeInputs(
                        height: 0.08.h(context),
                        width: 1.0.w(context),
                        hintText: "Title",
                        isMultiLine: false,
                        index: colorChoseIndex,
                        textEditingController: titleController,
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
                        hintText: "Descriptions",
                        isMultiLine: true,
                        index: colorChoseIndex,
                        textEditingController: descriptions,
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
