// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:desktop_apk/data/model/match_stats_model.dart';
import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/domain/entities/goal.dart';

GoalModel goalModelFromJson(String str) => GoalModel.fromJson(json.decode(str));

String goalModelToJson(GoalModel data) => json.encode(data.toJson());

class Goals {
  List<GoalModel> listGoals = [];

  Goals();

  Goals.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final goal = GoalModel.fromJson(item);
      listGoals.add(goal);
    }
  }
}

class GoalModel extends Goal {
  GoalModel(
      {required this.idGoal,
      required this.minute,
      required this.matchStatsModel,
      required this.playerModel})
      : super(
            idGoal: idGoal,
            minute: minute,
            matchStatsModel: matchStatsModel,
            playerModel: playerModel);

  int idGoal;
  int minute;
  MatchStatsModel matchStatsModel;
  PlayerModel playerModel;

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
        idGoal: json["idGoal"],
        minute: json["minute"],
        matchStatsModel: MatchStatsModel.fromJson(json["match_stats"]),
        playerModel: PlayerModel.fromJson(json["player"]),
      );

  Map<String, dynamic> toJson() => {
        "minute": minute,
        "player": playerModel.toJson(),
        "match_stats": matchStatsModel.toJson()
      };
}
