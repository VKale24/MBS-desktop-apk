class Team {
  final int idTeam;
  final String name;
  final String captain;
  final String manager;
  final String equipationColor;
  final String image;
  final String headerImage;
  final String description;
  final String town;
  final bool active;

  Team({
    required this.name,
    required this.idTeam,
    required this.captain,
    required this.manager,
    required this.equipationColor,
    required this.image,
    required this.headerImage,
    required this.description,
    required this.town,
    required this.active,
  });
}
