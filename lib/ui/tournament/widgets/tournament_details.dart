import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/data/model/team_tournament_model.dart';
import 'package:desktop_apk/ui/tournament/widgets/teams_tournament_table.dart';
import 'package:desktop_apk/ui/tournament/widgets/teams_tournament_table_data_source.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/bloc/team_tournament/teamtournament_bloc.dart';
import 'package:desktop_apk/ui/tournament/widgets/category_tournament/category_tournament.dart';
import 'package:desktop_apk/ui/tournament/widgets/category_tournament/category_info_tournament.dart';
import 'package:desktop_apk/domain/bloc/category_tournament_select/category_tournament_select_bloc.dart';

import '../../../domain/repository/team_tournament_repository.dart';
import '../../../global/service_locator.dart';

class TournamentDetails extends StatefulWidget {
  const TournamentDetails({Key? key, required this.tournament})
      : super(key: key);

  final TournamentModel tournament;
  @override
  State<TournamentDetails> createState() => _TournamentDetailsState();
}

class _TournamentDetailsState extends State<TournamentDetails> {
  @override
  void initState() {
    BlocProvider.of<CategoryTournamentSelectBloc>(context)
        .add(const SelectInfoTournament());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryTournamentSelectBloc,
        CategoryTournamentSelectState>(builder: (context, state) {
      if (state is StateInfoTournament) {
        BlocProvider.of<TeamTournamentBloc>(context)
            .add(GetTableOfTournament(tournament: widget.tournament));
        return CategoryTournament(
          tournament: widget.tournament,
          widget: CategoryInfoTournament(tournament: widget.tournament),
        );
      } else if (state is StateTeamTournament) {
        return CategoryTournament(
          tournament: widget.tournament,
          widget: FutureBuilder(
              future: locator<TeamTournamentRepository>()
                  .getTeamsByTournament(widget.tournament.idTournament),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text("Tabla no disponible, espere por favor..."),
                      ProgressRing(),
                    ],
                  );
                }
                ListTeamTournaments listTeamTournaments = snapshot.data;
                if (listTeamTournaments.listTeamTournament.isEmpty) {
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
                          "Actualmente no hay ningún equipo participante",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }
                return TeamsOfTournamentTable(
                  teamsTableDataSource: TeamsTournamentTableDataSource(
                      listTeamTournaments: listTeamTournaments),
                  listTeamTournaments: listTeamTournaments,
                );
              }),
        );
      } else if (state is StateCalendarTournament) {
        return CategoryTournament(
          tournament: widget.tournament,
          widget: const Text("Calendario"),
        );
      } else {
        return CategoryTournament(
          tournament: widget.tournament,
          widget: const Text("Estadisticas"),
        );
      }
    });
  }
}
