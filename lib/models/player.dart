class Player {
  String name;
  int id;
  String? team = '';
  //crated this for red cards page purposes
  String? dateOfCard = '';
  int? goals;
  bool? captain = false;
  Player(
      {required this.name,
      required this.id,
      this.dateOfCard,
      this.team,
      this.goals,
      this.captain});
}
