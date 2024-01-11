import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notetakingapp/controller/add_note_ctrl.dart';
import 'package:notetakingapp/util/extensions.dart';

class CustomeInputs extends StatelessWidget {
  const CustomeInputs(
      {super.key,
      required this.height,
      required this.width,
      required this.hintText,
      required this.isMultiLine,
      required this.index,
      required this.textEditingController,
      required this.validators});

  final double height, width;
  final String hintText;
  final bool isMultiLine;
  final int index;
  final TextEditingController textEditingController;
  final dynamic validators;

  @override
  Widget build(BuildContext context) {
    final addNoteCtrl = Get.find<AddNoteCtrl>();
    log("this is the index $index ");
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(0.008.toResponsive(context)))),
      height: height,
      width: width,
      padding: EdgeInsets.all(0.0015.toResponsive(context)),
      child: TextFormField(
        validator: validators,
        controller: textEditingController,
        style: TextStyle(
            color: addNoteCtrl.textColors(index),
            fontSize: isMultiLine == true
                ? 0.017.toResponsive(context)
                : 0.022.toResponsive(context),
            fontWeight: isMultiLine == true ? FontWeight.w800 : FontWeight.w500,
            fontFamily: isMultiLine == true ? "Abhaya" : "Grenze"),
        maxLines: isMultiLine == true ? 5 : 1,
        minLines: isMultiLine == true ? 5 : 1,
        keyboardType:
            isMultiLine == true ? TextInputType.multiline : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: addNoteCtrl.textColors(index),
              fontSize: isMultiLine == true
                  ? 0.017.toResponsive(context)
                  : 0.022.toResponsive(context),
              fontWeight:
                  isMultiLine == true ? FontWeight.w800 : FontWeight.w500,
              fontFamily: isMultiLine == true ? "Abhaya" : "Grenze"),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
