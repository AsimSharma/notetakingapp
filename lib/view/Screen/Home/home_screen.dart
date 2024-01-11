import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notetakingapp/controller/add_note_ctrl.dart';
import 'package:notetakingapp/util/app_colors.dart';
import 'package:notetakingapp/util/extensions.dart';

import '../note/AddNote/add_note_screen.dart';
import '../note/Editsnotes/edits_notes.dart';
import '../note/models/colos_choices_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final addNoteCtrl = Get.put((AddNoteCtrl()));

  @override
  void initState() {
    addNoteCtrl.getNotes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 10, 224, 174),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.search, color: kWhite),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: kWhite),
              onPressed: () {},
            ),
          ],
          title: Text(
            "Notes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 0.020.toResponsive(context),
                fontFamily: "Abhaya",
                fontWeight: FontWeight.w900),
          ),
        ),
        floatingActionButton: ElevatedButton(
            onPressed: () {
              Get.to(() => const AddNoteScreen());
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 10, 224, 174)),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: Obx(
          () => addNoteCtrl.notesList.isEmpty
              ? const SafeArea(
                  child: Center(
                  child: Column(
                    children: [
                      Text("please add some notes"),
                    ],
                  ),
                ))
              : SafeArea(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.008.toResponsive(context)),
                    child: Column(children: [
                      SizedBox(
                        height: 0.882.h(context),
                        width: 1.0.w(context),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0.01.toResponsive(context),
                                  mainAxisSpacing: 0.005.toResponsive(context)),
                          itemCount: addNoteCtrl.notesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var notedata = addNoteCtrl.notesList[index];
                            return InkWell(
                              onTap: () {
                                Get.to(() => EditsNoteScreen(
                                      id: notedata.id ?? 0,
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 0.008.toResponsive(context)),
                                padding:
                                    EdgeInsets.all(0.008.toResponsive(context)),
                                constraints: BoxConstraints(
                                  minHeight: 0.073.h(context),
                                  minWidth: 0.23.w(context),
                                ),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(0.0, 0.01),
                                          blurRadius: 0.02,
                                          color: kBlackColors,
                                          spreadRadius: 0.02)
                                    ],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            0.008.toResponsive(context))),
                                    color: colorsoptionslist[notedata.colors],
                                    border: Border.all(
                                        width: 1.2, color: kBlackColors)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${notedata.title} !!!!",
                                      style: TextStyle(
                                          color: addNoteCtrl
                                              .textColors(notedata.colors),
                                          fontSize: 0.022.toResponsive(context),
                                          fontWeight: FontWeight.w800,
                                          fontFamily: "Grenze"),
                                    ),
                                    SizedBox(
                                      height: 0.003.h(context),
                                    ),
                                    Text(
                                      notedata.descriptions,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: addNoteCtrl
                                              .textColors(notedata.colors),
                                          fontSize: 0.017.toResponsive(context),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Noto"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  ),
                ),
        ));
  }
}
