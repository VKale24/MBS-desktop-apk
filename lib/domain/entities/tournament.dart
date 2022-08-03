class Tournament {
  int idTournament;
  String name;
  int duration;
  int quantityTeams;
  String image;
  DateTime createdAt;
  bool active;

  Tournament({
    required this.name,
    required this.active,
    required this.image,
    required this.createdAt,
    required this.duration,
    required this.idTournament,
    required this.quantityTeams,
  });
}
