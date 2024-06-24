import 'package:flutter/material.dart';
import 'package:project_ics321/models/tournament.dart';
import 'package:provider/provider.dart';

import '../../providers/general.dart';

class DeleteTournamentPage extends StatefulWidget {
  @override
  State<DeleteTournamentPage> createState() => _DeleteTournamentPageState();
}

class _DeleteTournamentPageState extends State<DeleteTournamentPage> {
  int selectedTournament = 0;

  void select(int ind) {
    setState(() {
      selectedTournament = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    GeneralProvider data = Provider.of(context);
    List<Tournament> tournaments = data.getTournaments();

    return Scaffold(
      appBar: AppBar(
        title: const Text("KFUPM Tournament App"),
        actions: [
          IconButton(
              onPressed: () {
                data.logout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        width: 1000,
        height: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 400,
              child: const Text(
                "Select a Tournament to Delete",
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
                  : ListView.builder(
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
                                          width: 1, color: Colors.black45))),
                            ),
                          ),
                        );
                      },
                      itemCount: tournaments.length,
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
                    data.deleteTournament(selectedTournament);
                    Navigator.of(context).pop('l');
                  },
                  child: Text(
                    "Delete Tournament",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
        padding: const EdgeInsets.only(top: 70),
      ),
    );
  }
}
