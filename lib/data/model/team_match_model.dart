// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/domain/entities/team_match.dart';

TeamModel teamMatchModelFromJson(String str) =>
    TeamModel.fromJson(json.decode(str));

String teamMatchModelToJson(TeamModel data) => json.encode(data.toJson());

class ListTeamMatchs {
  List<TeamMatchModel> listTeamMatchs = [];

  ListTeamMatchs();

  ListTeamMatchs.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final teamMatch = TeamMatchModel.fromJson(item);
      listTeamMatchs.add(teamMatch);
    }
  }
}

class TeamMatchModel extends TeamMatch {
  TeamMatchModel({
    required this.idTeamMatch,
    required this.teamModel,
    required this.matchModel,
    required this.state,
  }) : super(
          idTeamMatch: idTeamMatch,
          state: state,
          teamModel: teamModel,
          matchModel: matchModel,
        );

  int idTeamMatch;
  TeamModel teamModel;
  MatchModel matchModel;
  String state;

  factory TeamMatchModel.fromJson(Map<String, dynamic> json) => TeamMatchModel(
        idTeamMatch: json["idTeamMatch"],
        state: json["state"],
        teamModel: TeamModel.fromJson(json["team"]),
        matchModel: MatchModel.fromJson(json["match"]),
      );

  Map<String, dynamic> toJson() => {
        "idTeamMatch": idTeamMatch,
        "state": state,
        "teamModel": teamModel.toJson(),
        "matchModel": matchModel.toJson(),
      };
}
