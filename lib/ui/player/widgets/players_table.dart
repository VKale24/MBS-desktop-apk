// ignore_for_file: depend_on_referenced_packages

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/ui/common/routes.dart';
import 'package:desktop_apk/ui/player/widgets/player_details/player_details.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:desktop_apk/data/model/player_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:desktop_apk/ui/player/widgets/player_table_data_source.dart';

class PlayersTable extends StatelessWidget {
  const PlayersTable(
      {Key? key, required this.playersTableDataSource, required this.players})
      : super(key: key);

  final PlayersTableDataSource playersTableDataSource;
  final Players players;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .75,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SfDataGridTheme(
            data: SfDataGridThemeData(headerColor: ColorApp.colorBlack),
            child: SfDataGrid(
                allowSorting: true,
                onCellTap: (DataGridCellTapDetails dataGridCellTapDetails) {
                  if (dataGridCellTapDetails.rowColumnIndex.rowIndex != 0) {
                    Navigator.of(context).push(slide(() => PlayerDetails(
                          player: players.players[
                              dataGridCellTapDetails.rowColumnIndex.rowIndex -
                                  1],
                        )));
                  }
                },
                // headerGridLinesVisibility: GridLinesVisibility.none,
                source: playersTableDataSource,
                columns: <GridColumn>[
                  GridColumn(
                    width: constraints.maxWidth * 0.1,
                    columnName: 'Posición',
                    label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Posición',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                  ),
                  GridColumn(
                    width: 60,
                    columnName: 'Imagen',
                    allowSorting: false,
                    label: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                  GridColumn(
                      columnName: 'Nombre',
                      width: constraints.maxWidth * 0.2,
                      label: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nombre',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              )))),
                  GridColumn(
                      columnName: 'Edad',
                      width: constraints.maxWidth * 0.1,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Edad',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      columnName: 'Peso',
                      width: 60,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Peso',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      columnName: 'Estatura',
                      width: 80,
                      label: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          //alignment: Alignment.centerRight,
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Estatura',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              )))),
                  GridColumn(
                      columnName: 'CI',
                      width: constraints.maxWidth * 0.11,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'CI',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      columnName: 'Teléfono',
                      width: constraints.maxWidth * 0.1,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Teléfono',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      columnName: 'Profesión',
                      width: constraints.maxWidth * 0.1,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Profesión',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      columnName: 'Estado',
                      width: constraints.maxWidth * 0.1,
                      allowSorting: false,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Estado',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                ]),
          );
        },
      ),
    );
  }
}
