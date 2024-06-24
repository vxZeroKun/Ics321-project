import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_ics321/providers/general.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  List adminFeatures = [
    ["Add new tournament", '/admin/addTournament'],
    ["Add team to tournament", '/admin/addTeam'],
    ['Select captain for team', '/admin/selectCaptain'],
    ['Approve player to join team', '/admin/approvePlayer'],
    ['Delete a tournament', '/admin/deleteTournament']
  ];

  @override
  Widget build(BuildContext context) {
    void showInSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Center(
              child: Text(
            "Implemented Successfully!",
            style: TextStyle(fontSize: 15),
          ))));
    }

    GeneralProvider data = Provider.of(context, listen: false);
    data.getRequests();
    return Scaffold(
      appBar: AppBar(
        title: Text("KFUPM Tournament App"),
        actions: [
          IconButton(
              onPressed: () {
                data.logout();
                Navigator.of(context).pushReplacementNamed(
                  '/',
                );
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        height: 1200,
        width: 1000,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 500,
              child: Text(
                "Welcome Admin",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 1000,
              height: 500,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    bool oddVsEven = true;
                    if (index % 2 == 0) {
                      oddVsEven = true;
                    } else {
                      oddVsEven = false;
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, adminFeatures[index][1])
                            .then((value) {
                          if (value != null) {
                            showInSnackBar();
                          } else {
                            data.setTournamentToAddTeamInd(-1);
                          }
                          data.getRequests();
                          data.getTeamsInit();
                          data.getTournamentInit();
                        });
                      },
                      child: Align(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          width: 300,
                          height: 70,
                          child: Text(
                            adminFeatures[index][0],
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: oddVsEven ? Colors.white : Colors.blue),
                          ),
                          decoration: BoxDecoration(
                              color: oddVsEven ? Colors.blue : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 2,
                                  color: oddVsEven
                                      ? Colors.black45
                                      : Colors.blue)),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
