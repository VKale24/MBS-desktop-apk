import 'package:desktop_apk/data/model/team_tournament_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TableOfTournamentDataSource extends DataGridSource {
  TableOfTournamentDataSource({required ListTeamTournaments teamTournaments}) {
    _listTeamTournaments = teamTournaments.listTeamTournament
        .map<DataGridRow>((teamTournament) => DataGridRow(
          cells: [
              DataGridCell<String>(
                  columnName: 'POS',
                  value: teamTournament.statsTableModel.position.toString()),
              DataGridCell<String>(
                  columnName: 'EQUIPO', value: teamTournament.teamModel.name),
              DataGridCell<int>(
                  columnName: 'PTS', value: teamTournament.statsTableModel.pts),
              DataGridCell<int>(
                  columnName: 'PJ', value: teamTournament.statsTableModel.pj),
              DataGridCell<int>(
                  columnName: 'PG', value: teamTournament.statsTableModel.pg),
              DataGridCell<int>(
                  columnName: 'PE', value: teamTournament.statsTableModel.pe),
              DataGridCell<int>(
                  columnName: 'PP', value: teamTournament.statsTableModel.pp),
              DataGridCell<int>(
                  columnName: 'GF', value: teamTournament.statsTableModel.gf),
              DataGridCell<int>(
                  columnName: 'PP', value: teamTournament.statsTableModel.pp),
              DataGridCell<int>(
                  columnName: 'PP', value: teamTournament.statsTableModel.pp),
            ]))
        .toList();
  }

  List<DataGridRow> _listTeamTournaments = [];

  @override
  List<DataGridRow> get rows => _listTeamTournaments;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
            alignment: Alignment.center,
            child:
                e.value.toString().length == 1 || e.value.toString().length == 2
                    ? Text(
                        e.value.toString(),
                        style: const TextStyle(color: Colors.white),
                      )
                    : e.value.toString().contains("image")
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1.0),
                            child: Image.asset(e.value.toString()),
                          )
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e.value.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
      );
    }).toList());
  }
}
