// ignore_for_file: unrelated_type_equality_checks

import 'package:fluent_ui/fluent_ui.dart';

import 'package:desktop_apk/global/network.dart';
import 'package:desktop_apk/data/model/roster_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PlayersTeamTableDataSource extends DataGridSource {
  PlayersTeamTableDataSource({required Rosters rosters}) {
    _rosters = rosters.playersRoster
        .map<DataGridRow>((roster) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'Posición', value: roster.playerModel.position),
              DataGridCell<String>(
                  columnName: 'Imagen', value: roster.playerModel.image),
              DataGridCell<String>(
                  columnName: 'Nombre',
                  value:
                      "${roster.playerModel.name} ${roster.playerModel.lastName}"),
              DataGridCell<int>(
                  columnName: 'Edad', value: roster.playerModel.age),
              DataGridCell<int>(
                  columnName: 'Peso', value: roster.playerModel.weight),
              DataGridCell<int>(
                  columnName: 'Estatura', value: roster.playerModel.height),
              DataGridCell<String>(
                  columnName: 'CI', value: roster.playerModel.ci),
              DataGridCell<String>(
                  columnName: 'Teléfono', value: roster.playerModel.phone),
              DataGridCell<String>(
                  columnName: 'Profesión',
                  value: roster.playerModel.profession),
              DataGridCell<bool>(
                  columnName: 'Estado', value: roster.playerModel.active),
            ]))
        .toList();
  }

  List<DataGridRow> _rosters = [];

  @override
  List<DataGridRow> get rows => _rosters;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
            alignment: Alignment.center,
            child: e.columnName.compareTo("Imagen") == 0
                ? e.value.toString() == "no image"
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset("assets/images/no_image_player.png"))
                    : Image.network(
                        "${Network.url}/image/${e.value.toString()}")
                : e.columnName.compareTo("Estado") == 0
                    ? Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            e.value.toString() == "true"
                                ? "Activo"
                                : "Inactivo",
                            style: TextStyle(
                                color: e.value.toString() == "true"
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            e.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
      );
    }).toList());
  }
}
