// ignore_for_file: depend_on_referenced_packages

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/bloc/team/team_bloc.dart';
import 'package:desktop_apk/ui/common/routes.dart';
import 'package:desktop_apk/ui/team/widgets/team_details.dart';
import 'package:desktop_apk/ui/tournament/widgets/match_tournament.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:desktop_apk/data/model/team_tournament_model.dart';
import 'package:desktop_apk/domain/bloc/team_tournament/teamtournament_bloc.dart';
import 'package:desktop_apk/ui/tournament/widgets/category_tournament/table_data_source.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CategoryInfoTournament extends StatefulWidget {
  const CategoryInfoTournament({Key? key, required this.tournament})
      : super(key: key);

  final TournamentModel tournament;

  @override
  State<CategoryInfoTournament> createState() => _CategoryInfoTournamentState();
}

class _CategoryInfoTournamentState extends State<CategoryInfoTournament> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<TeamTournamentBloc, TeamTournamentsState>(
      builder: (context, state) {
        bool emptyDataSource = true;
        if (state is LoadedTableOfTournament) {
          ListTeamTournaments listTeamTournaments = state.teamTournaments;

          TableOfTournamentDataSource tableOfTournamentDataSource =
              TableOfTournamentDataSource(teamTournaments: listTeamTournaments);

          emptyDataSource = !emptyDataSource;

          return Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ColorApp.colorBlackFont,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      lastChampion(),
                      SizedBox(
                        width: size.width * .3,
                        child: tableTournament(size, listTeamTournaments,
                            tableOfTournamentDataSource, emptyDataSource),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5.0),
                MatchTournament(
                    size: size, tournamentSelected: widget.tournament)
              ],
            ),
          ));
        } else {
          return const ProgressRing();
        }
      },
    );
  }

  Widget lastChampion() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
            // width: 200,
            child: widget.tournament.image == "no image"
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      "${Network.url}/image/${CommonValues.noImage}",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.network(
                    "${Network.url}/image/${widget.tournament.image}"),
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "CAMPEÓN DEFENSOR",
                style: TextStyle(
                    color: Color.fromARGB(255, 156, 152, 152), fontSize: 11),
              ),
              Text("FS Castilla", style: TextStyle(fontSize: 15))
            ],
          ),
        ],
      ),
    );
  }

  Widget tableTournament(
      Size size,
      ListTeamTournaments listTeamTournaments,
      TableOfTournamentDataSource tableOfTournamentDataSource,
      bool emptyTableDataSource) {
    return emptyTableDataSource
        ? const ProgressRing()
        : SizedBox(
            height: size.height * .75,
            child: SfDataGridTheme(
              data: SfDataGridThemeData(headerColor: ColorApp.kPrimaryColor),
              child: SfDataGrid(
                  onCellTap: (DataGridCellTapDetails dataGridCellTapDetails) {
                    BlocProvider.of<TeamBloc>(context).add(SelectTeam(
                        team: listTeamTournaments
                            .listTeamTournament[
                                dataGridCellTapDetails.rowColumnIndex.rowIndex -
                                    1]
                            .teamModel));
                    Navigator.of(context).push(slide(() => TeamDetails(
                          team: listTeamTournaments
                              .listTeamTournament[dataGridCellTapDetails
                                      .rowColumnIndex.rowIndex -
                                  1]
                              .teamModel,
                        )));
                  },
                  // headerGridLinesVisibility: GridLinesVisibility.none,
                  source: tableOfTournamentDataSource,
                  frozenColumnsCount: 3,
                  columns: <GridColumn>[
                    GridColumn(
                      width: 60,
                      columnName: 'POS',
                      label: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'POS',
                                style: TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ))),
                    ),
                    GridColumn(
                      width: 120,
                      columnName: 'EQUIPO',
                      label: Container(
                          alignment: Alignment.centerRight,
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'EQUIPO',
                                style: TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ))),
                    ),
                    GridColumn(
                        columnName: 'PTS',
                        width: 40,
                        label: Container(
                            //padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerRight,
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'PTS',
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )))),
                    GridColumn(
                        columnName: 'PJ',
                        width: 40,
                        label: Container(
                            //padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerRight,
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'PJ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )))),
                    GridColumn(
                        columnName: 'PG',
                        width: 40,
                        label: Container(
                            // padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerRight,
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'PG',
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )))),
                    GridColumn(
                        columnName: 'PE',
                        width: 40,
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            //alignment: Alignment.centerRight,
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'PE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )))),
                    GridColumn(
                        columnName: 'PP',
                        width: 40,
                        label: Container(
                            //  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerRight,
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'PP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )))),
                    GridColumn(
                        columnName: 'GF',
                        width: 40,
                        label: Container(
                            //  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerRight,
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'GF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )))),
                    GridColumn(
                        columnName: 'GC',
                        width: 40,
                        label: Container(
                            //  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerRight,
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'GC',
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )))),
                    GridColumn(
                        columnName: 'DG',
                        width: 40,
                        label: Container(
                            //  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerRight,
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'DG',
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )))),
                  ]),
            ),
          );
  }
}
