import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:getx_student_management/getx/snackbar/snack_bar.dart';
import 'package:getx_student_management/model/model.dart';
import 'package:sqflite/sqflite.dart';

late Database db;
Future<void> initializeDatabase() async {
  db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE studentTable (uniqueId TEXT PRIMARY KEY, admissionNo INTEGER, studentName TEXT, rollNo INTEGER, division REAL,imageUrl)');
    },
  );
}

/*============================================================================ */
Future<void> addStudentToDb(StudentModel value) async {
  final existingRecord = await db.query('studentTable',
      where: 'admissionNo=?', whereArgs: [value.admissionNo]);
  if (existingRecord.isEmpty) {
    await db.insert('studentTable', {
      'uniqueId': value.uuid,
      'admissionNo': value.admissionNo,
      'studentName': value.studentName,
      'rollNo': value.rollNo,
      'division': value.division,
      'imageUrl': value.imageUrl
    });
    CustomSnackbarController().showCustomSnackbar('Congrates',
        'Successfully added the student details', ContentType.success);
  } else {
    CustomSnackbarController().showCustomSnackbar(
        'Oops', 'Details already added to the storage', ContentType.failure);
  }
}

/*----------------------------------------------------------------------- */

class GetAllStudentDatailsControllerFromDbClass extends GetxController {
  final RxList<Map<String, dynamic>> studentDetailsList =
      <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  Future<void> getAllStudentDetailsFromDb() async {
    final getDetails = db.query('studentTable');
    studentDetailsList.value = await getDetails;
    isLoading.value = true;
  }
}

/*------------------------------------------------------------------------- */
Future<void> deleteStudentDetailsFromDb(String uuid) async {
  final getDeletedValues =
      await db.delete('studentTable', where: 'uniqueId=?', whereArgs: [uuid]);
  if (getDeletedValues.isNaN) {
    CustomSnackbarController()
        .showCustomSnackbar('Oops', "It's not deleted", ContentType.failure);
  } else {
    CustomSnackbarController().showCustomSnackbar(
        'Wow', 'Student details successfully deleted', ContentType.success);
  }
}

/*============================================================================== */
Future<void> updateStudentDetailsFromDb(StudentModel details) async {
  await db.update(
      'studentTable',
      {
        'uniqueId': details.uuid,
        'admissionNo': details.admissionNo,
        'studentName': details.studentName,
        'rollNo': details.rollNo,
        'division': details.division,
        'imageUrl': details.imageUrl,
      },
      where: 'uniqueId=?',
      whereArgs: [details.uuid]);
  CustomSnackbarController().showCustomSnackbar(
      'Congrates', 'Successfully Updated Student details', ContentType.success);
}
