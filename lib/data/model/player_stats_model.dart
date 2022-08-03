// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/entities/player_stats.dart';

PlayerStatsModel playerStatsModelFromJson(String str) =>
    PlayerStatsModel.fromJson(json.decode(str));

String playerStatsModelToJson(PlayerStatsModel data) =>
    json.encode(data.toJson());

class ListPlayerStats {
  List<PlayerStatsModel> listPlayersStats = [];

  ListPlayerStats();

  ListPlayerStats.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final playerStat = PlayerStatsModel.fromJson(item);
      listPlayersStats.add(playerStat);
    }
  }
}

class PlayerStatsModel extends PlayerStats {
  PlayerStatsModel(
      {required this.idPlayerStats,
      required this.goal,
      required this.assist,
      required this.yellowCard,
      required this.redCard,
      required this.tournamentModel,
      required this.playerModel})
      : super(
          idPlayerStats: idPlayerStats,
          goal: goal,
          assist: assist,
          yellowCard: yellowCard,
          redCard: redCard,
          tournamentModelE: tournamentModel,
          playerModelE: playerModel,
        );

  int idPlayerStats;
  int goal;
  int assist;
  int yellowCard;
  int redCard;
  TournamentModel tournamentModel;
  PlayerModel playerModel;

  factory PlayerStatsModel.fromJson(Map<String, dynamic> json) =>
      PlayerStatsModel(
        idPlayerStats: json["idPlayerStats"],
        goal: json["goal"],
        assist: json["assist"],
        yellowCard: json["yellow_card"],
        redCard: json["red_card"],
        tournamentModel: TournamentModel.fromJson(json["tournament"]),
        playerModel: PlayerModel.fromJson(json["player"]),
      );

  Map<String, dynamic> toJson() => {
        "goal": goal,
        "assist": assist,
        "yellow_card": yellowCard,
        "red_card": redCard,
        "tournament": tournamentModel.toJson(),
        "player": playerModel.toJson(),
      };
}
