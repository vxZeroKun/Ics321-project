import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static final _dbName = 'ProjectIcs321Term222ver6.db';
  static final _version = 1;

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initiateDataBase();

    return _database;
  }

  Future<Database> initiateDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(
      path,
      version: _version,
      onCreate: onCreates,
    );
  }

  Future onCreates(Database db, int vers) async {
    await db.execute('''
CREATE TABLE USER (
 User_ID INTEGER NOT NULL,
 User_Name TEXT NOT NULL,
 Password TEXT NOT NULL,
 User_Type TEXT NOT NULL,
 Email TEXT NOT NULL,
 PRIMARY KEY (User_ID)
);
''');
    await db.rawInsert('''
INSERT INTO USER(User_ID, User_Name, Password, User_Type, Email) VALUES (1, "Mohammad", "123456", "Admin", "mmmakki9@gmail.com");
''');
    await db.execute('''
CREATE TABLE TOURNAMENT
(
 Tournament_Name TEXT NOT NULL,
 Tournament_ID INTEGER NOT NULL,
 Start_Date TEXT NOT NULL,
 End_Date TEXT NOT NULL,
 PRIMARY KEY (Tournament_ID)
);
''');
    await db.rawInsert('''
INSERT INTO TOURNAMENT (Tournament_Name, Tournament_ID, Start_Date, End_Date)
VALUES
('KFUPM Super Cup', 10001, '2023-05-12', '2023-05-15'),
('KFUPM Champions League', 10002, '2023-05-17', '2023-05-20'),
('KFUPM Premier League', 10003, '2023-05-22', '2023-05-25');
''');
    await db.execute('''
CREATE TABLE MATCH_RESULTS
(
  Result_ID INTEGER AUTO_INCREMENT, 
  Tournament_ID INTEGER NOT NULL,
  Match_ID INTEGER NOT NULL,
  Home_Team_Score INTEGER NOT NULL,
  Away_Team_Score INTEGER NOT NULL,
  PRIMARY KEY (Result_ID),
  FOREIGN KEY (Match_ID) REFERENCES MATCHES(Match_ID),
  FOREIGN KEY (Tournament_ID) REFERENCES TOURNAMENT(Tournament_ID)
 );
''');
    await db.rawInsert('''
INSERT INTO MATCH_RESULTS (Tournament_ID, Match_ID, Home_Team_Score, Away_Team_Score)
VALUES 
(10001, 10001, 0, 1),
(10001, 10002, 2, 1),
(10001, 10003, 4, 1),
(10002, 10004, 0, 2),
(10002, 10005, 3, 1),
(10002, 10006, 6, 1),
(10003, 10007, 1, 1),
(10003, 10008, 2, 1),
(10003, 10009, 4, 3);
''');
    await db.execute('''
CREATE TABLE MATCHES
(
 Match_Date DATE NOT NULL,
 Match_Time TEXT NOT NULL,
 Match_ID INTEGER NOT NULL,
 Tournament_ID INTEGER NOT NULL,
 Home_Team_ID INTEGER NOT NULL,
 Away_Team_ID INTEGER NOT NULL,
 PRIMARY KEY (Match_ID),
 FOREIGN KEY (Tournament_ID) REFERENCES Tournaments(Tournament_ID)
);
''');
    await db.rawInsert('''
INSERT INTO MATCHES (Match_Date, Match_Time, Match_ID, Tournament_ID, Home_Team_ID, Away_Team_ID)
VALUES
('2023-05-13', '10:00 AM', 10001, 10001, 10001, 10002),
('2023-05-13', '12:00 PM', 10002, 10001, 10003, 10004),
('2023-05-13', '2:00 PM', 10003, 10001, 10005, 10006),
('2023-05-14', '10:00 AM', 10004, 10002, 10007, 10008),
('2023-05-14', '12:00 PM', 10005, 10002, 10009, 10010),
('2023-05-14', '2:00 PM', 10006, 10002, 10011, 10012),
('2023-05-15', '10:00 AM', 10007, 10003, 10013, 10014),
('2023-05-15', '12:00 PM', 10008, 10003, 10001, 10003),
('2023-05-15', '2:00 PM', 10009, 10003, 10002, 10004);
''');
    await db.execute('''
CREATE TABLE TEAMS
(
 Team_Name TEXT NOT NULL,
 Team_ID INTEGER NOT NULL,
 Team_Address TEXT NOT NULL,
 Website TEXT NOT NULL,
 Email TEXT NOT NULL,
 NumberOfPlayers INTEGER NOT NULL,
 Jersey_Color TEXT NOT NULL,
 Tournament_ID INTEGER NOT NULL,
 Captain_ID INTEGER,
 PRIMARY KEY (Team_ID),
 FOREIGN KEY (Tournament_ID) REFERENCES Tournaments(Tournament_ID),
 FOREIGN KEY (Captain_ID) REFERENCES Captain(Captain_ID)

);
''');
    await db.rawInsert('''
INSERT INTO TEAMS (Team_Name, Team_ID, Team_Address, Website, Email, NumberOfPlayers, Jersey_Color, Tournament_ID,Captain_ID)
VALUES
('KFUPM Falcons', 10001, 'KFUPM Main Campus', 'www.kfupmfalcons.com', 'kfupmfalcons@gmail.com', 16, 'Red', 10001, NULL),
('KFUPM Eagles', 10002, 'KFUPM Main Campus', 'www.kfupmeagles.com', 'kfupmeagles@gmail.com', 16, 'Blue', 10001, NULL),
('KFUPM Tigers', 10003, 'KFUPM Main Campus', 'www.kfupmtigers.com', 'kfupmtigers@gmail.com', 16, 'Green', 10001, NULL),
('KFUPM Lions', 10004, 'KFUPM Main Campus', 'www.kfupmlions.com', 'kfupmlions@gmail.com', 16, 'Yellow', 10001, NULL),
('KFUPM Bears', 10005, 'KFUPM Main Campus', 'www.kfupmbears.com', 'kfupmbears@gmail.com', 16, 'Black', 10001, NULL),
('KFUPM Wolves', 10006, 'KFUPM Main Campus', 'www.kfupmwolves.com', 'kfupmwolves@gmail.com',16, 'White', 10001,NULL),
('KFUPM Sharks', 10007, 'KFUPM Main Campus', 'www.kfupmsharks.com', 'kfupmsharks@gmail.com', 16, 'Pink', 10001, NULL),
('KFUPM Dolphins', 10008, 'KFUPM Main Campus', 'www.kfupmdolphins.com', 'kfupmdolphins@gmail.com', 16, 'Purple', 10001, NULL),
('KFUPM Penguins', 10009, 'KFUPM Main Campus', 'www.kfupmpenguins.com', 'kfupmpenguins@gmail.com', 16, 'Brown', 10001, NULL),
('KFUPM Cougars', 10010, 'KFUPM Main Campus', 'www.kfupmcougars.com', 'kfupmcougars@gmail.com', 16, 'Orange', 10001, NULL),
('KFUPM Stallions', 10011, 'KFUPM Main Campus', 'www.kfupmstallions.com', 'kfupmstallions@gmail.com', 16, 'Gray', 10001, NULL),
('KFUPM Zebras', 10012, 'KFUPM Main Campus', 'www.kfupmzebras.com', 'kfupmzebras@gmail.com', 16, 'Coral', 10001, NULL),
('KFUPM Giraffes', 10013, 'KFUPM Main Campus', 'www.kfupmgiraffes.com', 'kfupmgiraffes@gmail.com', 16, 'Lime', 10001, NULL),
('KFUPM Ostriches', 10014, 'KFUPM Main Campus', 'www.kfupmostriches.com', 'kfupmostriches@gmail.com', 16, 'Teal', 10001, NULL);

''');
    await db.execute('''
CREATE TABLE FIELD
(
 Field_Name TEXT NOT NULL,
 Feild_Number INTEGER NOT NULL,
 Description TEXT NOT NULL,
 Status TEXT NOT NULL,
 Match_ID INTEGER NOT NULL,
 PRIMARY KEY (Field_Name, Feild_Number),
 FOREIGN KEY (Match_ID) REFERENCES Matches(Match_ID)
);
''');
    await db.rawInsert('''
INSERT INTO FIELD (Field_Name, Feild_Number, Description, Status, Match_ID)
VALUES
('Field 1', 1, 'Grass field', 'Active', 10001),
('Field 2', 2, 'Artificial turf', 'Not Active', 10002),
('Field 3', 3, 'Clay court', 'Active', 10003);
''');
    await db.execute('''
CREATE TABLE GOAL
(
 Time TEXT NOT NULL,
 Goal_ID INTEGER NOT NULL,
 Match_ID INTEGER NOT NULL,
 PRIMARY KEY (Goal_ID),
 FOREIGN KEY (Match_ID) REFERENCES Matches(Match_ID)
);
''');
    await db.rawInsert('''
INSERT INTO GOAL (Time, Goal_ID, Match_ID)
VALUES
('45', 1, 10001),
('66', 2, 10001),
('92', 3, 10001),
('3', 4, 10002),
('32', 5, 10002),
('70', 6, 10002);
''');

    await db.execute('''
CREATE TABLE PENALTY_SHOOT_OUT
(
 Has_Scored TEXT NOT NULL,
 Penalty_ID INTEGER NOT NULL,
 Match_ID INTEGER NOT NULL,
 PRIMARY KEY (Penalty_ID),
 FOREIGN KEY (Match_ID) REFERENCES Matches(Match_ID)
);
''');
    await db.rawInsert('''
INSERT INTO PENALTY_SHOOT_OUT (Has_Scored, Penalty_ID, Match_ID)
VALUES
('Yes', 1, 10001),
('No', 2, 10001),
('Yes', 3, 10001),
('No', 4, 10002),
('Yes', 5, 10002),
('No', 6, 10002);
''');
    await db.execute('''
CREATE TABLE KFUPM_MEMBER
(
 Fname TEXT NOT NULL,
 Lname TEXT NOT NULL,
 Date_Of_Birth TEXT NOT NULL,
 Email TEXT NOT NULL,
 KFUPM_ID INTEGER NOT NULL,
 Department_Name TEXT NOT NULL,
 Team_ID INTEGER,
 PRIMARY KEY (KFUPM_ID),
 FOREIGN KEY (Team_ID) REFERENCES Teams(Team_ID)
);
''');

    await db.execute('''
ALTER TABLE KFUPM_MEMBER ADD MEMBER_TYPE TEXT;
''');
    await db.rawInsert('''
INSERT INTO KFUPM_MEMBER (Fname, Lname, Date_Of_Birth, Email, KFUPM_ID, Department_Name, Team_ID)
VALUES
('John', 'Doe', '1990-01-01', 'johndoe@gmail.com', 10001, 'Computer Science', NULL),
('Jane', 'Doe', '1991-02-02', 'janedoe@gmail.com', 10002, 'Electrical Engineering', NULL),
('Peter', 'Smith', '1992-03-03', 'petersmith@gmail.com', 10003, 'Mechanical Engineering', 10002),
('Mary', 'Johnson', '1993-04-04', 'maryjohnson@gmail.com', 10004, 'Civil Engineering', 10001),
('David', 'Williams', '1994-05-05', 'davidwilliams@gmail.com', 30005, 'Chemical Engineering', 10004),
('Michael', 'Brown', '1995-06-06', 'michaelbrown@gmail.com', 10006, 'Petroleum Engineering', 10005),
('Sarah', 'Green', '1996-07-07', 'sarahgreen@gmail.com', 10007, 'Materials Science and Engineering', 10006),
('Alex', 'White', '1997-08-08', 'alexwhite@gmail.com', 10008, 'Bioengineering', 10007),
('Kevin', 'Black', '1998-09-09', 'kevinblack@gmail.com', 10009, 'Architecture', 10008),
('Emily', 'Pink', '1999-10-10', 'emilypink@gmail.com', 10010, 'Industrial Engineering', 10009),
('Christopher', 'Gray', '2000-11-11', 'christophergray@gmail.com', 10011, 'Mathematics', 10010),
('Alice', 'Johnson', '1993-04-04', 'alicejohnson@gmail.com', 20001, 'Chemical Engineering', 10000),
('Bob', 'Williams', '1994-05-05', 'bobwilliams@gmail.com', 20002, 'Civil Engineering', 10001),
('Charlie', 'Brown', '1995-06-06', 'charliebrown@gmail.com', 20003, 'Industrial Engineering', 10002),
('Dave', 'Davis', '1996-07-07', 'davedavis@gmail.com', 30001, 'Petroleum Engineering', 10004),
('Eve', 'Evans', '1997-08-08', 'eveevans@gmail.com', 30002, 'Aerospace Engineering', 10006),
('Frank', 'Franklin', '1998-09-09', 'frankfranklin@gmail.com', 30003, 'Environmental Engineering', 10008),
('Grace', 'Green', '1999-10-10', 'gracegreen@gmail.com', 30004, 'Materials Science and Engineering', 10003),
('Adam', 'Harris', '1999-01-01', 'adamharris@gmail.com', 10111, 'Physics', 10011),
('Benjamin', 'Isaacs', '1999-02-02', 'benjaminisaacs@gmail.com', 10012, 'Mathematics', 10012),
('Caleb', 'Jackson', '1999-03-03', 'calebjackson@gmail.com', 10013, 'Chemistry', 10013),
('Daniel', 'Kline', '2000-04-04', 'danielkline@gmail.com', 10014, 'Biology', 10014),
('Ethan', 'Lee', '2000-05-05', 'ethanlee@gmail.com', 10015, 'Geology', 10014),
('Gabriel', 'Moore', '2001-06-06', 'gabrielmoore@gmail.com', 10016, 'Statistics', 10013),
('Jacob', 'Nelson', '2001-07-07', 'jacobnelson@gmail.com', 10017, 'Economics', 10012),
('Joshua', 'Owens', '2002-08-08', 'joshuaowens@gmail.com', 10018, 'Finance', 10011),
('Luke', 'Perez', '2002-09-09', 'lukeperez@gmail.com', 10020, 'Marketing', 10010),
('Matthew', 'Quinn', '2003-10-10', 'matthewquinn@gmail.com', 10021, 'Accounting', 10009);
''');
    await db.rawUpdate('''
UPDATE KFUPM_MEMBER
SET MEMBER_TYPE = CASE
    WHEN Team_ID IS NULL THEN 'REFEREE'
    WHEN substr(KFUPM_ID, 1, 1) = '2' THEN 'MANAGER'
    WHEN substr(KFUPM_ID, 1, 1) = '3' THEN 'COACH'
    ELSE 'PLAYER'
END;
''');
    await db.execute('''
CREATE TABLE PLAYER
(
 Position TEXT NOT NULL,
 Status TEXT NOT NULL,
 Player_Type TEXT NOT NULL,
 Player_Number INTEGER NOT NULL,
 KFUPM_ID INTEGER NOT NULL,
 PRIMARY KEY (Player_Number),
 FOREIGN KEY (KFUPM_ID) REFERENCES KFUPM_Members(KFUPM_ID)
);
''');
    await db.rawInsert('''
INSERT INTO PLAYER (Position, Status, Player_Type, Player_Number, KFUPM_ID)
VALUES
('Goalkeeper', 'Available', 'Starter', 1, 10111),
('Defender', 'Available', 'Sub', 2, 10011),
('Midfielder', 'Available', 'Starter', 3, 10003),
('Forward', 'Available', 'Starter', 4, 10001),
('Goalkeeper', 'Available', 'Starter', 5, 10004),
('Defender', 'Available', 'Sub', 6, 10005),
('Midfielder', 'Available', 'Starter', 7, 10006),
('Forward', 'Injured', 'Starter', 8, 10004),
('Goalkeeper', 'Available', 'Starter', 9, 10012),
('Defender', 'Available', 'Sub', 10, 10008),
('Midfielder', 'Injured', 'Starter', 11, 10009),
('Forward', 'Available', 'Starter', 12, 10007);
''');
    await db.execute('''
CREATE TABLE MAIN_COACH
(
License_Num INTEGER NOT NULL,
 License_Expire_Data TEXT NOT NULL,
 KFUPM_ID INTEGER NOT NULL,
 PRIMARY KEY (License_Num),
 FOREIGN KEY (KFUPM_ID) REFERENCES KFUPM_Members(KFUPM_ID)
);
''');
    await db.rawInsert('''
INSERT INTO MAIN_COACH (License_Num, License_Expire_Data, KFUPM_ID) VALUES
(123456, '2023-05-12', 100000),
(234567, '2023-06-12', 200000),
(345678, '2023-07-12', 300000);

''');
    await db.execute('''
CREATE TABLE MANAGER
(
 Playing_Experience TEXT NOT NULL,
 Manager_ID INTEGER NOT NULL,
 KFUPM_ID INTEGER NOT NULL,
 PRIMARY KEY (Manager_ID),
 FOREIGN KEY (KFUPM_ID) REFERENCES KFUPM_Members(KFUPM_ID)
);
''');
    await db.rawInsert('''
INSERT INTO MANAGER (Playing_Experience, Manager_ID, KFUPM_ID) VALUES
('10 years', 400000, 400000),
('5 years', 500000, 500000),
('2 years', 600000, 600000);
''');
    await db.execute('''
CREATE TABLE BEST_PLAYER
(
 Num_Of_Passes INTEGER NOT NULL,
 Running_Distance REAL NOT NULL,
 Num_Of_Shoots INTEGER NOT NULL,
 Match_ID INTEGER NOT NULL,
 Player_Number INTEGER NOT NULL,
 PRIMARY KEY (Match_ID, Player_Number),
 FOREIGN KEY (Match_ID) REFERENCES Matches(Match_ID),
 FOREIGN KEY (Player_Number) REFERENCES Players(Player_Number)
);
''');
    await db.rawInsert('''
INSERT INTO BEST_PLAYER (Num_Of_Passes, Running_Distance, Num_Of_Shoots, Match_ID, Player_Number) VALUES
(100, 1000, 50, 10001, 1),
(200, 2000, 100, 10002, 2),
(300, 3000, 150, 10003, 3);
''');
    await db.execute('''
CREATE TABLE REFREE
(
 Has_International_License INTEGER NOT NULL,
 Refree_Type TEXT(15) NOT NULL,
 Local_LicenseID INTEGER NOT NULL,
 Match_ID INTEGER NOT NULL,
 KFUPM_ID INTEGER NOT NULL,
 PRIMARY KEY (Local_LicenseID, KFUPM_ID),
 FOREIGN KEY (Match_ID) REFERENCES Matches(Match_ID),
 FOREIGN KEY (KFUPM_ID) REFERENCES KFUPM_Members(KFUPM_ID)
);
''');
    await db.rawInsert('''
INSERT INTO REFREE (Has_International_License, Refree_Type, Local_LicenseID, Match_ID, KFUPM_ID) VALUES
(1, 'FIFA', 1000000, 10003, 70345),
(0, 'AFC', 2000000, 10005, 81029),
(0, 'UEFA', 3000000, 10006, 92341);
''');
    await db.execute('''
CREATE TABLE SUBSTITUTION
(
 Time TEXT NOT NULL,
 Subs_ID INTEGER NOT NULL,
 Match_ID INTEGER NOT NULL,
 PRIMARY KEY (Subs_ID),
 FOREIGN KEY (Match_ID) REFERENCES Matches(Match_ID)
);
''');
    await db.rawInsert('''
INSERT INTO SUBSTITUTION (Time, Subs_ID, Match_ID) VALUES
('10 minutes', 100000, 10001),
('20 minutes', 200000, 10003),
('30 minutes', 300000, 10005);

''');
    await db.execute('''
CREATE TABLE CAPTAIN
(
 Captain_ID INTEGER NOT NULL,
 KFUPM_ID INTEGER NOT NULL,
 Player_Number INTEGER NOT NULL,
 PRIMARY KEY (Captain_ID),
 FOREIGN KEY (KFUPM_ID) REFERENCES KFUPM_Members(KFUPM_ID),
 FOREIGN KEY (Player_Number) REFERENCES Players(Player_Number)
);
''');
    await db.rawInsert('''
INSERT INTO CAPTAIN (Captain_ID, KFUPM_ID, Player_Number) VALUES
(100001, 100000, 1),
(200001, 200000, 2),
(300001, 300000, 3);
''');
    await db.execute('''
CREATE TABLE TEAMS_CONTACT_NUMBERS
(
 Contact_Numbers INTEGER NOT NULL,
 Team_ID INTEGER NOT NULL,
 PRIMARY KEY (Contact_Numbers, Team_ID),
 FOREIGN KEY (Team_ID) REFERENCES Teams(Team_ID)
);
''');
    await db.rawInsert('''
INSERT INTO TEAMS_CONTACT_NUMBERS (Contact_Numbers, Team_ID) VALUES
(111111, 10003),
(222222, 10004),
(333333, 10001);
''');
    await db.execute('''
CREATE TABLE KFUPM_MEMBERS_TELEPHONES 
(
 Phone_Number INTEGER NOT NULL,
 KFUPM_ID INTEGER NOT NULL,
 PRIMARY KEY (Phone_Number, KFUPM_ID),
 FOREIGN KEY (KFUPM_ID) REFERENCES KFUPM_Members(KFUPM_ID)
);
''');
    await db.rawInsert('''
INSERT INTO KFUPM_MEMBERS_TELEPHONES (Phone_Number, KFUPM_ID) VALUES
(123456, 10234),
(234567, 20394),
(345678, 38273);
''');
    await db.execute('''
CREATE TABLE SUBSTITUTED
(
 Subs_Type TEXT NOT NULL,
 Subs_ID INTEGER NOT NULL,
 Player_Number INTEGER NOT NULL,
 PRIMARY KEY (Subs_ID, Player_Number),
 FOREIGN KEY (Subs_ID) REFERENCES Substitution(Subs_ID),
 FOREIGN KEY (Player_Number) REFERENCES Players(Player_Number)
);
''');
    await db.rawInsert('''
INSERT INTO SUBSTITUTED (Subs_Type, Subs_ID, Player_Number) VALUES
('IN', 100001, 1),
('OUT', 100002, 2),
('IN', 200001, 3),
('OUT', 200002, 4);
''');
    await db.execute('''
CREATE TABLE SHOOTERS
(
 Penalty_ID INTEGER NOT NULL,
 Player_Number INTEGER NOT NULL,
 PRIMARY KEY (Penalty_ID, Player_Number),
 FOREIGN KEY (Penalty_ID) REFERENCES PenaltyShootout(Penalty_ID),
 FOREIGN KEY (Player_Number) REFERENCES Players(Player_Number)
);
''');
    await db.rawInsert('''
INSERT INTO SHOOTERS (Penalty_ID, Player_Number) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);
''');
    await db.execute('''
CREATE TABLE GOAL_KEEPER
(
 Num_Of_Saved INTEGER NOT NULL,
 Player_Number INTEGER NOT NULL,
 Penalty_ID INTEGER NOT NULL,
 PRIMARY KEY (Player_Number, Penalty_ID),
 FOREIGN KEY (Player_Number) REFERENCES PenaltyShootout(Penalty_ID),
 FOREIGN KEY (Penalty_ID) REFERENCES Players(Player_Number)
);
''');
    await db.rawInsert('''
INSERT INTO GOAL_KEEPER (Num_Of_Saved, Player_Number, Penalty_ID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);
''');
    await db.execute('''
CREATE TABLE SCORERS
(
 Num_Of_Goals INTEGER NOT NULL,
 Goal_ID INTEGER NOT NULL,
 Player_Number INTEGER NOT NULL,
 PRIMARY KEY (Goal_ID),
 FOREIGN KEY (Goal_ID) REFERENCES Goal(Goal_ID),
 FOREIGN KEY (Player_Number) REFERENCES Players(Player_Number)
);
''');
    await db.rawInsert('''
INSERT INTO SCORERS (Num_Of_Goals, Goal_ID, Player_Number) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);
''');

    await db.execute('''
CREATE TABLE CARDS
(
Card_Time TEXT NOT NULL,
 Card_Type TEXT(10) NOT NULL,
 Card_ID INTEGER NOT NULL,
 Num_Of_Matches_Miss INTEGER NOT NULL,
 Match_ID INTEGER NOT NULL,
 Player_Number INTEGER NOT NULL,
 PRIMARY KEY (Card_ID),
 FOREIGN KEY (Match_ID) REFERENCES Matches(Match_ID),
 FOREIGN KEY (Player_Number) REFERENCES Players(Player_Number)
);
''');
    await db.rawInsert('''
INSERT INTO CARDS (Card_Time, Card_Type, Card_ID, Num_Of_Matches_Miss, Match_ID, Player_Number) VALUES
('10', 'Red', 1, 1, 10001, 5),
('75', 'Red', 2, 2, 10001, 3),
('60', 'Red', 3, 3, 10006, 9);
('69', 'Red', 4, 3, 10006, 1);

      ''');
    await db!.rawInsert('''


''');
  }

  Future<List<Map>> login(String userEmail, String password) async {
    Database? db = await instance.database;

    return await db!.query('USER',
        where: 'Email = ? AND Password = ?', whereArgs: [userEmail, password]);
  }

  Future<int> getNumberOfUsersToGenId() async {
    Database? db = await instance.database;

    List<Map<String, dynamic>> result =
        await db!.rawQuery('SELECT COUNT(User_Type) FROM USER;');
    return result[0]['COUNT(User_Type)'];
  }

  Future<void> register(String password, String email, String username,
      String type, int id) async {
    Database? db = await instance.database;

    int result = await db!.rawInsert(
        'INSERT INTO USER(User_ID,User_Name,Password,User_Type,Email) VALUES(?, ?, ?, ?, ?)',
        [id, username, password, type, email]);
    print(result);
  }

  Future<int> getNumberOfTournamentsToGenId() async {
    Database? db = await instance.database;

    List<Map<String, dynamic>> result =
        await db!.rawQuery('SELECT COUNT(Tournament_Name) FROM TOURNAMENT;');
    return result[0]['COUNT(Tournament_Name)'];
  }

  Future<void> createTournament(String tournamentName, String startDateTime,
      String endDateTime, int id) async {
    final db = await instance.database;
    int result = await db!.insert('TOURNAMENT', {
      'Tournament_Name': tournamentName,
      'Start_date': startDateTime,
      'End_date': endDateTime,
      'Tournament_ID': id,
    });
    if (result == 0) {
      print("did not insert");
    } else {
      print("inserted successfully");
    }
  }

  Future<void> deleteTournament(int id) async {
    final db = await instance.database;
    int result = await db!
        .delete("TOURNAMENT", where: 'Tournament_ID = ?', whereArgs: [id]);
    print("${result} rows deleted");
  }

  Future<List<Map<String, dynamic>>> getTournaments() async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db!.query(
      "TOURNAMENT",
      columns: null,
    );

    return result;
  }

  Future<List<Map<String, dynamic>>> getTeams() async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db!.query(
      "TEAMS",
      columns: null,
    );

    return result;
  }

  Future<void> addTeamToTournament(int teamId, int TournamentId) async {
    final db = await instance.database;
    int result = await db!.update('TEAMS', {'Tournament_ID': TournamentId},
        where: 'Team_ID = ?', whereArgs: [teamId]);
    print(
        "${result} of changes made to team table when adding team to tournament");
  }

  Future<List<Map<String, dynamic>>> getPlayersInTeam(int teamId) async {
    final db = await instance.database;

    List<Map<String, dynamic>> result = await db!.rawQuery('''
SELECT K.Fname, K.Lname, 
K.KFUPM_ID
FROM KFUPM_MEMBER K
WHERE K.Team_ID = ? AND K.MEMBER_TYPE = "PLAYER";
''', [teamId]);

    return result;
  }

  Future<void> setCaptainForTeam(int captainId) async {
    final db = await instance.database;
    //figure out where to add captain
    return;
  }

  Future<List<Map<String, dynamic>>> getMatchResults(int tournamentId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db!.rawQuery('''
SELECT
 MR.Home_Team_Score,
 MR.Away_Team_Score,
 M.Match_Date,
 M.Match_Time
FROM MATCHES M, MATCH_RESULTS MR
WHERE M.Tournament_ID = ? AND M.Match_ID = MR.Match_ID
ORDER BY M.Match_Date;
''', [tournamentId]);

    return result;
  }

  Future<List<Map<String, dynamic>>> getRedCards() async {
    final db = await instance.database;

    var result = await db!.rawQuery('''
SELECT
 K.Fname,
 K.Lname,
 T.Team_Name,
 M.Match_Date
FROM CARDS C, MATCHES M, TEAMS T, PLAYER P, KFUPM_MEMBER K
WHERE C.Card_Type = 'Red' AND M.Match_ID = C.Match_ID AND C.Player_Number = P.Player_Number
AND P.KFUPM_ID = K.KFUPM_ID AND K.Team_ID = T.Team_ID  AND
(T.Team_ID = M.Home_Team_ID OR T.Team_ID = M.Away_Team_ID)
GROUP BY T.Team_Name, K.Fname, M.Match_Date;
''');
    return result;
  }

  Future<List<Map<String, dynamic>>> getHighestScorer() async {
    final db = await instance.database;

    var result = await db!.rawQuery('''
SELECT
 K.Fname,
 K.Lname,
 K.KFUPM_ID,
 T.Team_Name,
 SUM(S.Num_Of_Goals)
FROM  SCORERS S, TEAMS T, PLAYER P, KFUPM_MEMBER K
WHERE S.Player_Number = P.Player_Number
AND P.KFUPM_ID = K.KFUPM_ID AND K.Team_ID = T.Team_ID
GROUP BY K.Fname, K.Lname
ORDER BY S.Num_Of_Goals DESC;
''');
    print(result);

    return result;
  }

  Future<List<Map<String, dynamic>>> getMembersOfTeam(int teamId) async {
    final db = await instance.database;
    var result = await db!.rawQuery('''
   SELECT Fname, Lname, MEMBER_TYPE
   FROM KFUPM_MEMBER
   WHERE Team_ID = ?;
''', [teamId]);

    return result;
  }

  Future<void> setCaptain(int kfupmId, int teamId) async {
    final db = await instance.database;
    int result = await db!.update("TEAMS", {'KFUPM_ID': kfupmId},
        where: 'Team_ID = ?', whereArgs: [teamId]);
    print("${result} changes made to teams table");
  }

  Future<void> requetPlayerAddition(
      String firstName,
      String lastName,
      String dateOfBirth,
      String email,
      int kfupmId,
      String departmentName,
      int teamId) async {
    final db = await instance.database;
    Map<String, dynamic> playerInfo = {
      'Fname': firstName,
      'Lname': lastName,
      'Date_Of_Birth': dateOfBirth,
      'Email': email,
      'KFUPM_ID': kfupmId,
      'Department_Name': departmentName,
      'Team_ID': teamId,
      'Member_Type': "PLAYER"
    };

    await db!.insert('request', playerInfo);
  }

  Future<List<Map<String, dynamic>>> getRequests() async {
    final db = await instance.database;
    var result = await db!.query("request", columns: null);
    print(result);
    return result;
  }

  Future<void> acceptRequest(
    String firstName,
    String lastName,
    String dateOfBirth,
    String email,
    int kfupmId,
    String departmentName,
    int teamId,
  ) async {
    final db = await instance.database;
    Map<String, dynamic> mapper = {
      'Fname': firstName,
      'Lname': lastName,
      'Date_Of_Birth': dateOfBirth,
      'Email': email,
      'KFUPM_ID': kfupmId,
      'Department_Name': departmentName,
      'Team_ID': teamId,
      'MEMBER_TYPE': "PLAYER"
    };
    int result1 = await db!.insert("KFUPM_MEMBER", mapper);
    print("${result1}? if not zero yippe");
    int result2 = await db!
        .delete('request', where: 'KFUPM_ID = ?', whereArgs: [kfupmId]);
    print("${result2} rows deleted from requests table");
  }
}
