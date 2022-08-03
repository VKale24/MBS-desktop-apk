// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/entities/match.dart';


MatchModel matchModelFromJson(String str) =>
    MatchModel.fromJson(json.decode(str));

String matchModelToJson(MatchModel data) => json.encode(data.toJson());

class Matchs {
  List<MatchModel> matchs = [];

  Matchs();

  Matchs.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final match = MatchModel.fromJson(item);
      matchs.add(match);
    }
  }
}

class MatchModel extends MatchEntity {
  MatchModel(
      {required this.idMatch,
      required this.referee,
      required this.date,
      required this.round,
      required this.tournamentModel,
      })
      : super(idMatch: idMatch, referee: referee, date: date, round: round, tournamentModel: tournamentModel);

  int idMatch;
  String referee;
  String date;
  int round;
  TournamentModel tournamentModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
        idMatch: json["idMatch"],
        referee: json["referee"],
        date: json["date"],
        round: json["round"],
        tournamentModel: TournamentModel.fromJson(json["tournament"]),
      );

  Map<String, dynamic> toJson() => {
        "idMatch": idMatch,
        "referee": referee,
        "date": date,
        "tournament": tournamentModel.toJson(),
      };
}
