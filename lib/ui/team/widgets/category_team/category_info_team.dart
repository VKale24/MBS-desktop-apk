// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';
import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../edit_team_dialog.dart';
import '../../../../global/color.dart';
import '../../../../global/values.dart';
import '../row_principal_data_club.dart';
import '../../../../global/network.dart';
import '../../../../domain/entities/team.dart';
import '../../../../domain/bloc/team/team_bloc.dart';
import '../../../../domain/logic/logic_functions.dart';

class CategoryInfoTeam extends StatefulWidget {
  CategoryInfoTeam({
    Key? key,
    required this.team,
  }) : super(key: key);

  Team team;

  @override
  State<CategoryInfoTeam> createState() => _CategoryInfoTeamState();
}

class _CategoryInfoTeamState extends State<CategoryInfoTeam> {
  void setStateCallback(Team team) {
    setState(() {
      widget.team = team;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * .32,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                    // width: size.width * .32,
                                    child: Text('Equipo',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600))),
                                GestureDetector(
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: ColorApp.colorBlack,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                              Icon(FluentIcons.edit, size: 14),
                                        )),
                                  ),
                                  onTap: () async {
                                    var image = await LogicFunctions.getImage();
                                    if (image is File) {
                                      BlocProvider.of<TeamBloc>(context).add(
                                          UploadImageOfTeam(
                                              image: image,
                                              nextEmit: "selectedTeam",
                                              team: widget.team));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          //const SizedBox(width: 240),
                          SizedBox(
                            width: size.width * .32,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 30,
                                  // width: 200,
                                  child: widget.team.image == "no image"
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.network(
                                            "${Network.url}/image/${CommonValues.noImage}",
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.network(
                                          "${Network.url}/image/${widget.team.image}"),
                                ),
                                const SizedBox(width: 2.0),
                                SizedBox(
                                    // width: 400,
                                    child: Text(widget.team.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600))),
                              ],
                            ),
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: size.width * .22,
                              ),
                              GestureDetector(
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 4, 83, 148),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            boxShadow: const [
                                              BoxShadow(
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  color: Colors.black)
                                            ]),
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            "Editar equipo",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditTeamDialog(
                                            team: widget.team,
                                            callback: setStateCallback);
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              RowPrincipalDataClub(
                  team: widget.team,
                  isMark: true,
                  title: 'Municipio',
                  text: widget.team.town),
              RowPrincipalDataClub(
                  team: widget.team,
                  isMark: false,
                  title: 'Manager',
                  text: widget.team.manager),
              RowPrincipalDataClub(
                  team: widget.team,
                  isMark: true,
                  title: 'Capitán',
                  text: widget.team.captain.toString()),
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                          width: 200,
                          child: Text('Color de Equipación',
                              style: TextStyle(fontWeight: FontWeight.w600))),
                      const SizedBox(width: 240.0),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: widget.team.equipationColor == "white"
                                ? Colors.white
                                : widget.team.equipationColor == "black"
                                    ? Colors.black
                                    : ColorApp.getColorFromName(
                                        widget.team.equipationColor),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      const SizedBox(width: 4.0),
                    ],
                  ),
                ),
              ),
              RowPrincipalDataClub(
                  team: widget.team,
                  isMark: true,
                  title: 'Fecha de creación',
                  text: "2 octubre 2016"),
              RowPrincipalDataClub(
                  team: widget.team,
                  isMark: false,
                  title: 'Mayor racha de victorias',
                  text: Random().nextInt(15).toString()),
              RowPrincipalDataClub(
                  team: widget.team,
                  isMark: true,
                  title: 'Mayor Racha de derrotas',
                  text: Random().nextInt(6).toString()),
              RowPrincipalDataClub(
                  team: widget.team,
                  isMark: false,
                  title: 'Mejor resultado',
                  text: "5-0 vs Inter Callejas"),
              RowPrincipalDataClub(
                  team: widget.team,
                  isMark: true,
                  title: 'Peor resultado',
                  text: "2-6 vs Castilla"),
              RowPrincipalDataClub(
                  team: widget.team,
                  isMark: false,
                  title: 'Estado',
                  text: widget.team.active ? "Activo" : "Inactivo"),
            ],
          ),
        ),
      ),
    );
  }
}
