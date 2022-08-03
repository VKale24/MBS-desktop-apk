// ignore_for_file: use_build_context_synchronously

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/bloc/tournament/tournament_bloc.dart';
import 'package:desktop_apk/ui/tournament/widgets/tournaments_table.dart';
import 'package:desktop_apk/ui/tournament/widgets/tournaments_table_data_source.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/network/player_network.dart';
import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/domain/bloc/player/player_bloc.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({Key? key}) : super(key: key);

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentBloc, TournamentState>(
        builder: (context, state) {
      Tournaments tournaments = Tournaments();
      if (state is LoadedTournaments) {
        tournaments = state.tournaments;
        return Stack(
          children: [
            tournaments.tournaments.isNotEmpty
                ? TournamentsTable(
                    tournaments: tournaments,
                    tournamentsTableDataSource:
                        TournamentsTableDataSource(tournaments: tournaments))
                : Padding(
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
                          "No hay torneos actualmente",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
            Positioned(
              bottom: 40,
              right: 20,
              child: GestureDetector(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("+",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  onTap: () {
                    /*showDialog(
                      context: context,
                      builder: (context) {
                        return CreateTournam(
                            refreshStateCallback: refreshState);
                      },
                    );*/
                  }),
            )
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Tabla no disponible, por favor espere...",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ProgressRing(),
          ],
        );
      }
    });
  }

  Widget _showMyDialog(context, index, Players players) {
    return ContentDialog(
      // title: const Text('AlertDialog Title'),
      content: players.players[index].active
          ? const Text('¿Estas seguro dar de baja a este jugador?',
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
                    color: players.players[index].active
                        ? const Color.fromARGB(255, 207, 27, 14)
                        : const Color.fromARGB(255, 4, 102, 9),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        players.players[index].active ? "Eliminar" : "Activar",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            onTap: () async {
              players.players[index].active
                  ? await PlayerNetwork.instance
                      .desactivatePlayer(players.players[index].idPlayer)
                  : await PlayerNetwork.instance
                      .activatePlayer(players.players[index].idPlayer);

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
