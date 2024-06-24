import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_ics321/providers/general.dart';
import 'package:provider/provider.dart';

class GuestPage extends StatelessWidget {
  List guestFeatures = [
    ["Browse match results", '/guest/browseMatchResults'],
    ["Browse player with highest goals", '/guest/browseScorer'],
    ['Browse players who recieved red cards', '/guest/redCards'],
    ['Browse team members', '/guest/browseMembers'],
    ['Request New Player', '/guest/requestPlayer']
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
        height: 1000,
        width: 1000,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 500,
              child: Text(
                "Welcome Guest",
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
                        Navigator.pushNamed(context, guestFeatures[index][1])
                            .then((value) {
                          data.setTournamentToAddTeamInd(-1);
                        });
                      },
                      child: Align(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          width: 300,
                          height: 80,
                          child: Text(
                            guestFeatures[index][0],
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
