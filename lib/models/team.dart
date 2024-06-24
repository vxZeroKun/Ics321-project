class Team {
  String name;
  String JerseyColor;
  int id;
  int? captain_id;
  Team(
      {required this.JerseyColor,
      required this.name,
      required this.id,
      this.captain_id});
}
