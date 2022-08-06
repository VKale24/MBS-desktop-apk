// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:desktop_apk/domain/entities/player.dart';
import 'package:desktop_apk/ui/player/widgets/add_player_to_roster.dart';
import 'package:desktop_apk/ui/player/widgets/edit_player_dialog.dart';
import 'package:desktop_apk/ui/player/widgets/player_details/widgets/player_personal_data.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/global/values.dart';
import 'package:desktop_apk/global/network.dart';
import 'package:desktop_apk/domain/logic/logic_functions.dart';
import 'package:desktop_apk/domain/bloc/player/player_bloc.dart';
import 'package:desktop_apk/ui/player/widgets/team_tournament_player.dart';

class PlayerDetails extends StatefulWidget {
  PlayerDetails({Key? key, required this.player}) : super(key: key);

  Player player;

  @override
  State<PlayerDetails> createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  void setStateEditPlayerCallback(Player player) {
    setState(() {
      widget.player = player;
    });
  }

  void setStateCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return NavigationView(
      content: Column(children: [
        Expanded(
            child: Row(children: [
          Container(
            height: size.height,
            width: size.width,
            color: ColorApp.colorBlackFont,
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                              alignment: Alignment.topLeft,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 38, 46, 46),

                                  //color: ColorApp.colorBlackFont,
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: Color.fromARGB(255, 37, 34, 34))
                                  ]),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 7.0),
                                child: Icon(
                                  FluentIcons.decrease_indent_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )),
                        ),
                        onTap: () {
                          BlocProvider.of<PlayerBloc>(context)
                              .add(const GetPlayers());
                          Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 4, 83, 148),
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: Colors.black)
                                  ]),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Editar jugador",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        onTap: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (_) => EditPlayerDialog(
                                      player: widget.player,
                                      functionCallback:
                                          setStateEditPlayerCallback,
                                    ));
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        child: widget.player.image == "no image"
                            ? Image.network(
                                "${Network.url}/image/${CommonValues.noImagePlayer}")
                            : Image.network(
                                "${Network.url}/image/${widget.player.image}"),
                      ),
                      GestureDetector(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: ColorApp.colorBlack,
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(FluentIcons.edit, size: 14),
                              )),
                        ),
                        onTap: () async {
                          var image = await LogicFunctions.getImage();
                          if (image is File) {
                            BlocProvider.of<PlayerBloc>(context)
                                .add(UploadImageOfPlayer(
                              player: widget.player,
                              image: image,
                            ));
                          }
                        },
                      ),
                      PlayerPersonalData(
                        player: widget.player,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "Equipos:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                              margin: const EdgeInsets.only(top: 20, right: 10),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 4, 83, 148),
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: Colors.black)
                                  ]),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Añadir a equipo",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => AddPlayerToTeam(
                                  callback: setStateCallback,
                                  player: widget.player));
                        },
                      ),
                    ],
                  ),
                  TeamTournamentPlayer(player: widget.player, size: size),
                ])),
          ),
        ]))
      ]),
    );
  }
}
