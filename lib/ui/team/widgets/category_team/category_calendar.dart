import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/data/model/goal_model.dart';
import 'package:desktop_apk/domain/entities/match_game.dart';
import 'package:desktop_apk/network/match_stats_network.dart';
import 'package:desktop_apk/data/model/match_stats_model.dart';
import 'package:desktop_apk/domain/bloc/team_match/team_match_bloc.dart';
import 'package:desktop_apk/domain/bloc/match_stats/match_stats_bloc.dart';

class TeamCalendar extends StatefulWidget {
  const TeamCalendar({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;
  @override
  State<TeamCalendar> createState() => _TeamCalendarState();
}

List<MatchGame> listMatchGame = [];
late MatchGame matchGameSelected;
bool isGameSelected = false;

class _TeamCalendarState extends State<TeamCalendar> {
  int selectedIndex = -1;

  @override
  void initState() {
//**INICIALIZAR EL RESUMEN DEL PARTIDO SELECCIONADO (REFRESCAR EL BLOC) */
    BlocProvider.of<MatchStatsBloc>(context).add(const InitMatchStats());

//**CARGAR TODOS LOS PARTIDOS DEL EQUIPO */
    BlocProvider.of<TeamMatchBloc>(context)
        .add(GetMatchsOfTeam(team: widget.team));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TeamMatchBloc, TeamMatchState>(
      builder: (context, state) {
        if (state is LoadedMatchsOfTeam) {
          //Inicializando el matchgame con el primero de la lista
          listMatchGame = state.listMatchGame;
          return Expanded(
              child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                width: size.width * .67,
                decoration: BoxDecoration(
                    // color: const Color.fromARGB(255, 17, 4, 15),
                    color: ColorApp.colorBlack,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 7,
                          color: Color.fromARGB(255, 32, 18, 30),
                          spreadRadius: 3)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Row(
                                children: const [
                                  Text(
                                    "Fecha",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: const [
                                  Text(
                                    "Hora",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Rival",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: const [
                                  Text(
                                    "Resultado",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Row(
                                children: const [
                                  Text(
                                    "Competición",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                          child: ListView.builder(
                              itemCount: listMatchGame.length,
                              itemBuilder: ((context, index) {
                                MatchGame matchGame = listMatchGame[index];
                                return index <= listMatchGame.length
                                    ? MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: selectedIndex == index
                                                    ? ColorApp.kPrimaryColor
                                                    : index % 2 == 0
                                                        ? ColorApp
                                                            .colorBlackFont
                                                        : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          matchGame.match.date,
                                                          style: TextStyle(
                                                              color:
                                                                  selectedIndex ==
                                                                          index
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "-",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  selectedIndex ==
                                                                          index
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            matchGame
                                                                .team2.name,
                                                            style: TextStyle(
                                                                color: selectedIndex ==
                                                                        index
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white)),
                                                      ],
                                                    ),
                                                  ),
                                                  listMatchGame[index].state ==
                                                          "notPlayed"
                                                      ? Flexible(
                                                          flex: 1,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "VS",
                                                                style: TextStyle(
                                                                    color: selectedIndex ==
                                                                            index
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .white),
                                                              ),
                                                            ],
                                                          ))
                                                      : FutureBuilder(
                                                          future: MatchStatsNetwork
                                                              .instance
                                                              .getStatsByMatch(
                                                                  matchGame
                                                                      .match
                                                                      .idMatch),
                                                          builder: (context,
                                                              AsyncSnapshot
                                                                  snapshot) {
                                                            if (snapshot.data ==
                                                                204) {
                                                              return Flexible(
                                                                  flex: 1,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "-",
                                                                        style: TextStyle(
                                                                            color: selectedIndex == index
                                                                                ? Colors.black
                                                                                : Colors.white),
                                                                      ),
                                                                    ],
                                                                  ));
                                                            } else if (!snapshot
                                                                .hasData) {
                                                              return const Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      ProgressBar());
                                                            } else {
                                                              ListMatchStats
                                                                  listMatchStats =
                                                                  snapshot.data;
                                                              return Flexible(
                                                                flex: 1,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      widget.team.idTeam == listMatchStats.matchsStats[0].teamModel.idTeam
                                                                          ? listMatchStats
                                                                              .matchsStats[
                                                                                  0]
                                                                              .goal
                                                                              .toString()
                                                                          : listMatchStats
                                                                              .matchsStats[1]
                                                                              .goal
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          color: selectedIndex == index
                                                                              ? Colors.black
                                                                              : Colors.white),
                                                                    ),
                                                                    Text(
                                                                      "-",
                                                                      style: TextStyle(
                                                                          color: selectedIndex == index
                                                                              ? Colors.black
                                                                              : Colors.white),
                                                                    ),
                                                                    Text(
                                                                      widget.team.idTeam == listMatchStats.matchsStats[0].teamModel.idTeam
                                                                          ? listMatchStats
                                                                              .matchsStats[
                                                                                  1]
                                                                              .goal
                                                                              .toString()
                                                                          : listMatchStats
                                                                              .matchsStats[0]
                                                                              .goal
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          color: selectedIndex == index
                                                                              ? Colors.black
                                                                              : Colors.white),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                          }),
                                                  Flexible(
                                                    flex: 3,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5.0),
                                                          child: Text(
                                                            // listMatchGame[0]
                                                            ////    .match
                                                            //   .tournamentModel
                                                            //    .name,
                                                            matchGame
                                                                .match
                                                                .tournamentModel
                                                                .name,
                                                            style: TextStyle(
                                                                color: selectedIndex ==
                                                                        index
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            setState(() {
                                              //Desseleccionar
                                              if (selectedIndex == index) {
                                                selectedIndex = -1;
                                                isGameSelected = false;
                                              }
                                              //Seleccionar
                                              else {
                                                isGameSelected = true;
                                                selectedIndex = index;
                                                matchGameSelected = matchGame;
                                              }
                                            });
                                            if (selectedIndex != -1) {
                                              BlocProvider.of<MatchStatsBloc>(
                                                      context)
                                                  .add(GetStatsByMatch(
                                                      matchModel:
                                                          matchGameSelected
                                                              .match));
                                            }
                                          },
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              })))
                    ],
                  ),
                ),
              ),
              isGameSelected
                  ? highligths(size, matchGameSelected)
                  : highligthsEmpty(size)
            ],
          ));
        } else {
          return const ProgressRing();
        }
      },
    );
  }

  Widget highligths(Size size, MatchGame matchGame) {
    return BlocBuilder<MatchStatsBloc, MatchStatsState>(
      builder: (context, state) {
        if (state is LoadedMatchStatsByTeam) {
          ListMatchStats listMatchStats = state.listMatchStats;
          return Container(
            margin:
                const EdgeInsets.only(left: 7, right: 20, top: 20, bottom: 20),
            width: size.width * .29,
            decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 17, 4, 15),
                color: ColorApp.colorBlack,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 7,
                      color: Color.fromARGB(255, 32, 18, 30),
                      spreadRadius: 3)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${matchGame.team2.name.toUpperCase()} (${matchGame.match.date.toUpperCase()})",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      )),
                  const SizedBox(height: 10.0),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 100,
                              child: matchGame.team1.image != "no image"
                                  ? Image.network(
                                      "${Network.url}/image/${matchGame.team1.image}")
                                  : Container(
                                      margin: const EdgeInsets.only(right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          "${Network.url}/image/${CommonValues.noImage}",
                                          height: 100,
                                          // width: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                          Text(
                            widget.team.idTeam ==
                                    listMatchStats
                                        .matchsStats[0].teamModel.idTeam
                                ? listMatchStats.matchsStats[0].goal.toString()
                                : listMatchStats.matchsStats[1].goal.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                          const Text(
                            "-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                          Text(
                            widget.team.idTeam ==
                                    listMatchStats
                                        .matchsStats[0].teamModel.idTeam
                                ? listMatchStats.matchsStats[1].goal.toString()
                                : listMatchStats.matchsStats[0].goal.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                          SizedBox(
                              height: 100,
                              child: matchGame.team2.image != "no image"
                                  ? Image.network(
                                      "${Network.url}/image/${matchGame.team2.image}")
                                  : Container(
                                      margin: const EdgeInsets.only(left: 8.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${Network.url}/image/${CommonValues.noImage}",
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 15.0),
                          child: const Divider()),
                      //**GOLEADORES */
                      PlayersScores(
                          listMatchStats: listMatchStats,
                          teamSelected: widget.team)
                    ],
                  )
                ],
              ),
            ),
          );
        }
        //**SI AUN EL PARTIDO NO SE HA REALIZADO */
        else if (state is EmptyMatchStatsByTeam) {
          return Container(
            margin:
                const EdgeInsets.only(left: 7, right: 20, top: 20, bottom: 20),
            width: size.width * .29,
            decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 17, 4, 15),
                color: ColorApp.colorBlack,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 7,
                      color: Color.fromARGB(255, 32, 18, 30),
                      spreadRadius: 3)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${matchGame.team2.name.toUpperCase()} (${matchGame.match.date.toUpperCase()})",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    )),
                SizedBox(
                    height: 100,
                    child: matchGame.team2.image != "no image"
                        ? Image.network(
                            "${Network.url}/image/${matchGame.team2.image}")
                        : Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                "${Network.url}/image/${CommonValues.noImage}",
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                Text(
                  matchGame.team2.name.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    color: Colors.white.withOpacity(.4),
                    child: const Divider()),
                SizedBox(
                  height: 30,
                  // width: 200,
                  child: matchGame.match.tournamentModel.image == "no image"
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "${Network.url}/image/${CommonValues.noImage}",
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.network(
                          "${Network.url}/image/${matchGame.match.tournamentModel.image}"),
                ),
                const SizedBox(height: 5.0),
                Text(
                  matchGame.match.tournamentModel.name.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold),
                )
              ]),
            ),
          );
        } else {
          return highligthsEmpty(size);
        }
      },
    );
  }
}

class PlayersScores extends StatelessWidget {
  const PlayersScores({
    Key? key,
    required this.listMatchStats,
    required this.teamSelected,
  }) : super(key: key);
  final ListMatchStats listMatchStats;
  final Team teamSelected;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder(
                future: teamSelected.idTeam ==
                        listMatchStats.matchsStats[0].teamModel.idTeam
                    ? MatchStatsNetwork.instance.getGoalsByMatchStats(
                        listMatchStats.matchsStats[0].idMatchStats)
                    : MatchStatsNetwork.instance.getGoalsByMatchStats(
                        listMatchStats.matchsStats[1].idMatchStats),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const ProgressBar();
                  } else if (snapshot.data.listGoals.length == 0) {
                    return const SizedBox.shrink();
                  } else {
                    return SizedBox(
                      height: 100,
                      width: size.width * .12,
                      child: ListView.builder(
                          itemCount: snapshot.data.listGoals.length,
                          itemBuilder: (_, index) {
                            GoalModel goal = snapshot.data.listGoals[index];
                            return Row(
                              children: [
                                Text(
                                  goal.playerModel.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  " (${goal.minute.toString()})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            );
                          }),
                    );
                  }
                }),
            FutureBuilder(
                future: teamSelected.idTeam ==
                        listMatchStats.matchsStats[0].teamModel.idTeam
                    ? MatchStatsNetwork.instance.getGoalsByMatchStats(
                        listMatchStats.matchsStats[1].idMatchStats)
                    : MatchStatsNetwork.instance.getGoalsByMatchStats(
                        listMatchStats.matchsStats[0].idMatchStats),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const ProgressBar();
                  } else if (snapshot.data.listGoals.length == 0) {
                    return const SizedBox.shrink();
                  } else {
                    return SizedBox(
                      height: 100,
                      width: size.width * .12,
                      child: ListView.builder(
                          itemCount: snapshot.data.listGoals.length,
                          itemBuilder: (_, index) {
                            GoalModel goal = snapshot.data.listGoals[index];
                            return Row(
                              children: [
                                Text(
                                  goal.playerModel.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  " (${goal.minute.toString()})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

Widget highligthsEmpty(Size size) {
  return Container(
    margin: const EdgeInsets.only(left: 7, right: 20, top: 20, bottom: 20),
    width: size.width * .29,
    decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 17, 4, 15),
        color: ColorApp.colorBlack,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              blurRadius: 7,
              color: Color.fromARGB(255, 32, 18, 30),
              spreadRadius: 3)
        ]),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: const [
          Text("Resumen", style: TextStyle(fontWeight: FontWeight.w700)),
          Spacer(),
          Center(
            child: Text("No hay ningún partido seleccionado",
                style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          Spacer()
        ],
      ),
    ),
  );
}
