import 'package:flutter/material.dart';
import 'package:project_ics321/models/team.dart';
import 'package:provider/provider.dart';

import '../../providers/general.dart';

class RequestPlayerPage extends StatefulWidget {
  @override
  State<RequestPlayerPage> createState() => _RequestPlayerPageState();
}

class _RequestPlayerPageState extends State<RequestPlayerPage> {
  @override
  Widget build(BuildContext context) {
    GeneralProvider data = Provider.of(context, listen: false);

    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController kfupmIDController = TextEditingController();
    TextEditingController departmentController = TextEditingController();
    DateTime datePicked = data.getPlayerBirthDate();

    List<Team> teams = data.getTeams();

    Future<void> _selectDate(
      BuildContext context,
    ) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: datePicked,
          firstDate: DateTime(1940, 5),
          lastDate: DateTime(2024));
      if (picked != null) {
        setState(() {
          datePicked = picked;
          data.setplayerBirthDate(datePicked);
        });
      }
    }

    Team? selectedTeam = data.getTeamForRequest();

    return Scaffold(
      appBar: AppBar(
        title: Text("KFUPM Tournament App"),
        actions: [
          IconButton(
              onPressed: () {
                data.logout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        width: 1000,
        height: 1000,
        padding: EdgeInsets.only(top: 70),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              child: Container(
                alignment: Alignment.center,
                width: 500,
                child: Text(
                  "Add a New Request!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              child: Container(
                  width: 340,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.black45)),
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Select Birth Date",
                          style: TextStyle(fontSize: 20),
                        ),
                        Icon(
                          Icons.calendar_month,
                          size: 23,
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              child: Container(
                  width: 340,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.black45)),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none, label: Text("Select Team")),
                      value: selectedTeam,
                      items: teams
                          .map((e) => DropdownMenuItem(
                                child: Text(e.name),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTeam = value;
                          data.setTeamForRequest(selectedTeam);
                          print(selectedTeam!.name);
                        });
                      })),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2, color: Colors.black45)),
                    child: TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter first name",
                          labelText: "First Name"),
                    ),
                  ),
                  Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2, color: Colors.black45)),
                    child: TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter last name",
                          labelText: "Last Name"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              child: Container(
                width: 340,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.black45)),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter email",
                      labelText: "Email"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              child: Container(
                width: 340,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.black45)),
                child: TextField(
                  controller: kfupmIDController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Kfupm Id",
                      labelText: "KFUPM ID"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              child: Container(
                width: 340,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.black45)),
                child: TextField(
                  controller: departmentController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter department",
                      labelText: "Department"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              child: Container(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10))),
                    onPressed: () {
                      data.requetPlayerAddition(
                          firstNameController.text,
                          lastNameController.text,
                          datePicked.toString(),
                          emailController.text,
                          int.parse(kfupmIDController.text),
                          departmentController.text,
                          selectedTeam!.id);
                      Navigator.of(context).pop('l');
                    },
                    child: Text(
                      "Add Request",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
