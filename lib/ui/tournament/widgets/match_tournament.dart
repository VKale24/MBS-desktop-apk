// ignore_for_file: use_build_context_synchronously

import 'package:desktop_apk/domain/repository/match_repository.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/global/values.dart';
import 'package:desktop_apk/global/network.dart';
import 'package:desktop_apk/ui/match/match.dart';
import 'package:desktop_apk/ui/common/routes.dart';
import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/team_match_model.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/bloc/match/match_bloc.dart';
import 'package:desktop_apk/domain/entities/team_tournament.dart';
import 'package:desktop_apk/ui/tournament/widgets/card_match.dart';
import 'package:desktop_apk/data/model/team_tournament_model.dart';

import '../../../domain/repository/team_tournament_repository.dart';
import '../../../global/service_locator.dart';

class MatchTournament extends StatefulWidget {
  const MatchTournament({
    Key? key,
    required this.size,
    required this.tournamentSelected,
  }) : super(key: key);

  final Size size;
  final TournamentModel tournamentSelected;

  @override
  State<MatchTournament> createState() => _MatchTournamentState();
}

class _MatchTournamentState extends State<MatchTournament>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _progressAnimation = CurvedAnimation(
        parent: _animationController, curve: const Interval(0.0, 0.65));
    BlocProvider.of<MatchBloc>(context).add(GetMatchsByTournamentAndRound(
        idTournament: widget.tournamentSelected.idTournament,
        round: roundSelected));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  bool matchSelected = false;

  int selectMatchIndex = -1;
  int roundSelected = 1;
  refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //  height: 10,
          height: double.infinity,
          width: widget.size.width * .68,
          color: ColorApp.colorBlackFont,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        "Partidos",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Jornada ${roundSelected.toString()}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 9.0),
                                      child: Icon(
                                          FluentIcons.decrease_indent_arrow),
                                    ),
                                  )),
                            ),
                            onTap: () {
                              if (roundSelected != 1) {
                                setState(() {
                                  roundSelected--;
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 2.0),
                          GestureDetector(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 9.0),
                                      child: Icon(
                                          FluentIcons.increase_indent_arrow),
                                    ),
                                  )),
                            ),
                            onTap: () {
                              if (roundSelected !=
                                  widget.tournamentSelected.duration) {
                                setState(() {
                                  roundSelected++;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                BlocBuilder<MatchBloc, MatchState>(builder: (context, state) {
                  if (state is LoadedMatchsByTournamentAndRound) {
                    List<ListTeamMatchs> listMatchs = state.listMatchs;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: listMatchs.length,
                        itemBuilder: (BuildContext context, index) {
                          return SizedBox(
                            //height: 120,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: CardMatch(
                                      index: index,
                                      listMatchs: listMatchs,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectMatchIndex = index;
                                      _animationController.forward();
                                      matchSelected = !matchSelected;
                                    });
                                  },
                                ),
                                selectMatchIndex == index
                                    ? ScaleTransition(
                                        scale: _progressAnimation,
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          height: matchSelected ? 50 : 0,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: ColorApp.kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                child: MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: ColorApp
                                                            .colorBlackFont,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Text(
                                                        "Editar partido",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      slide(() => MatchPage(
                                                            listTeamMatchs:
                                                                listMatchs[
                                                                    index],
                                                          )));
                                                },
                                              ),
                                              MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: ColorApp
                                                          .colorBlackFont,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Text(
                                                      "Eliminar partido",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: const Text(
                          "No hay partidos",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                })
              ],
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
                    return DropDownTeamsTournament(
                      tournamentSelected: widget.tournamentSelected,
                      refreshStateCallback: refreshState,
                    );
                  },
                );
              }),
        )
      ],
    );
  }
}

class DropDownTeamsTournament extends StatefulWidget {
  const DropDownTeamsTournament(
      {Key? key,
      required this.tournamentSelected,
      required this.refreshStateCallback})
      : super(key: key);

  final TournamentModel tournamentSelected;
  final Function refreshStateCallback;

  @override
  State<DropDownTeamsTournament> createState() =>
      _DropDownTeamsTournamentState();
}

class _DropDownTeamsTournamentState extends State<DropDownTeamsTournament> {
  TextEditingController referee = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController round = TextEditingController();
  Map selectedTeam1 = {"name": "Equipo 1", "idTeam": -1};
  Map selectedTeam2 = {"name": "Equipo 2", "idTeam": -1};
  bool isTextFormEmpty = false;
  bool isSameTeam = false;
  @override
  Widget build(BuildContext context) {
    Future<List<MenuFlyoutItem>> createDropDownTeamList(String team) async {
      ListTeamTournaments listTeamTournaments =
          await locator<TeamTournamentRepository>()
              .getTeamsByTournament(widget.tournamentSelected.idTournament);
      List<MenuFlyoutItem> listMenuFlyoutItems = [];
      for (int i = 0; i < listTeamTournaments.listTeamTournament.length; i++) {
        TeamTournament teamTournament =
            listTeamTournaments.listTeamTournament[i];
        listMenuFlyoutItems.add(MenuFlyoutItem(
            leading: teamTournament.teamModel.image == "no image"
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      "${Network.url}/image/${CommonValues.noImage}",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.network(
                    "${Network.url}/image/${teamTournament.teamModel.image}",
                    width: 30),
            text:
                Text(listTeamTournaments.listTeamTournament[i].teamModel.name),
            selected: true,
            onPressed: () {
              setState(() => {
                    //**
                    //PARA SABER CUAL DE LOS DROPDOWN ACTUALIZAR
                    // */
                    if (team == "team1")
                      {
                        selectedTeam1["name"] = listTeamTournaments
                            .listTeamTournament[i].teamModel.name,
                        selectedTeam1["idTeam"] = listTeamTournaments
                            .listTeamTournament[i].teamModel.idTeam
                      }
                    else
                      {
                        selectedTeam2["name"] = listTeamTournaments
                            .listTeamTournament[i].teamModel.name,
                        selectedTeam2["idTeam"] = listTeamTournaments
                            .listTeamTournament[i].teamModel.idTeam
                      }
                  });
            }));
      }
      return listMenuFlyoutItems;
    }

    return ContentDialog(
      title: const Center(child: Text('Crear partido')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /*Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            child: const Text("Crear Partido",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),*/
          isTextFormEmpty
              ? Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Text("Todos los campos son obligatorios",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                )
              : const SizedBox.shrink(),
          isSameTeam
              ? Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Text("Lo equipos introducidos no pueden ser iguales",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                )
              : const SizedBox.shrink(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Fecha",
                controller: date,
              ),
            ),
          ),
          /*SizedBox(
          width: 100,
          child: Container(
           // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .2),
            child: DatePicker(
                header: 'Date of birth', selected: dateTime, onChanged: (v) {}),
          ),
        ),*/
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(placeholder: "Jornada", controller: round),
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
              child: TextBox(placeholder: "Árbitro", controller: referee),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: createDropDownTeamList("team1"),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox(height: 10, child: ProgressRing());
                  }
                  List<MenuFlyoutItem> listMenuFlyoutItem = snapshot.data;

                  if (snapshot.data.length == 0) {
                    return const Text("No hay equipos en este torneo");
                  }
                  return Row(
                    children: [
                      DropDownButton(
                        title: Text(selectedTeam1["name"]),
                        items: listMenuFlyoutItem.map((item) {
                          return item;
                        }).toList(),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: const Text(
                            "VS",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ],
                  );
                },
              ),
              FutureBuilder(
                future: createDropDownTeamList("team2"),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox(height: 10, child: ProgressRing());
                  }
                  List<MenuFlyoutItem> listMenuFlyoutItem = snapshot.data;

                  if (snapshot.data.length == 0) {
                    return const SizedBox.shrink();
                  }
                  return DropDownButton(
                    title: Text(selectedTeam2["name"]),
                    items: listMenuFlyoutItem.map((item) {
                      return item;
                    }).toList(),
                  );
                },
              ),
            ],
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
                      color: Colors.successPrimaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Aceptar",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ),
              onTap: () async {
                //**
                //VALIDAR LOS CAMPOS
                // */

                if (referee.text.isEmpty ||
                    date.text.isEmpty ||
                    round.text.isEmpty ||
                    selectedTeam1["idTeam"] == -1 ||
                    selectedTeam2["idTeam"] == -1) {
                  setState(() {
                    isTextFormEmpty = true;
                    isSameTeam = false;
                  });
                } else if (selectedTeam1["idTeam"] == selectedTeam2["idTeam"]) {
                  setState(() {
                    isSameTeam = true;
                    isTextFormEmpty = false;
                  });
                } else {
                  MatchModel matchModel = MatchModel(
                      idMatch: 0,
                      referee: referee.text,
                      date: date.text,
                      round: int.parse(round.text),
                      tournamentModel: widget.tournamentSelected);
                  bool isCreate = await locator<MatchRepository>().createMatch(
                      matchModel,
                      selectedTeam1["idTeam"],
                      selectedTeam2["idTeam"],
                      widget.tournamentSelected.idTournament);

                  if (isCreate) {
                    Navigator.pop(context);
                    showSnackbar(
                        context,
                        //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .9),
                        const Snackbar(
                          extended: true,
                          content: Align(
                              alignment: Alignment.center,
                              child: Text('Partido creado correctamente')),
                        ),
                        duration: const Duration(seconds: 3));
                    widget.refreshStateCallback();
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
                      //color: const Color.fromARGB(255, 173, 172, 172),
                      color: Colors.errorPrimaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Cancelar",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
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
