// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_management/core/util/refactory_widget.dart';
import 'package:getx_student_management/getx/colors/colors.dart';
import 'package:getx_student_management/getx/const/const.dart';
import 'package:getx_student_management/database/sqflite_db.dart';
import 'package:getx_student_management/presentation/add_student_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

final GetAllStudentDatailsControllerFromDbClass studentDetailsController =
    Get.put(GetAllStudentDatailsControllerFromDbClass());

class StudentManagementPage extends StatelessWidget {
  StudentManagementPage({super.key});

  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //--------------------------------------------/
    studentDetailsController.getAllStudentDetailsFromDb();
    //---------------------------------------------/
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: Column(children: [
          Container(
              width: size.width,
              height: 200,
              color: kwhatsAppColor,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kheight25,
                    Text(
                      "Students List",
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kWhite),
                    ),
                    kheight25,
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          onChanged: (value) {
                            studentDetailsController
                                .getAllStudentDetailsFromDb();
                          },
                          controller: searchEditingController,
                          decoration: const InputDecoration(
                              hintText: "Student Name",
                              hintStyle: TextStyle(color: kgrey),
                              prefixIcon: Icon(
                                Icons.search,
                                color: kgrey,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              filled: true,
                              fillColor: kWhite),
                        )),
                    kheight25,
                  ])),
          Obx(() {
            if (!studentDetailsController.isLoading.value) {
              return const CircularProgressIndicator();
            } else if (studentDetailsController.studentDetailsList.isEmpty) {
              return Expanded(
                  child: Center(
                child: LottieBuilder.asset(
                    'assets/animations/Animation - 1701342007210.json'),
              ));
            } else {
              List<Map<String, dynamic>> searchBarList =
                  studentDetailsController.studentDetailsList;
              if (searchEditingController.text.isNotEmpty) {
                searchBarList = searchBarList
                    .where((element) => element['studentName']
                        .toString()
                        .toLowerCase()
                        .contains(searchEditingController.text.toLowerCase()))
                    .toList();
              }
              return Expanded(
                child: ListView(
                  children: List.generate(searchBarList.length, (index) {
                    return InkWell(
                      onLongPress: () {
                        dialogBox(searchBarList[index]['uniqueId'],
                            searchBarList[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              color: kwhatsAppColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Colors.accents[index],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Name: ${searchBarList[index]['studentName']}",
                                          style: GoogleFonts.poppins(
                                              color: kWhite, fontSize: 20),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: searchBarList[index]
                                                      ['imageUrl'] !=
                                                  null
                                              ? FileImage(File(
                                                  searchBarList[index]
                                                      ['imageUrl']))
                                              : null,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Roll:${searchBarList[index]['rollNo']}',
                                      style: GoogleFonts.poppins(
                                          color: kWhite, fontSize: 20),
                                    ),
                                    kheight15,
                                    Text(
                                      'Div: ${searchBarList[index]['division']}',
                                      style: GoogleFonts.poppins(
                                          color: kWhite, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              kWidth10,
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
          }),
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(AddStudentDatailsPage());
            },
            backgroundColor: kwhatsAppColor,
            child: const Icon(Icons.person_add_alt_1_outlined)),
      ),
    );
  }
}
