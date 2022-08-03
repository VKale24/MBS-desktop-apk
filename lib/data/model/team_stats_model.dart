// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:desktop_apk/domain/entities/team_stats.dart';

TeamStatsModel teamStatsModelFromJson(String str) =>
    TeamStatsModel.fromJson(json.decode(str));

String teamStatsModelToJson(TeamStatsModel data) => json.encode(data.toJson());

class ListTeamStats {
  List<TeamStatsModel> listTeamStats = [];

  ListTeamStats();

  ListTeamStats.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final teamStats = TeamStatsModel.fromJson(item);
      listTeamStats.add(teamStats);
    }
  }
}

class TeamStatsModel extends TeamStats {
  TeamStatsModel({
    required this.idTeamStats,
    required this.goal,
    required this.assist,
    required this.yellowCard,
    required this.redCard,
  }) : super(
            idTeamStats: idTeamStats,
            goal: goal,
            assist: assist,
            yellowCard: yellowCard,
            redCard: redCard);

  int idTeamStats;
  int goal;
  int assist;
  int yellowCard;
  int redCard;

  factory TeamStatsModel.fromJson(Map<String, dynamic> json) => TeamStatsModel(
        idTeamStats: json["idTeamStats"],
        goal: json["goal"],
        assist: json["assist"],
        yellowCard: json["yellow_card"],
        redCard: json["red_card"],
      );

  Map<String, dynamic> toJson() => {
        "idTeamStats": idTeamStats,
        "goal": goal,
        "assist": assist,
        "yellowCard": yellowCard,
        "redCard": redCard,
      };
}
