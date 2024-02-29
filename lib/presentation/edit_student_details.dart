import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_management/core/util/refactory_widget.dart';
import 'package:getx_student_management/database/sqflite_db.dart';
import 'package:getx_student_management/getx/colors/colors.dart';
import 'package:getx_student_management/getx/const/const.dart';
import 'package:getx_student_management/getx/image_pickers/image_picker.dart';
import 'package:getx_student_management/getx/snackbar/snack_bar.dart';
import 'package:getx_student_management/model/model.dart';
import 'package:getx_student_management/presentation/student_management.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditStudentDetailsScrn extends StatelessWidget {
  final Map<String, dynamic> studentDetails;
  EditStudentDetailsScrn({super.key, required this.studentDetails}) {
    admissionEditingController.text = studentDetails['admissionNo'].toString();
    studentNameEditingController.text = studentDetails['studentName'];
    rollNoEditingController.text = studentDetails['rollNo'].toString();
    DivEditingController.text = studentDetails['division'];
    print(studentDetails.keys);
    imageValueNotifier.value = File(studentDetails['imageUrl']);
  }
  final ValueNotifier<File?> imageValueNotifier = ValueNotifier<File?>(null);
  TextEditingController admissionEditingController = TextEditingController();
  TextEditingController studentNameEditingController = TextEditingController();
  TextEditingController rollNoEditingController = TextEditingController();
  TextEditingController DivEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBarWidget(
              text: "Edit Details",
              fontSize: 25,
            )),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
              width: size.width,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    kheight25,
                    ValueListenableBuilder(
                        valueListenable: imageValueNotifier,
                        builder: (context, image, child) {
                          return Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    image != null ? FileImage(image) : null,
                                child: image != null
                                    ? null
                                    : const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: kBlack,
                                      ),
                                radius: 60,
                                backgroundColor: kCircularAvatarGreyBgClr,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 230,
                                          decoration: const BoxDecoration(
                                              color: kWhite,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10))),
                                          child: Column(children: [
                                            const TextWidget(
                                              fontsize: 15,
                                              text: "Select Your Image",
                                            ),
                                            kheight15,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                    onTap: () async {
                                                      imageValueNotifier.value =
                                                          await ImagePickerController()
                                                              .pickImage(
                                                                  ImageSource
                                                                      .gallery);
                                                      Get.back();
                                                    },
                                                    child:
                                                        const SelectImageContainers(
                                                            icons:
                                                                Icons.image)),
                                                InkWell(
                                                  onTap: () async {
                                                    imageValueNotifier.value =
                                                        await ImagePickerController()
                                                            .pickImage(
                                                                ImageSource
                                                                    .camera);
                                                    Get.back();
                                                  },
                                                  child: const SelectImageContainers(
                                                      icons: Icons
                                                          .camera_alt_outlined),
                                                ),
                                              ],
                                            )
                                          ]),
                                        );
                                      },
                                    );
                                  },
                                  child: const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: kwhatsAppColor,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: kBlack,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                    kheight15,
                    TextFormFieldWidget(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: "Admission Number",
                      icon: Icons.format_list_numbered,
                      controller: admissionEditingController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter the Adimission number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    kheight15,
                    TextFormFieldWidget(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: "Student Name :",
                      icon: Icons.person,
                      controller: studentNameEditingController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter the Student name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    kheight15,
                    TextFormFieldWidget(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: "Roll no:",
                      icon: Icons.numbers_outlined,
                      controller: rollNoEditingController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter the Roll number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    kheight15,
                    TextFormFieldWidget(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: "Div",
                      icon: Icons.school_outlined,
                      controller: DivEditingController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter the Adimission number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    kheight50,
                    SizedBox(
                        width: size.width - 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (imageValueNotifier.value != null) {
                                final details = StudentModel(
                                    uuid: studentDetails['uniqueId'],
                                    admissionNo: int.parse(
                                        admissionEditingController.text),
                                    studentName:
                                        studentNameEditingController.text,
                                    rollNo:
                                        int.parse(rollNoEditingController.text),
                                    division: DivEditingController.text,
                                    imageUrl: imageValueNotifier.value!.path);
                                await updateStudentDetailsFromDb(details);
                                Get.offAll(StudentManagementPage());
                              } else {
                                CustomSnackbarController().showCustomSnackbar(
                                    "Error",
                                    'Please select Image',
                                    ContentType.warning);
                              }
                            }
                          },
                          child: const Text("SUBMIT"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kwhatsAppColor),
                        ))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
