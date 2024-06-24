import 'package:flutter/material.dart';
import 'package:project_ics321/pages/adminPages/accept_player.dart';
import 'package:project_ics321/pages/adminPages/add_team_to_tournament.dart';
import 'package:project_ics321/pages/adminPages/add_tournament.dart';
import 'package:project_ics321/pages/adminPages/delete_tournament.dart';
import 'package:project_ics321/pages/adminPages/select_captain.dart';
import 'package:project_ics321/pages/admin_page.dart';
import 'package:project_ics321/pages/guestPages/browse_cards.dart';
import 'package:project_ics321/pages/guestPages/browse_results.dart';
import 'package:project_ics321/pages/guestPages/browse_scorer.dart';
import 'package:project_ics321/pages/guestPages/browse_team_members.dart';
import 'package:project_ics321/pages/guestPages/request_player.dart';
import 'package:project_ics321/pages/guest_page.dart';
import 'package:project_ics321/pages/login_page.dart';
import 'package:project_ics321/providers/general.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GeneralProvider(),
      child: MaterialApp(
        routes: {
          '/': (context) => LoginPage(),
          '/admin': (context) => AdminPage(),
          '/admin/addTournament': (context) => AddTournamentPage(),
          '/admin/deleteTournament': (context) => DeleteTournamentPage(),
          '/admin/addTeam': (context) => AddTeamToTournamentPage(),
          '/admin/selectCaptain': (context) => SelectCaptainPage(),
          '/guest': (context) => GuestPage(),
          '/guest/browseMatchResults': (context) => BrowseMatchResultsPage(),
          '/guest/redCards': (context) => BrowseCards(),
          '/guest/browseScorer': (context) => ScorerPage(),
          '/guest/browseMembers': (context) => BrowseTeamPage(),
          '/guest/requestPlayer': (context) => RequestPlayerPage(),
          '/admin/approvePlayer': (context) => ApprovePlayerPage(),
        },
      ),
    );
  }
}
