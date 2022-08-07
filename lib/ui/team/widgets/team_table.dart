// ignore_for_file: depend_on_referenced_packages

import 'package:fluent_ui/fluent_ui.dart';

import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/ui/common/routes.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:desktop_apk/data/model/team_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:desktop_apk/ui/team/widgets/team_details.dart';
import 'package:desktop_apk/ui/team/widgets/team_table_data_source.dart';

class TeamsTable extends StatelessWidget {
  const TeamsTable(
      {Key? key, required this.teamsTableDataSource, required this.teams})
      : super(key: key);

  final TeamsTableDataSource teamsTableDataSource;
  final Teams teams;
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
                    Navigator.of(context).push(slide(() => TeamDetails(
                          team: teams.teams[
                              dataGridCellTapDetails.rowColumnIndex.rowIndex -
                                  1],
                        )));
                  }
                },
                // headerGridLinesVisibility: GridLinesVisibility.none,
                source: teamsTableDataSource,
                columns: <GridColumn>[
                  GridColumn(
                    allowSorting: false,
                    width: constraints.maxWidth * 0.1,
                    columnName: 'Imagen',
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
                            ))),
                  ),
                  GridColumn(
                      columnName: 'Nombre',
                      width: constraints.maxWidth * 0.3,
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
                      columnName: 'Capitán',
                      width: constraints.maxWidth * 0.1,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Capitán',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      columnName: 'Manager',
                      width: constraints.maxWidth * 0.1,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Manager',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      columnName: 'Municipio',
                      width: constraints.maxWidth * 0.2,
                      label: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          //alignment: Alignment.centerRight,
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Municipio',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              )))),
                  GridColumn(
                      allowSorting: false,
                      columnName: 'Equipación',
                      width: constraints.maxWidth * 0.1,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Equipación',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      allowSorting: false,
                      columnName: 'Estado',
                      width: constraints.maxWidth * 0.1,
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
