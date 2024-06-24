import 'package:flutter/material.dart';
import 'package:project_ics321/models/player.dart';
import 'package:project_ics321/providers/general.dart';
import 'package:provider/provider.dart';

class BrowseCards extends StatefulWidget {
  bool isLoading = true;
  List<Player> cards = [];
  @override
  State<BrowseCards> createState() => _BrowseCardsState();
}

class _BrowseCardsState extends State<BrowseCards> {
  @override
  Widget build(BuildContext context) {
    GeneralProvider data = Provider.of(context, listen: false);
    data.getCards().then((value) {
      setState(() {
        widget.cards = value;
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
                "Players with Red Cards",
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
                      child: Text("No Players Recived Red Cards!"),
                    )
                  : ListView.builder(
                      itemCount: widget.cards.length,
                      itemBuilder: (c, ind) {
                        return Align(
                          child: Container(
                            child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration:
                                          BoxDecoration(color: Colors.red),
                                      child: Text(
                                        "${widget.cards[ind].name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Team: ${widget.cards[ind].team}"),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                        "Date of Card: ${widget.cards[ind].dateOfCard}")
                                  ],
                                )),
                            padding: EdgeInsets.all(15),
                            width: 325,
                            height: 115,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black45))),
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
