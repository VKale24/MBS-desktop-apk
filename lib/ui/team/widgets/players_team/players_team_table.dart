// ignore_for_file: depend_on_referenced_packages

import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/data/model/roster_model.dart';
import 'package:desktop_apk/ui/common/routes.dart';
import 'package:desktop_apk/ui/player/widgets/player_details/player_details.dart';
import 'package:desktop_apk/ui/team/widgets/players_team/players_team_table_data_source.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PlayersTeamTable extends StatelessWidget {
  const PlayersTeamTable(
      {Key? key,
      required this.playersTeamTableDataSource,
      required this.rosters})
      : super(key: key);

  final PlayersTeamTableDataSource playersTeamTableDataSource;
  final Rosters rosters;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
      child: Container(
        color: ColorApp.colorBlackFont,
        height: size.height * .75,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SfDataGridTheme(
              data: SfDataGridThemeData(headerColor: ColorApp.colorBlack),
              child: SfDataGrid(
                  allowSorting: true,
                  onCellTap: (DataGridCellTapDetails dataGridCellTapDetails) {
                    Navigator.of(context).push(slide(() => PlayerDetails(
                          player: rosters
                              .playersRoster[dataGridCellTapDetails
                                      .rowColumnIndex.rowIndex -
                                  1]
                              .playerModel,
                        )));
                  },
                  // headerGridLinesVisibility: GridLinesVisibility.none,
                  source: playersTeamTableDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                      width: constraints.maxWidth * 0.1,
                      columnName: 'Posici??n',
                      label: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Posici??n',
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
                        width: constraints.maxWidth * .05,
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
                        width: constraints.maxWidth * 0.1,
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
                        width: constraints.maxWidth * 0.1,
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
                        width: constraints.maxWidth * 0.15,
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
                        columnName: 'Tel??fono',
                        width: constraints.maxWidth * 0.1,
                        label: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tel??fono',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )),
                    GridColumn(
                        columnName: 'Profesi??n',
                        width: constraints.maxWidth * 0.1,
                        label: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Profesi??n',
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
      ),
    );
  }
}
