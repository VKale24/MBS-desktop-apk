// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:desktop_apk/domain/entities/stats_table.dart';

StatsTableModel statsTableModelFromJson(String str) =>
    StatsTableModel.fromJson(json.decode(str));

String statsTableModelToJson(StatsTableModel data) =>
    json.encode(data.toJson());

class ListStatsTable {
  List<StatsTableModel> listStatsTable = [];

  ListStatsTable();

  ListStatsTable.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      final statsTable = StatsTableModel.fromJson(item);
      listStatsTable.add(statsTable);
    }
  }
}

class StatsTableModel extends StatsTable {
  StatsTableModel({
    required this.idStatsTable,
    required this.position,
    required this.pts,
    required this.pj,
    required this.pg,
    required this.pe,
    required this.pp,
    required this.gf,
    required this.gc,
    required this.dg,
  }) : super(
          idStatsTable: idStatsTable,
          position: position,
          pts: pts,
          pj: pj,
          pg: pg,
          pe: pe,
          pp: pp,
          gf: gf,
          gc: gc,
          dg: dg,
        );

  int idStatsTable;
  int position;
  int pts;
  int pj;
  int pg;
  int pe;
  int pp;
  int gf;
  int gc;
  int dg;

  factory StatsTableModel.fromJson(Map<String, dynamic> json) =>
      StatsTableModel(
        idStatsTable: json["idStatsTable"],
        position: json["position"],
        pts: json["pts"],
        pj: json["pj"],
        pg: json["pg"],
        pe: json["pe"],
        pp: json["pp"],
        gf: json["gf"],
        gc: json["gc"],
        dg: json["dg"],
      );

  Map<String, dynamic> toJson() => {
        "idStatsTable": idStatsTable,
        "position": position,
        "pts": pts,
        "pj": pj,
        "pg": pg,
        "pe": pe,
        "pp": pp,
        "gf": gf,
        "gc": gc,
        "dg": dg,
      };
}
