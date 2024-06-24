import 'package:flutter/material.dart';
import 'package:project_ics321/models/player.dart';
import 'package:project_ics321/providers/general.dart';
import 'package:provider/provider.dart';

class ScorerPage extends StatefulWidget {
  bool isLoading = true;
  Player player = Player(name: "", id: 6);
  @override
  State<ScorerPage> createState() => _ScorerPageState();
}

class _ScorerPageState extends State<ScorerPage> {
  @override
  Widget build(BuildContext context) {
    GeneralProvider data = Provider.of(context, listen: false);
    data.getScorer().then((value) {
      setState(() {
        widget.player = Player(
            name: "${value['Fname']} ${value['Lname']}",
            id: 0,
            goals: value['SUM(S.Num_Of_Goals)'],
            team: value['Team_Name']);
        widget.isLoading = false;
      });
    });
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
        padding: EdgeInsets.only(top: 70),
        width: 1000,
        height: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 400,
              child: Text(
                "Highest Scorer",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 350,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black45)),
              child: widget.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "${widget.player.name}",
                                  style: TextStyle(
                                      fontSize: 39,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Team: ${widget.player.team}",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Goals: ${widget.player.goals}",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                      padding: EdgeInsets.all(15),
                      width: 325,
                      height: 115,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.black45))),
                    ),
            ),
            SizedBox(
              height: 10,
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
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Return to Home",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
