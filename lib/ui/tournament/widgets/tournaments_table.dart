// ignore_for_file: depend_on_referenced_packages

import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/ui/tournament/widgets/tournament_details.dart';
import 'package:desktop_apk/ui/tournament/widgets/tournaments_table_data_source.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/ui/common/routes.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TournamentsTable extends StatelessWidget {
  const TournamentsTable(
      {Key? key, required this.tournamentsTableDataSource, required this.tournaments})
      : super(key: key);

  final TournamentsTableDataSource tournamentsTableDataSource;
  final Tournaments tournaments;
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
                    Navigator.of(context).push(slide(() => TournamentDetails(
                          tournament: tournaments.tournaments[
                              dataGridCellTapDetails.rowColumnIndex.rowIndex -
                                  1],
                        )));
                  }
                },
                // headerGridLinesVisibility: GridLinesVisibility.none,
                source: tournamentsTableDataSource,
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
                      columnName: 'Fecha de creación',
                      width: constraints.maxWidth * 0.2,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Fecha de creación',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      columnName: 'Equipos permitidos',
                      width: constraints.maxWidth * 0.2,
                      label: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Equipos permitidos',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )),
                  GridColumn(
                      columnName: 'Duración',
                      width: constraints.maxWidth * 0.1,
                      label: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          //alignment: Alignment.centerRight,
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Duración',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              )))),
                  
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
