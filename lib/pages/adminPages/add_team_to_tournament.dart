import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../models/team.dart';
import '../../models/tournament.dart';
import '../../providers/general.dart';

class AddTeamToTournamentPage extends StatefulWidget {
  const AddTeamToTournamentPage({super.key});

  @override
  State<AddTeamToTournamentPage> createState() =>
      _AddTeamToTournamentPageState();
}

class _AddTeamToTournamentPageState extends State<AddTeamToTournamentPage> {
  int selectedTournament = 0;

  void select(int ind) {
    setState(() {
      selectedTournament = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    GeneralProvider data = Provider.of(context);
    int selectedTournamentInd = data.getTournamentToAddTeamInd();
    List<Tournament> tournaments = data.getTournaments();
    List<Team> teams = data.getTeams();
    List<int> selectedTeamsIndexes = data.getIndexesOfTeamsCurrentlySelected();
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
                selectedTournamentInd == -1
                    ? "Select a Tournament to Add to"
                    : "Select Teams",
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
              child: tournaments.length == 0
                  ? Center(
                      child: Text("Start Adding Tournaments!"),
                    )
                  : selectedTournamentInd == -1
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
                                      decoration: selectedTournament == ind
                                          ? BoxDecoration(
                                              color: Colors.lightBlue,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )
                                          : BoxDecoration(),
                                      child: Text(
                                        tournaments[ind].name,
                                        style: TextStyle(
                                            color: selectedTournament == ind
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
                          itemCount: tournaments.length,
                        )
                      ///////////////////////////////////////////////////////second list view for teams
                      : ListView.builder(
                          itemBuilder: (ctx, ind) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedTeamsIndexes.contains(ind)) {
                                    data.removeFromSelectedTeamsForTournament(
                                        ind);
                                  } else {
                                    data.setSelectedTeamsForTournament(ind);
                                  }
                                });
                              },
                              child: Align(
                                child: Container(
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: 200,
                                      decoration:
                                          selectedTeamsIndexes.contains(ind)
                                              ? BoxDecoration(
                                                  color: Colors.lightBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                )
                                              : BoxDecoration(),
                                      child: Text(
                                        teams[ind].name,
                                        style: TextStyle(
                                            color: selectedTeamsIndexes
                                                    .contains(ind)
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
                          itemCount: teams.length,
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
                    if (selectedTournamentInd == -1) {
                      data.setTournamentToAddTeamInd(selectedTournament);
                    } else {
                      data.addTeamToTournament(selectedTournamentInd);
                      data.setTournamentToAddTeamInd(-1);
                      Navigator.of(context).pop(
                        '/admin',
                      );
                    }
                  },
                  child: Text(
                    selectedTournamentInd == -1
                        ? "Select Tournament"
                        : "Select Teams",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
