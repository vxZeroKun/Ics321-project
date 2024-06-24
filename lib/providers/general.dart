import 'package:flutter/material.dart';
import 'package:project_ics321/database.dart';
import 'package:project_ics321/models/member.dart';
import 'package:project_ics321/models/player.dart';
import 'package:project_ics321/models/match.dart';
import 'package:project_ics321/models/reques.dart';
import 'package:project_ics321/models/team.dart';
import 'package:project_ics321/models/tournament.dart';
import 'package:sqflite/sqflite.dart';

class GeneralProvider with ChangeNotifier {
  //for signin or register page to hold data and not lose from fields
  String username = "";
  int userId = 0;
  String email = "";
  String password = "";
  String type = "";

  //for add tournament page to keep date data
  DateTime startTournamentDate = DateTime.now();
  DateTime endTournamentDate = DateTime.now();
  DateTime newPlayerBirthDate = DateTime.now();

  //for addTeamToTournament page to keep track of selected tournament there, and for interactive touch
  int tournamentToAddTeamInd = -1;
  int teamToViewMembers = -1;

  List<Team> teams = [
    /* Team(JerseyColor: "red", name: "Al-hilal"),
    Team(JerseyColor: "red", name: "Al-naser"),
    Team(JerseyColor: "red", name: "Al-shabba"),
    Team(JerseyColor: "red", name: "Ittihad"), */
  ];

  List<Request> requests = [];

  List<Member> members = [];
  //list of team indexes to add to tournament
  List<int> selectedTeamsToBeAdded = [];

  List<Tournament> tournaments = [
    /* Tournament(
        endDate: DateTime.now(),
        id: "--",
        name: "Starter Cup",
        startDate: DateTime.now()),
    Tournament(
        endDate: DateTime.now(),
        id: "--",
        name: "Kfupm Cup",
        startDate: DateTime.now()) */
  ];

  int teamToSelectCaptainInd = -1;

  List<Player> playersOfTeam = [
    /* Player(name: "Mohammad"),
    Player(name: "Khaled"),
    Player(name: "Yousef") */
  ];

  int numOfUsers = 0;
  int numOfTournaments = 0;

  List<Matchh> matches = [];

  Team? selectedTeamForPlayerRequest;
  ////////////////variables above///////////////

  Future<void> register(String password, String email, String username) async {
    this.email = email;
    this.password = password;
    type = "Guest";
    this.userId = numOfUsers + 1;
    this.username = username;
    //
    //register into sql as well
    //
    await DataBaseHelper.instance
        .register(password, email, username, type, userId)
        .then((value) {
      getNumberOfTournamentsForIdReg();
    });
  }

  //type of user, admin or guest
  String getType() {
    print(type);
    return type;
  }

  Future<String> login(String userEmail, String password) async {
    List<Map> result = await DataBaseHelper.instance.login(userEmail, password);
    if (result.length == 0) {
      return "";
    } else {
      username = result[0]["User_Name"];
      userId = result[0]["User_ID"];
      email = result[0]["Email"];
      type = result[0]["User_Type"];
      password = result[0]["Password"];
    }
    return result[0]['User_Type'];
  }

  void logout() {
    this.username = "";
    this.userId = 0;
    this.email = "";
    this.password = "";
    this.type = "";

    this.startTournamentDate = DateTime.now();
    this.endTournamentDate = DateTime.now();
    this.newPlayerBirthDate = DateTime.now();

    this.tournamentToAddTeamInd = -1;

    this.selectedTeamsToBeAdded = [];

    this.tournaments = [];

    this.teamToSelectCaptainInd = -1;

    this.playersOfTeam = [];

    this.matches = [];

    this.email = "";

    this.teams = [];

    this.teamToViewMembers = -1;

    this.members = [];
  }

  void setTournamentStartDate(DateTime date) {
    startTournamentDate = date;
  }

  void setTeamForRequest(Team? team) {
    selectedTeamForPlayerRequest = team;
  }

  Team? getTeamForRequest() {
    return selectedTeamForPlayerRequest;
  }

  DateTime getTournamentStartDate() {
    return startTournamentDate.copyWith();
  }

  void setplayerBirthDate(DateTime date) {
    newPlayerBirthDate = date;
  }

  DateTime getPlayerBirthDate() {
    return newPlayerBirthDate.copyWith();
  }

  void setTournamentEndDate(DateTime date) {
    endTournamentDate = date;
  }

  DateTime getTournamentEndDate() {
    return endTournamentDate.copyWith();
  }

  void addTournament(String name, String startDateTime, String endDateTime) {
    //dont forget to generate id , increments based on number of available tournaments
    //sql code to add tournament
    DataBaseHelper.instance
        .createTournament(
            name, startDateTime, endDateTime, numOfTournaments + 1)
        .then((value) {
      getNumberOfTournamentsForIdReg();
    });
  }

  Future<void> getTournamentInit() async {
    tournaments = [];
    List<Map<String, dynamic>> listofTourna =
        await DataBaseHelper.instance.getTournaments();
    listofTourna.forEach((element) {
      Tournament tourna = Tournament(
          endDate: element['End_Date'],
          id: element['Tournament_ID'],
          name: element['Tournament_Name'],
          startDate: element['Start_Date']);
      tournaments.add(tourna);
    });
  }

  Future<void> getTeamsInit() async {
    teams = [];
    List<Map<String, dynamic>> listofTeams =
        await DataBaseHelper.instance.getTeams();
    listofTeams.forEach((element) {
      Team team = Team(
          JerseyColor: element['Jersey_Color'],
          name: element['Team_Name'],
          id: element['Team_ID'],
          captain_id: element['KFUPM_ID']);

      teams.add(team);
    });
  }

  List<Tournament> getTournaments() {
    return [...tournaments];
  }

  void deleteTournament(int ind) {
    Tournament toBeDeleted = tournaments.removeAt(ind);
    //sql to remove from db as well
    DataBaseHelper.instance
        .deleteTournament(tournaments.elementAt(ind).id)
        .then((value) {
      getNumberOfTournamentsForIdReg();
    });

    notifyListeners();
  }

  //for interactive styling in addTeamToTournament page, to know what tournament to push teams into
  int getTournamentToAddTeamInd() {
    return tournamentToAddTeamInd;
  }

  int getTeamToViewMembersInd() {
    return teamToViewMembers;
  }

  //for interactive styling in addTeamToTournament page, to know what tournament to push teams into
  void setTournamentToAddTeamInd(int ind) {
    tournamentToAddTeamInd = ind;
    notifyListeners();
  }

  void setTeamToViewMembersInd(int ind) {
    teamToViewMembers = ind;
    notifyListeners();
  }

  List<Team> getTeams() {
    return [...teams];
  }

  //when selecting a team in addTeamToTournament page to keep track and provide interactive style
  void setSelectedTeamsForTournament(int teamInd) {
    selectedTeamsToBeAdded.add(teamInd);

    notifyListeners();
  }

  //when removing a team in addTeamToTournament page by clicking twice, to keep track and provide interactive style
  void removeFromSelectedTeamsForTournament(int teamInd) {
    selectedTeamsToBeAdded.remove(teamInd);

    notifyListeners();
  }

  //to get the indexes of the selected teams and style them
  List<int> getIndexesOfTeamsCurrentlySelected() {
    return [...selectedTeamsToBeAdded];
  }

  //to make sure previously selected teams are now gone
  void emptySelectedTeamIndexes() {
    selectedTeamsToBeAdded.clear();
  }

  int getIndOfTeamToSelectCap() {
    return teamToSelectCaptainInd;
  }

  List<Player> getPlayersOfTeam(int indOfTeam) {
    //sql code to search players of specific team
    return [...playersOfTeam];
  }

  void setTeamToSelectCapInd(int ind) {
    if (ind == -1) {
      getTeamsInit();
    }
    teamToSelectCaptainInd = ind;
    notifyListeners();
  }

  void setCaptain(int ind, int indTeam) async {
    await DataBaseHelper.instance.setCaptain(
        playersOfTeam.elementAt(ind).id, teams.elementAt(indTeam).id);
  }

  void getNumberOfUsersForIdReg() async {
    var result = await DataBaseHelper.instance.getNumberOfUsersToGenId();
    numOfUsers = result;
  }

  void getNumberOfTournamentsForIdReg() async {
    var result = await DataBaseHelper.instance.getNumberOfTournamentsToGenId();
    numOfTournaments = result;
  }

  Future<void> addTeamToTournament(int tournamentId) async {
    selectedTeamsToBeAdded.forEach((element) async {
      await DataBaseHelper.instance
          .addTeamToTournament(teams.elementAt(element).id, tournamentId);
    });
  }

  Future<void> initPlayersInTeam() async {
    playersOfTeam = [];
    var result = await DataBaseHelper.instance
        .getPlayersInTeam(teams.elementAt(teamToSelectCaptainInd).id);
    int? teamCaptId = teams.elementAt(teamToSelectCaptainInd).captain_id;
    result.forEach((element) {
      playersOfTeam.add(Player(
          name: "${element['Fname']} ${element['Lname']}",
          id: element['KFUPM_ID'],
          captain: element['KFUPM_ID'] == teamCaptId ? true : false));
    });
  }

  Future<void> getMatchResults(int tournamentId) async {
    matches = [];
    var result = await DataBaseHelper.instance
        .getMatchResults(tournaments.elementAt(tournamentId).id)
        .then((value) {
      if (value.isEmpty) {
        return;
      } else {
        value.forEach((element) {
          matches.add(Matchh(
              awayScore: element['Away_Team_Score'],
              homeScore: element['Home_Team_Score'],
              matchDate: element['Match_Date'],
              matchTime: element['Match_Time']));
        });
      }
    });
  }

  List<Matchh> getMatches() {
    return [...matches];
  }

  Future<List<Player>> getCards() async {
    List<Player> result = [];
    await DataBaseHelper.instance.getRedCards().then((value) {
      result.add(Player(
          name: "${value[0]['Fname']} ${value[0]['Lname']}",
          id: 0,
          dateOfCard: value[0]['Match_Date'],
          team: value[0]['Team_Name']));
    });
    return result;
  }

  Future<Map<String, dynamic>> getScorer() async {
    List<Map<String, dynamic>> result =
        await DataBaseHelper.instance.getHighestScorer();

    return result[0];
  }

  Future<void> getTeamMembers(int teamInd) async {
    members = [];
    List<Map<String, dynamic>> result = await DataBaseHelper.instance
        .getMembersOfTeam(teams.elementAt(teamInd).id);
    result.forEach((element) {
      //print(element);
      members.add(Member(
          name: "${element['Fname']} ${element['Lname']}",
          type: element['MEMBER_TYPE']));
    });
  }

  List<Member> getTeamMembersList() {
    return [...members];
  }

  Future<void> requetPlayerAddition(
      String firstName,
      String lastName,
      String dateOfBirth,
      String email,
      int kfupmId,
      String departmentName,
      int teamId) async {
    await DataBaseHelper.instance.requetPlayerAddition(firstName, lastName,
        dateOfBirth, email, kfupmId, departmentName, teamId);
  }

  Future<void> getRequests() async {
    requests = [];
    var result = await DataBaseHelper.instance.getRequests();
    result.forEach((element) {
      requests.add(Request(
          dateOfBirth: element['Date_Of_Birth'],
          departmentName: element['Department_Name'],
          email: element['Email'],
          firstName: element['Fname'],
          kfupmId: element['KFUPM_ID'],
          lastName: element['Lname'],
          teamId: element['Team_ID']));
    });
  }

  List<Request> getRequestList() {
    return [...requests];
  }

  void acceptRequest(Request req) {
    DataBaseHelper.instance.acceptRequest(
        req.firstName,
        req.lastName,
        req.dateOfBirth,
        req.email,
        req.kfupmId,
        req.departmentName,
        req.teamId);
  }
}
