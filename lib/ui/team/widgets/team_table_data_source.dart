// ignore_for_file: unrelated_type_equality_checks

import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/data/model/team_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:desktop_apk/global/network.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TeamsTableDataSource extends DataGridSource {
  TeamsTableDataSource({required Teams teams}) {
    _teams = teams.teams
        .map<DataGridRow>((team) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Imagen', value: team.image),
              DataGridCell<String>(columnName: 'Nombre', value: team.name),
              DataGridCell<String>(columnName: 'Capitán', value: team.captain),
              DataGridCell<String>(columnName: 'Manager', value: team.manager),
              DataGridCell<String>(columnName: 'Municipio', value: team.town),
              DataGridCell<String>(
                  columnName: 'Equipación', value: team.equipationColor),
              DataGridCell<bool>(columnName: 'Estado', value: team.active),
            ]))
        .toList();
  }

  List<DataGridRow> _teams = [];

  @override
  List<DataGridRow> get rows => _teams;

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
                        child: Image.asset("assets/images/no_image.jpg"))
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
                    : e.columnName.compareTo("Equipación") == 0
                        ? Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: e.value == "white"
                                    ? Colors.white
                                    : e.value == "black"
                                        ? Colors.black
                                        : ColorApp.getColorFromName(e.value),
                                borderRadius: BorderRadius.circular(5)),
                          )
                        : Container(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e.value.toString(),
                              ),
                            ),
                          )),
      );
    }).toList());
  }
}
