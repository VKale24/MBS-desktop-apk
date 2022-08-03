// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:desktop_apk/domain/entities/tournament.dart';

TournamentModel tournamentModelFromJson(String str) =>
    TournamentModel.fromJson(json.decode(str));

String tournamentModelToJson(TournamentModel data) =>
    json.encode(data.toJson());

class Tournaments {
  List<TournamentModel> tournaments = [];

  Tournaments();

  Tournaments.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final tournament = TournamentModel.fromJson(item);
      tournaments.add(tournament);
    }
  }
}

class TournamentModel extends Tournament {
  TournamentModel({
    required this.name,
    required this.image,
    required this.createdAt,
    required this.duration,
    required this.idTournament,
    required this.quantityTeams,
    required this.active,
  }) : super(
            active: active,
            createdAt: createdAt,
            duration: duration,
            idTournament: idTournament,
            image: image,
            name: name,
            quantityTeams: quantityTeams);

  int idTournament;
  String name;
  int duration;
  int quantityTeams;
  String image;
  DateTime createdAt;
  bool active;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      TournamentModel(
        idTournament: json["idTournament"],
        name: json["name"],
        image: json["image"],
        active: json["active"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["created_at"]),
        quantityTeams: json["quantityTeams"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "duration": duration,
        "quantityTeams": quantityTeams,
      };

  @override
  String toString() {
    return "idTournament: $idTournament \n name: $name  \n image: $image  \n active: $active \n duration: $duration \n duration: $createdAt \n createdAt: $image \n quantityTeams: $quantityTeams";
  }
}
