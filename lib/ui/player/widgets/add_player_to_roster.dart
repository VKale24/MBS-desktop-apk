// ignore_for_file: use_build_context_synchronously

import 'package:desktop_apk/ui/common/user_alert.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/network/roster_network.dart';
import 'package:desktop_apk/domain/entities/player.dart';
import 'package:desktop_apk/domain/bloc/team/team_bloc.dart';
import 'package:desktop_apk/domain/entities/tournament.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/bloc/tournament/tournament_bloc.dart';

class AddPlayerToTeam extends StatefulWidget {
  const AddPlayerToTeam({
    Key? key,
    required this.callback,
    required this.player,
  }) : super(key: key);

  final Player player;
  final Function callback;
  @override
  State<AddPlayerToTeam> createState() => _AddPlayerToTeamState();
}

class _AddPlayerToTeamState extends State<AddPlayerToTeam> {
  bool isEmptyDropDown = false;
  bool isTeamSelected = false;
  bool isTournamentSelected = false;
  Teams teams = Teams();

  Tournaments tournaments = Tournaments();
  late Team selectedTeam;
  late Tournament selectedTournament;

  int value = 0;
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Center(
          child: Text(
        'Añadir a roster',
        style: TextStyle(fontSize: 18),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isEmptyDropDown
              ? Text(
                  "Debe elegir un torneo y un equipo",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              : const SizedBox.shrink(),
          LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: constraints.maxWidth * .4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Equipo"),
                      const SizedBox(height: 10.0),
                      BlocBuilder<TeamBloc, TeamState>(
                          builder: (context, state) {
                        if (state is LoadedTeams) {
                          teams = state.teams;
                          return FutureBuilder(
                            future: createDropDownTeamList(teams),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox(
                                    height: 10, child: ProgressRing());
                              }
                              List<MenuFlyoutItem> listMenuFlyoutItem =
                                  snapshot.data;

                              if (snapshot.data.length == 0) {
                                return const Text("No hay equipos actualmente");
                              }
                              return DropDownButton(
                                title: isTeamSelected
                                    ? Text(selectedTeam.name)
                                    : const Text("Equipo"),
                                items: listMenuFlyoutItem.map((item) {
                                  return item;
                                }).toList(),
                              );
                            },
                          );
                        }
                        return const ProgressRing();
                      })
                    ],
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * .4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Torneo"),
                      const SizedBox(height: 10.0),
                      BlocBuilder<TournamentBloc, TournamentState>(
                          builder: (context, state) {
                        if (state is LoadedTournaments) {
                          tournaments = state.tournaments;
                          return FutureBuilder(
                            future: createDropDownTournamentList(tournaments),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox(
                                    height: 10, child: ProgressRing());
                              }
                              List<MenuFlyoutItem> listMenuFlyoutItem =
                                  snapshot.data;

                              if (snapshot.data.length == 0) {
                                return const Text("No hay torneos actualmente");
                              }
                              return DropDownButton(
                                title: isTournamentSelected
                                    ? Text(selectedTournament.name)
                                    : const Text("Torneo"),
                                items: listMenuFlyoutItem.map((item) {
                                  return item;
                                }).toList(),
                              );
                            },
                          );
                        }
                        return const ProgressRing();
                      })
                    ],
                  ),
                ),
              ],
            );
          })
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.successPrimaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Aceptar",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ),
              onTap: () async {
                if (!isTeamSelected || !isTournamentSelected) {
                  setState(() {
                    isEmptyDropDown = true;
                  });
                } else {
                  try {
                    await RosterNetwork.instance.addPlayerToRoster(
                        widget.player.idPlayer,
                        selectedTeam.idTeam,
                        selectedTournament.idTournament);
                    widget.callback();
                    Navigator.of(context).pop();
                    showSnackbar(
                        context,
                        const Snackbar(
                          extended: true,
                          content: Align(
                              alignment: Alignment.center,
                              child: Text('Jugador añadido correctamente')),
                        ),
                        duration: const Duration(seconds: 3));
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (_) => const MessageAlertDialog(
                            title:
                                "No se pudo agregar el jugador a este equipo"));
                  }
                }
              },
            ),
            const SizedBox(width: 10.0),
            GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 173, 172, 172),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Cancelar",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<List<MenuFlyoutItem>> createDropDownTeamList(Teams teams) async {
    List<MenuFlyoutItem> listMenuFlyoutItems = [];
    for (int i = 0; i < teams.teams.length; i++) {
      Team team = teams.teams[i];
      listMenuFlyoutItems.add(MenuFlyoutItem(
          leading: team.image == "no image"
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    "${Network.url}/image/${CommonValues.noImage}",
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.network("${Network.url}/image/${team.image}", width: 30),
          text: Text(team.name),
          selected: true,
          onPressed: () {
            setState(() => {selectedTeam = team, isTeamSelected = true});
          }));
    }
    return listMenuFlyoutItems;
  }

  Future<List<MenuFlyoutItem>> createDropDownTournamentList(
      Tournaments tournaments) async {
    List<MenuFlyoutItem> listMenuFlyoutItems = [];
    for (int i = 0; i < tournaments.tournaments.length; i++) {
      Tournament tournament = tournaments.tournaments[i];
      listMenuFlyoutItems.add(MenuFlyoutItem(
          leading: tournament.image == "no image"
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    "${Network.url}/image/${CommonValues.noImage}",
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.network("${Network.url}/image/${tournament.image}",
                  width: 30),
          text: Text(tournament.name),
          selected: true,
          onPressed: () {
            setState(() =>
                {selectedTournament = tournament, isTournamentSelected = true});
          }));
    }
    return listMenuFlyoutItems;
  }
}
