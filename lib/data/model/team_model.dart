// ignore_for_file: overridden_fields, annotate_overrides, prefer_if_null_operators

import 'dart:convert';

import 'package:desktop_apk/domain/entities/team.dart';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());

class Teams {
  List<Team> teams = [];

  Teams();

  Teams.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final team = TeamModel.fromJson(item);
      teams.add(team);
    }
  }
}

class TeamModel extends Team {
  TeamModel({
    required this.idTeam,
    required this.name,
    required this.captain,
    required this.manager,
    required this.equipationColor,
    required this.image,
    required this.headerImage,
    required this.description,
    required this.town,
    required this.active,
  }) : super(
            idTeam: idTeam,
            name: name,
            captain: captain,
            manager: manager,
            equipationColor: equipationColor,
            image: image,
            headerImage: headerImage,
            description: description,
            town: town,
            active: active);

  int idTeam;
  String name;
  String captain;
  String manager;
  String equipationColor;
  String image;
  String headerImage;
  String description;
  String town;
  bool active;

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        idTeam: json["idTeam"],
        name: json["name"],
        captain: json["captain"] == null ? "-" : json["captain"],
        manager: json["manager"] == null ? "-" : json["manager"],
        equipationColor: json["equipationColor"],
        image: json["image"] == null ? "no image" : json["image"],
        headerImage: json["headerImage"] == null ? " " : json["headerImage"],
        description: json["description"],
        town: json["town"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "captain": captain,
        "manager": manager,
        "equipation_color": equipationColor,
        "image": image,
        "header_image": headerImage,
        "description": description,
        "town": town,
        //"active": active,
      };
}
