// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/domain/entities/match_stats.dart';

MatchStatsModel matchStatsModelFromJson(String str) =>
    MatchStatsModel.fromJson(json.decode(str));

String matchStatsModelToJson(MatchStatsModel data) =>
    json.encode(data.toJson());

class ListMatchStats {
  List<MatchStatsModel> matchsStats = [];

  ListMatchStats();

  ListMatchStats.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final matchStats = MatchStatsModel.fromJson(item);
      matchsStats.add(matchStats);
    }
  }
}

class MatchStatsModel extends MatchStats {
  MatchStatsModel({
    required this.idMatchStats,
    required this.goal,
    required this.assist,
    required this.yellowCard,
    required this.redCard,
    required this.matchModel,
    required this.teamModel,
  }) : super(
          idMatchStats: idMatchStats,
          goal: goal,
          assist: assist,
          yellowCard: yellowCard,
          redCard: redCard,
          matchModel: matchModel,
          teamModel: teamModel,
        );

  int idMatchStats;
  int goal;
  int assist;
  int yellowCard;
  int redCard;
  MatchModel matchModel;
  TeamModel teamModel;

  factory MatchStatsModel.fromJson(Map<String, dynamic> json) =>
      MatchStatsModel(
        idMatchStats: json["idMatchStats"],
        goal: json["goals"],
        assist: json["assists"],
        yellowCard: json["yellow_card"],
        redCard: json["red_card"],
        teamModel: TeamModel.fromJson(json["team"]),
        matchModel: MatchModel.fromJson(json["match"]),
      );

  Map<String, dynamic> toJson() => {
        "goals": goal,
        "assists": assist,
        "yellow_card": yellowCard,
        "red_card": redCard,
        "team": teamModel.toJson(),
        "match": matchModel.toJson(),
      };
}
