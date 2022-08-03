import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/data/model/roster_model.dart';
import 'package:desktop_apk/network/player_network.dart';
import 'package:desktop_apk/network/roster_network.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/domain/entities/player.dart';
import 'package:desktop_apk/domain/entities/player_stats.dart';

class TeamTournamentPlayer extends StatefulWidget {
  const TeamTournamentPlayer({
    Key? key,
    required this.player,
    required this.size,
  }) : super(key: key);

  final Player player;
  final Size size;

  @override
  State<TeamTournamentPlayer> createState() => _TeamTournamentPlayerState();
}

class _TeamTournamentPlayerState extends State<TeamTournamentPlayer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RosterNetwork.instance.getTeamsByPlayer(widget.player.idPlayer),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: ProgressRing());
          } else if (snapshot.data.playersRoster.length == 0) {
            return const Center(
                child: SizedBox(
              height: 220,
              child: Align(
                alignment: Alignment.center,
                child: Text("El jugador no tiene equipos aún.",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
              ),
            ));
          } else {
            return Container(
              height: 220,
              margin: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.playersRoster.length,
                  itemBuilder: (context, index) {
                    RosterModel roster = snapshot.data.playersRoster[index];

                    if (snapshot.data == null) {
                      return const Center(child: ProgressRing());
                    }
                    return Container(
                      height: 100,
                      width: widget.size.width * .2,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: ColorApp.colorBlackFont,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Color.fromARGB(115, 27, 27, 27))
                          ]),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  height: 100,
                                  width: widget.size.width * .07,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            roster.playerActive
                                                ? "Active"
                                                : "Inactivo",
                                            style: TextStyle(
                                                color: roster.playerActive
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold))),
                                  )),
                              roster.teamModel.image == "no image"
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 10.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          "${Network.url}/image/${CommonValues.noImage}",
                                          height: widget.size.height * .1,
                                          width: widget.size.width * .062,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(top: 10.0),
                                      width: widget.size.width * .062,
                                      child: Image.network(
                                          "${Network.url}/image/${roster.teamModel.image}"),
                                    ),
                              SizedBox(
                                width: widget.size.width * .040,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: const Align(
                                          alignment: Alignment.center,
                                          child: Text("-",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                    ),
                                  ),
                                  onTap: () async {
                                    await RosterNetwork.instance
                                        .removePlayerOfRoster(
                                            roster.teamModel.idTeam,
                                            roster.tournamentModel.idTournament,
                                            widget.player.idPlayer);
                                    setState(() {});
                                    /*showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ConfirmAction(
                                              title:
                                                  "¿Seguro desea darle de baja del roster",
                                              callbackFalse: _setState,
                                              callbackTrue:
                                                  _setStateTeamTournament(
                                                      teamTournament));
                                        });*/
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                roster.teamModel.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " - ${roster.tournamentModel.name}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                            future: PlayerNetwork.instance
                                .getStatsOfPlayerByTournament(
                                    widget.player.idPlayer,
                                    roster.tournamentModel.idTournament),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return const ProgressRing();
                              }
                              PlayerStats playerStats = snapshot.data;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: "Goles: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                              text:
                                                  playerStats.goal.toString()),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: "Asistencias: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                              text: playerStats.assist
                                                  .toString()),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: "Tarjetas Amarillas: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                              text: playerStats.yellowCard
                                                  .toString()),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: "Tarjetas rojas: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                              text: playerStats.redCard
                                                  .toString()),
                                        ]),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
        });
  }
}
