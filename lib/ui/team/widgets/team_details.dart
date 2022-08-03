import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/network/roster_network.dart';
import 'package:desktop_apk/data/model/roster_model.dart';
import 'package:desktop_apk/ui/team/widgets/category_team/category_team.dart';
import 'package:desktop_apk/ui/team/widgets/category_team/category_calendar.dart';
import 'package:desktop_apk/ui/team/widgets/players_team/players_team_table.dart';
import 'package:desktop_apk/ui/team/widgets/category_team/category_info_team.dart';
import 'package:desktop_apk/domain/bloc/category_team_select/category_team_select_bloc.dart';
import 'package:desktop_apk/ui/team/widgets/players_team/players_team_table_data_source.dart';

class TeamDetails extends StatefulWidget {
  const TeamDetails({Key? key, required this.team}) : super(key: key);

  final Team team;

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  @override
  void initState() {
    BlocProvider.of<CategoryTeamSelectBloc>(context)
        .add(const SelectInfoTeam());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryTeamSelectBloc, CategoryTeamSelectState>(
        builder: (context, state) {
      if (state is StateInfoTeam) {
        return CategoryTeam(
          widget: CategoryInfoTeam(team: widget.team),
          team: widget.team,
        );
      } else if (state is StateCalendar) {
        return CategoryTeam(
          widget: TeamCalendar(team: widget.team),
          team: widget.team,
        );
      } else if (state is StatePlayers) {
        return CategoryTeam(
          // widget: PlayersOfTeam(team: widget.team),
          widget: FutureBuilder(
              future: RosterNetwork.instance
                  .getActiveRosterByTeam(widget.team.idTeam),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ProgressRing(),
                      Text("Tabla no disponible, por favor espere...")
                    ],
                  );
                }
                Rosters rosters = snapshot.data;
                if (rosters.playersRoster.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorApp.colorBlackFont,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "No hay jugadores dentro del equipo",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }

                return PlayersTeamTable(
                    playersTeamTableDataSource:
                        PlayersTeamTableDataSource(rosters: rosters),
                    rosters: rosters);
              }),
          team: widget.team,
        );
      } else {
        return CategoryTeam(
          widget: const Text("Logros"),
          team: widget.team,
        );
      }
    });
  }
}
