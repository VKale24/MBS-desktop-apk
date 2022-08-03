// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/entities/roster.dart';

RosterModel rosterModelFromJson(String str) =>
    RosterModel.fromJson(json.decode(str));

String rosterModelToJson(RosterModel data) => json.encode(data.toJson());

class Rosters {
  List<RosterModel> playersRoster = [];

  Rosters();

  Rosters.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final roster = RosterModel.fromJson(item);
      playersRoster.add(roster);
    }
  }
}

class RosterModel extends Roster {
  RosterModel(
      {required this.idRoster,
      required this.teamModel,
      required this.tournamentModel,
      required this.playerModel,
      required this.playerActive})
      : super(
            idRoster: idRoster,
            teamModel: teamModel,
            tournamentModel: tournamentModel,
            playerModel: playerModel,
            playerActive: playerActive);

  int idRoster;
  TeamModel teamModel;
  TournamentModel tournamentModel;
  PlayerModel playerModel;
  bool playerActive;

  factory RosterModel.fromJson(Map<String, dynamic> json) => RosterModel(
        idRoster: json["idRoster"],
        teamModel: TeamModel.fromJson(json["team"]),
        playerModel: PlayerModel.fromJson(json["player"]),
        tournamentModel: TournamentModel.fromJson(json["tournament"]),
        playerActive: json["player_active"],
      );

  Map<String, dynamic> toJson() => {
        "team": teamModel.toJson(),
        "tournament": tournamentModel.toJson(),
        "player": playerModel.toJson(),
        "player_active": playerActive
      };
}
