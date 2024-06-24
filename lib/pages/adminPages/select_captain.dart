import 'package:flutter/material.dart';
import 'package:project_ics321/models/player.dart';
import 'package:provider/provider.dart';

import '../../models/team.dart';
import '../../providers/general.dart';

class SelectCaptainPage extends StatefulWidget {
  bool loadingPlayers = false;
  @override
  State<SelectCaptainPage> createState() => _SelectCaptainPageState();
}

class _SelectCaptainPageState extends State<SelectCaptainPage> {
  int selectedTeam = 0;

  void select(int ind) {
    setState(() {
      selectedTeam = ind;
    });
  }

  int selectedCaptain = 0;

  void selectCap(int ind) {
    setState(() {
      selectedCaptain = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    GeneralProvider data = Provider.of(context);
    List<Team> teams = data.getTeams();
    int selectedTeamInd = data.getIndOfTeamToSelectCap();
    List<Player> players = data.getPlayersOfTeam(selectedTeamInd);
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
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 400,
              child: Text(
                selectedTeamInd == -1
                    ? "Select a Team to Add to"
                    : "Select Captain",
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
              child: selectedTeamInd == -1
                  ? ListView.builder(
                      itemBuilder: (ctx, ind) {
                        return GestureDetector(
                          onTap: () {
                            select(ind);
                          },
                          child: Align(
                            child: Container(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  decoration: selectedTeam == ind
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1, color: Colors.black87))
                                      : BoxDecoration(),
                                  child: Text(
                                    teams[ind].name,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  )),
                              padding: EdgeInsets.all(10),
                              width: 325,
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.black45))),
                            ),
                          ),
                        );
                      },
                      itemCount: teams.length,
                    )
                  : widget.loadingPlayers
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemBuilder: (ctx, ind) {
                            return players.length == 0
                                ? Align(
                                    child: Center(
                                      child: Container(
                                        width: 50,
                                        child: Text(
                                          "Team has no players!",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      selectCap(ind);
                                    },
                                    child: Align(
                                      child: Container(
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 200,
                                            decoration: selectedCaptain == ind
                                                ? BoxDecoration(
                                                    color: players[ind].captain!
                                                        ? Colors.blue
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black87))
                                                : BoxDecoration(
                                                    color: players[ind].captain!
                                                        ? Colors.blue
                                                        : null,
                                                  ),
                                            child: Text(
                                              players[ind].name,
                                              style: TextStyle(
                                                  color: players[ind].captain!
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        padding: EdgeInsets.all(10),
                                        width: 325,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.black45))),
                                      ),
                                    ),
                                  );
                          },
                          itemCount: players.length,
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
                    if (selectedTeamInd == -1) {
                      data.setTeamToSelectCapInd(selectedTeam);
                      setState(() {
                        widget.loadingPlayers = true;
                      });

                      data.initPlayersInTeam().then((value) {
                        setState(() {
                          widget.loadingPlayers = false;
                        });
                      });
                    } else {
                      if (players.length == 0) {
                        data.setTeamToSelectCapInd(-1);

                        Navigator.of(context).pop();
                      } else {
                        data.setCaptain(selectedCaptain, selectedTeam);
                        data.setTeamToSelectCapInd(-1);

                        Navigator.of(context).pop(
                          '/admin',
                        );
                      }
                    }
                  },
                  child: Text(
                    selectedTeamInd == -1
                        ? "Select Team"
                        : players.length == 0
                            ? "Return to Home"
                            : "Select Captain",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
