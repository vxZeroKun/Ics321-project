import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/general.dart';

class AddTournamentPage extends StatefulWidget {
  @override
  State<AddTournamentPage> createState() => _AddTournamentPageState();
}

class _AddTournamentPageState extends State<AddTournamentPage> {
  @override
  Widget build(BuildContext context) {
    GeneralProvider data = Provider.of(context, listen: false);
    DateTime selectedStartDate = data.getTournamentStartDate();
    DateTime selectedEndDate = data.getTournamentEndDate();
    Future<void> _selectDate(
        BuildContext context, DateTime date, int startVsEnd) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2023, 5),
          lastDate: DateTime(2025));
      if (picked != null && picked != date) {
        setState(() {
          if (startVsEnd == 0) {
            data.setTournamentStartDate(picked);
          } else {
            data.setTournamentEndDate(picked);
          }
        });
      }
    }

    TextEditingController tournamentNameController = TextEditingController();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 500,
              child: Text(
                "Add a New Tournament!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.black45)),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context, selectedStartDate, 0);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Select Start Date",
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.calendar_month,
                        size: 23,
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.black45)),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context, selectedEndDate, 1);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Select End Date",
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.calendar_month,
                        size: 23,
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.black45)),
                child: TextField(
                  controller: tournamentNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter tournament name",
                      labelText: "Tournament Name"),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 70, vertical: 10))),
                  onPressed: () {
                    data.addTournament(
                        tournamentNameController.text,
                        selectedStartDate.toString(),
                        selectedEndDate.toString());
                    Navigator.of(context).pop('l');
                  },
                  child: Text(
                    "Add Tournament",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
