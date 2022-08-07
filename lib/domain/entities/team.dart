import '../../data/model/team_model.dart';

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

  TeamModel copyWithTeam({
    name,
    captain,
    manager,
    equipationColor,
    image,
    headerImage,
    description,
    town,
    active,
  }) =>
      TeamModel(
        idTeam: idTeam,
        name: name == "" ? this.name : name,
        captain: captain == "" ? this.captain : captain,
        manager: manager == "" ? this.manager : manager,
        equipationColor:
            equipationColor ?? this.equipationColor,
        image: image ?? this.image,
        headerImage: headerImage ?? this.headerImage,
        description: description == "" ? this.description : description,
        town: town == "" ? this.town : town,
        active: active ?? this.active,
      );
}
