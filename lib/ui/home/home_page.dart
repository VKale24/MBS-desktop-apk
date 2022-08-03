import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/domain/bloc/player/player_bloc.dart';
import 'package:desktop_apk/domain/bloc/team/team_bloc.dart';
import 'package:desktop_apk/domain/bloc/tournament/tournament_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //final Players players = BlocProvider.of<PlayerBloc>(context).state.players;
    return Container(
        //width: size.width * .3,
        color: ColorApp.colorBlack,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(FluentIcons.settings,
                        color: Color.fromARGB(255, 253, 252, 252)),
                    const SizedBox(width: 5),
                    const Text(
                      "General",
                      style: TextStyle(
                          color: Color.fromARGB(255, 253, 252, 252),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: size.width * .137,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 91, 16, 104),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Total de jugadores",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 253, 252, 252),
                                    fontWeight: FontWeight.bold),
                              )),
                          BlocBuilder<PlayerBloc, PlayerState>(
                            builder: (context, state) {
                              return Text(
                                state is LoadedPlayers
                                    ? state.players.players.length.toString()
                                    : "-",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 253, 252, 252),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              );
                            },
                          ),
                          const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * .01),
                  Container(
                    height: 100,
                    width: size.width * .137,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 12, 11, 104),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Total de equipos",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 253, 252, 252),
                                    fontWeight: FontWeight.bold),
                              )),
                          BlocBuilder<TeamBloc, TeamState>(
                            builder: (context, state) {
                              return Text(
                                state is LoadedTeams
                                    ? state.teams.teams.length.toString()
                                    : "-",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 253, 252, 252),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              );
                            },
                          ),
                          const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: size.width * .137,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 15, 190, 202),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Total de Torneos",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold),
                              )),
                          BlocBuilder<TournamentBloc, TournamentState>(
                            builder: (context, state) {
                              return Text(
                                state is LoadedTournaments
                                    ? state.tournaments.tournaments.length
                                        .toString()
                                    : "-",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 253, 252, 252),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              );
                            },
                          ),
                          const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * .01),
                ],
              )
            ],
          ),
        ));
  }
}
