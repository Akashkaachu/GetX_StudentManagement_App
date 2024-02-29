// ignore_for_file: sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_management/database/sqflite_db.dart';
import 'package:getx_student_management/getx/colors/colors.dart';
import 'package:getx_student_management/presentation/edit_student_details.dart';
import 'package:getx_student_management/presentation/student_management.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.text,
    required this.fontSize,
  });
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kwhatsAppColor,
      centerTitle: true,
      title: TextWidget(text: text, fontsize: fontSize),
    );
  }
}

/*--------------------------------------------------------------------------------- */
class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    required this.fontsize,
  });
  final String text;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          GoogleFonts.poppins(fontSize: fontsize, fontWeight: FontWeight.bold),
    );
  }
}

/*----------------------------------------------------------------------------- */
class SelectImageContainers extends StatelessWidget {
  const SelectImageContainers({
    super.key,
    required this.icons,
  });
  final IconData icons;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 160,
      decoration: BoxDecoration(
          color: kwhatsAppColor,
          borderRadius: BorderRadiusDirectional.circular(15)),
      child: Center(
          child: Icon(
        icons,
        color: kWhite,
        size: 35,
      )),
    );
  }
}

/*----------------------------------------------------------------------------------------------* */
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
      required this.icon,
      required this.hintText,
      required this.controller,
      required this.validator,
      required this.floatingLabelBehavior});
  final IconData icon;
  final String hintText;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  FloatingLabelBehavior? floatingLabelBehavior;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          floatingLabelBehavior: floatingLabelBehavior,
          hintStyle:
              GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

/*--------------------------------------------------------------------------- */
void dialogBox(String uuidValue, Map<String, dynamic> studentDetails) {
  Get.dialog(AlertDialog(
    title: const Text("Choose Your Options"),
    content: const Text(""),
    actions: [
      ElevatedButton(
        onPressed: () async {
          Get.back();
          await deleteStudentDetailsFromDb(uuidValue);
          await studentDetailsController.getAllStudentDetailsFromDb();
        },
        child: const Text("Delete"),
        style: ElevatedButton.styleFrom(backgroundColor: kRed),
      ),
      ElevatedButton(
        onPressed: () {
          Get.back();
          Get.to(EditStudentDetailsScrn(studentDetails: studentDetails));
        },
        child: const Text("Edit"),
        style: ElevatedButton.styleFrom(backgroundColor: kwhatsAppColor),
      )
    ],
  ));
}
