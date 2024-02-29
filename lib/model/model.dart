class StudentModel {
  final String uuid;
  final int admissionNo;
  final String studentName;
  final int rollNo;
  final String division;
  final String imageUrl;

  StudentModel(
      {required this.uuid,
      required this.admissionNo,
      required this.studentName,
      required this.rollNo,
      required this.division,
      required this.imageUrl});
}
