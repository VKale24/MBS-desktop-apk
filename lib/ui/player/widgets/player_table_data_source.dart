// ignore_for_file: unrelated_type_equality_checks

import 'package:fluent_ui/fluent_ui.dart';
import 'package:desktop_apk/common/network.dart';

import 'package:desktop_apk/data/model/player_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PlayersTableDataSource extends DataGridSource {
  PlayersTableDataSource({required Players players}) {
    _players = players.players
        .map<DataGridRow>((player) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'Posición', value: player.position),
              DataGridCell<String>(columnName: 'Imagen', value: player.image),
              DataGridCell<String>(
                  columnName: 'Nombre',
                  value: "${player.name} ${player.lastName}"),
              DataGridCell<int>(columnName: 'Edad', value: player.age),
              DataGridCell<int>(columnName: 'Peso', value: player.weight),
              DataGridCell<int>(columnName: 'Estatura', value: player.height),
              DataGridCell<String>(columnName: 'CI', value: player.ci),
              DataGridCell<String>(columnName: 'Teléfono', value: player.phone),
              DataGridCell<String>(
                  columnName: 'Profesión', value: player.profession),
              DataGridCell<bool>(columnName: 'Estado', value: player.active),
            ]))
        .toList();
  }

  List<DataGridRow> _players = [];

  @override
  List<DataGridRow> get rows => _players;

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
                    ? Image.asset("assets/images/no_image_player.png")
                    : Image.network(
                        "${Network.url}/image/${e.value.toString()}")
                : e.columnName.compareTo("Estado") == 0 ? Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e.value.toString() == "true" ? "Activo" : "Inactivo",
                        style: TextStyle(color:  e.value.toString() == "true" ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ):
                 Container(
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
