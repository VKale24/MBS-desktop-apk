import 'package:desktop_apk/data/model/roster_model.dart';
import 'package:desktop_apk/network/roster_network.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/ui/common/routes.dart';
import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/domain/bloc/player/player_bloc.dart';
import 'package:desktop_apk/ui/player/widgets/player_details/player_details.dart';

class PlayersOfTeam extends StatefulWidget {
  const PlayersOfTeam({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;
  @override
  State<PlayersOfTeam> createState() => _PlayersOfTeamState();
}

class _PlayersOfTeamState extends State<PlayersOfTeam> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: size.height * .8,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorApp.colorBlack,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * .02,
                                  child: const Text(
                                    "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .082,
                                  child: const Text(
                                    "Posición",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30.0,
                                ),
                                SizedBox(
                                  width: size.width * .194,
                                  child: const Text(
                                    "Nombre",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .08,
                                  child: const Text(
                                    "Torneo",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .04,
                                  child: const Text(
                                    "Edad",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .04,
                                  child: const Text(
                                    "Peso",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .064,
                                  child: const Text(
                                    "Estatura",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * .08,
                                  child: const Text(
                                    "CI",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  width: size.width * .08,
                                  child: const Text(
                                    "Telefono",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  width: size.width * .06,
                                  child: const Text(
                                    "Estado",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FutureBuilder(
                            future: RosterNetwork.instance
                                .getActiveRosterByTeam(widget.team.idTeam),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const Expanded(
                                    child: Center(child: ProgressBar()));
                              } else if (snapshot.data.playersRoster.length ==
                                  0) {
                                return const Expanded(
                                  child: Center(
                                      child:
                                          Text("No hay jugadores actualmente")),
                                );
                              } else {
                                return Expanded(
                                  child: ListView.builder(
                                      itemCount:
                                          snapshot.data.playersRoster.length,
                                      itemBuilder: (_, index) {
                                        RosterModel roster =
                                            snapshot.data.playersRoster[index];
                                        return GestureDetector(
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Container(
                                              color: index % 2 == 0
                                                  ? ColorApp.colorBlackFont
                                                  : Colors.transparent,
                                              height: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      child: MouseRegion(
                                                        cursor:
                                                            SystemMouseCursors
                                                                .click,
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  size.width *
                                                                      .01),
                                                          width: 20,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                              color: roster
                                                                      .playerModel
                                                                      .active
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            66,
                                                                            14,
                                                                            13,
                                                                            13),
                                                                    blurRadius:
                                                                        5,
                                                                    spreadRadius:
                                                                        5,
                                                                    blurStyle:
                                                                        BlurStyle
                                                                            .normal)
                                                              ]),
                                                          child: Center(
                                                            child: Text(
                                                              roster.playerModel
                                                                      .active
                                                                  ? "X"
                                                                  : "+",
                                                              style: TextStyle(
                                                                color: roster
                                                                        .playerModel
                                                                        .active
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return _showMyDialog(
                                                                context,
                                                                index,
                                                                roster);
                                                          },
                                                        );
                                                        /*await _showMyDialog(
                                              context, index, widget.playersProvider);*/

                                                        setState(() {});
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: size.width * .075,
                                                      child: Text(
                                                        roster.playerModel
                                                            .position,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                      width: 20,
                                                      child: roster.playerModel
                                                                  .image ==
                                                              "no image"
                                                          ? Image.network(
                                                              "${Network.url}/image/${CommonValues.noImagePlayer}")
                                                          : Image.network(
                                                              "${Network.url}/image/${roster.playerModel.image}"),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    SizedBox(
                                                      width: size.width * .2,
                                                      child: Text(
                                                        "${roster.playerModel.name} ${roster.playerModel.lastName}",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * .08,
                                                      child: Text(
                                                        roster.tournamentModel
                                                            .name,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * .04,
                                                      child: Text(
                                                        roster.playerModel.age
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * .04,
                                                      child: Text(
                                                        roster
                                                            .playerModel.weight
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * .06,
                                                      child: Text(
                                                        roster
                                                            .playerModel.height
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * .08,
                                                      child: Text(
                                                        roster.playerModel.ci
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 30),
                                                      width: size.width * .08,
                                                      child: Text(
                                                        roster.playerModel.phone
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 30),
                                                      width: size.width * .06,
                                                      child: Text(
                                                        roster.playerActive
                                                            ? "ACTIVO"
                                                            : "INACTIVO",
                                                        style: TextStyle(
                                                            color: roster
                                                                    .playerActive
                                                                ? const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    64,
                                                                    179,
                                                                    30)
                                                                : const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    236,
                                                                    6,
                                                                    6),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            /*BlocProvider.of<PlayerBloc>(context)
                                                .add(SelectPlayer(
                                                    roster.playerModel));*/
                                            Navigator.of(context).push(slide(
                                                () => PlayerDetails(player: roster.playerModel,)));
                                          },
                                        );
                                      }),
                                );
                              }
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _showMyDialog(
    context,
    index,
    RosterModel roster,
  ) {
    return ContentDialog(
      // title: const Text('AlertDialog Title'),
      content: roster.playerActive
          ? const Text('¿Estas seguro eliminar a este jugador del equipo?',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
          : const Text('¿Estas seguro de activar a este jugador?',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),

      actions: <Widget>[
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
                          color: Colors.black, fontWeight: FontWeight.w800)),
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                decoration: BoxDecoration(
                    color: roster.playerActive
                        ? const Color.fromARGB(255, 207, 27, 14)
                        : const Color.fromARGB(255, 4, 102, 9),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(roster.playerActive ? "Eliminar" : "Activar",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            onTap: () async {
              if (roster.playerActive) {
                await RosterNetwork.instance.removePlayerOfRoster(
                    roster.teamModel.idTeam,
                    roster.tournamentModel.idTournament,
                    roster.playerModel.idPlayer);
                setState(() {});
              }

              //******************************* */
              //**UPDATE DATA PLAYERS */
              //******************************* */

              BlocProvider.of<PlayerBloc>(context).add(const GetPlayers());
              Navigator.pop(context);
            })
      ],
    );
  }
}
