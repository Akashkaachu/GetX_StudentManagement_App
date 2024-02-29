import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_management/database/sqflite_db.dart';
import 'package:getx_student_management/presentation/student_management.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  // await createStudentTable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: StudentManagementPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
