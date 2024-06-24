class Request {
  String firstName;
  String lastName;
  String dateOfBirth;
  String email;
  int kfupmId;
  String departmentName;
  int teamId;
  Request({
    required this.dateOfBirth,
    required this.departmentName,
    required this.email,
    required this.firstName,
    required this.kfupmId,
    required this.lastName,
    required this.teamId,
  });
}
