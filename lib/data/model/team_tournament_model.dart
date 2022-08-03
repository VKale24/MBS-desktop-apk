// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:desktop_apk/data/model/stats_table_model.dart';
import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/data/model/team_stats_model.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/entities/team_tournament.dart';

TeamTournamentModel teamTournamentModelFromJson(String str) =>
    TeamTournamentModel.fromJson(json.decode(str));

String teamTournamentModelToJson(TeamTournamentModel data) =>
    json.encode(data.toJson());

class ListTeamTournaments {
  List<TeamTournamentModel> listTeamTournament = [];

  ListTeamTournaments();

  ListTeamTournaments.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final teamTournament = TeamTournamentModel.fromJson(item);
      listTeamTournament.add(teamTournament);
    }
  }
}

class TeamTournamentModel extends TeamTournament {
  TeamTournamentModel(
      {required this.idTeamTournament,
      required this.teamModel,
      required this.tournamentModel,
      required this.teamStatsModel,
      required this.statsTableMode,
      })
      : super(
            idTeamTournament: idTeamTournament,
            teamModel: teamModel,
            tournamentModel: tournamentModel,
            teamStatsModel: teamStatsModel,
            statsTableModel: statsTableMode,
            );

  int idTeamTournament;
  TeamModel teamModel;
  TournamentModel tournamentModel;
  StatsTableModel statsTableMode;
  TeamStatsModel teamStatsModel;

  factory TeamTournamentModel.fromJson(Map<String, dynamic> json) =>
      TeamTournamentModel(
        idTeamTournament: json["idTeamTournament"],
        teamModel: TeamModel.fromJson(json["team"]),
        teamStatsModel: TeamStatsModel.fromJson(json["team_stats"]),
        statsTableMode: StatsTableModel.fromJson(json["stats_table"]),
        tournamentModel: TournamentModel.fromJson(json["tournament"]),
      );

  Map<String, dynamic> toJson() => {
        "team": teamModel.toJson(),
        "tournament": tournamentModel.toJson(),
        "team_stats": teamStatsModel.toJson(),
        "stats_table": statsTableMode.toJson(),
      };
}
