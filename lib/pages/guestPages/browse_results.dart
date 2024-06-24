import 'package:flutter/material.dart';
import 'package:project_ics321/models/match.dart';
import 'package:provider/provider.dart';

import '../../models/tournament.dart';
import '../../providers/general.dart';

class BrowseMatchResultsPage extends StatefulWidget {
  bool isLoading = true;
  @override
  State<BrowseMatchResultsPage> createState() => _BrowseMatchResultsPageState();
}

class _BrowseMatchResultsPageState extends State<BrowseMatchResultsPage> {
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
    List<Matchh> matches = data.getMatches();
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
                    ? "Select a Tournament to view"
                    : "Match Results",
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
                      ///////////////////////////////////////////////////////second list view for matches
                      : widget.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: matches.length,
                              itemBuilder: (c, ind) {
                                return Align(
                                  child: Container(
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: 200,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Home ${matches[ind].homeScore} : ${matches[ind].awayScore} Away",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                "Time: ${matches[ind].matchTime}           Date: ${matches[ind].matchDate}")
                                          ],
                                        )),
                                    padding: EdgeInsets.all(15),
                                    width: 325,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black45))),
                                  ),
                                );
                              },
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
                      data.getMatchResults(selectedTournament).then((value) {
                        setState(() {
                          widget.isLoading = false;
                        });
                      });
                    } else {
                      /////////////////////
                      data.setTournamentToAddTeamInd(-1);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    selectedTournamentInd == -1
                        ? "Select Tournament"
                        : "Return to Home",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
    ;
  }
}
