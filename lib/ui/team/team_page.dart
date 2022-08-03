// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/network/team_network.dart';
import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/domain/bloc/team/team_bloc.dart';
import 'package:desktop_apk/ui/team/widgets/team_table.dart';
import 'package:desktop_apk/domain/logic/logic_functions.dart';
import 'package:desktop_apk/ui/team/widgets/team_table_data_source.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamBloc, TeamState>(
      builder: (context, state) {
        Teams teams = Teams();
        if (state is LoadedTeams) {
          teams = state.teams;
        }
        return Stack(
          children: [
            teams.teams.isNotEmpty
                ? TeamsTable(
                    teams: teams,
                    teamsTableDataSource: TeamsTableDataSource(teams: teams))
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
                          "No hay jugadores dentro del equipo",
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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CreateTeamDialog(
                            refreshStateCallback: refreshState);
                      },
                    );
                  }),
            )
          ],
        );
      },
    );
  }
}

class CreateTeamDialog extends StatefulWidget {
  const CreateTeamDialog({Key? key, required this.refreshStateCallback})
      : super(key: key);

  final Function refreshStateCallback;

  @override
  State<CreateTeamDialog> createState() => _CreateTeamDialogState();
}

class _CreateTeamDialogState extends State<CreateTeamDialog> {
  TeamModel team = TeamModel(
      idTeam: 0,
      name: "",
      captain: "",
      manager: "",
      equipationColor: "red",
      image: "no image",
      headerImage: "no header",
      description: "",
      town: "",
      active: true);
  bool isImageUpload = false;
  late File imageTeam;

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Center(child: Text('Crear equipo')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                  child: isImageUpload
                      ? Image.file(imageTeam)
                      : Image.network(
                          "${Network.url}/image/${CommonValues.noImage}",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: ColorApp.colorBlack,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        FluentIcons.edit,
                        size: 10,
                      )),
                ),
                onTap: () async {
                  var image = await LogicFunctions.getImage();
                  if (image is File) {
                    setState(() {
                      imageTeam = image;
                      isImageUpload = true;
                    });
                    /*BlocProvider.of<PlayerBloc>(context).add(
                                          UploadImageOfPlayer(player, image));*/
                  }
                },
              ),
            ],
          ),
          Container(
            //height: 32,
            //  width: 370,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Nombre",
                onChanged: (text) {
                  team.name = text;
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Manager",
                onChanged: (text) {
                  team.manager = text;
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Capitán",
                onChanged: (text) {
                  team.captain = text;
                },
              ),
            ),
          ),
          Container(
            //height: 32,
            //  width: 370,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Municipio",
                onChanged: (text) {
                  team.town = text;
                },
              ),
            ),
          ),
          Container(
            //  width: 370,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                maxLines: 4,
                placeholder: "Descripción",
                headerStyle: TextStyle(color: Colors.orange),
                onChanged: (text) {
                  team.description = text;
                },
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorApp.kPrimaryColor,
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
                await TeamNetwork.instance.createTeam(team);
                if (isImageUpload) {
                  TeamModel teamModel =
                      await TeamNetwork.instance.getTeamByName(team.name);
                  BlocProvider.of<TeamBloc>(context).add(UploadImageOfTeam(
                      image: imageTeam,
                      team: teamModel,
                      nextEmit: "loadedTeams"));
                  widget.refreshStateCallback();
                }
                Navigator.pop(context);
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
}
