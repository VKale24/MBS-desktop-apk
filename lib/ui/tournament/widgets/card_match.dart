import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/global/network.dart';
import 'package:desktop_apk/global/values.dart';
import 'package:desktop_apk/data/model/match_stats_model.dart';
import 'package:desktop_apk/data/model/team_match_model.dart';
import 'package:desktop_apk/domain/bloc/team/team_bloc.dart';
import 'package:desktop_apk/ui/common/routes.dart';
import 'package:desktop_apk/ui/team/widgets/team_details.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/match_stats_repository.dart';
import '../../../global/service_locator.dart';

class CardMatch extends StatefulWidget {
  const CardMatch({
    Key? key,
    required this.listMatchs,
    required this.index,
  }) : super(key: key);

  final int index;
  final List<ListTeamMatchs> listMatchs;

  @override
  State<CardMatch> createState() => _CardMatchState();
}

class _CardMatchState extends State<CardMatch> {
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: widget.index % 2 == 0
                ? ColorApp.colorBlack
                : ColorApp.colorBlackFont,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    //width: 200,
                    width: maxWidth * .13,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: widget.listMatchs[widget.index]
                                        .listTeamMatchs[0].teamModel.image ==
                                    "no image"
                                ? Image.network(
                                    "${Network.url}/image/${CommonValues.noImage}")
                                : Image.network(
                                    "${Network.url}/image/${widget.listMatchs[widget.index].listTeamMatchs[0].teamModel.image}")),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child: Text(widget.listMatchs[widget.index]
                              .listTeamMatchs[0].teamModel.name),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  BlocProvider.of<TeamBloc>(context).add(SelectTeam(
                      team: widget.listMatchs[widget.index].listTeamMatchs[0]
                          .teamModel));
                  Navigator.of(context).push(slide(() => TeamDetails(
                        team: widget.listMatchs[widget.index].listTeamMatchs[0]
                            .teamModel,
                      )));
                },
              ),
              widget.listMatchs[widget.index].listTeamMatchs[0].state ==
                      "notPlayed"
                  ? const Text("VS", style: TextStyle(color: Colors.white))
                  : Row(
                      children: [
                        ResultMatch(
                            listMatchs: widget.listMatchs,
                            index: widget.index,
                            teamIndex: 0),
                        const SizedBox(width: 5.0),
                        const Text(
                          "-",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 5.0),
                        ResultMatch(
                            listMatchs: widget.listMatchs,
                            index: widget.index,
                            teamIndex: 1),
                      ],
                    ),
              GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: maxWidth * .13,
                    //width: maxWidth * .25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(widget.listMatchs[widget.index]
                              .listTeamMatchs[1].teamModel.name),
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                            child: widget.listMatchs[widget.index]
                                        .listTeamMatchs[1].teamModel.image ==
                                    "no image"
                                ? Image.network(
                                    "${Network.url}/image/${CommonValues.noImage}")
                                : Image.network(
                                    "${Network.url}/image/${widget.listMatchs[widget.index].listTeamMatchs[1].teamModel.image}")),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  BlocProvider.of<TeamBloc>(context).add(SelectTeam(
                      team: widget.listMatchs[widget.index].listTeamMatchs[1]
                          .teamModel));
                  Navigator.of(context).push(slide(() => TeamDetails(
                        team: widget.listMatchs[widget.index].listTeamMatchs[1]
                            .teamModel,
                      )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultMatch extends StatelessWidget {
  const ResultMatch(
      {Key? key,
      required this.listMatchs,
      required this.index,
      required this.teamIndex})
      : super(key: key);

  final List<ListTeamMatchs> listMatchs;
  final int index;
  final int teamIndex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: locator<MatchStatsRepository>().getStatsByMatchAndTeam(
            listMatchs[index].listTeamMatchs[teamIndex].matchModel.idMatch,
            listMatchs[index].listTeamMatchs[teamIndex].teamModel.idTeam),
        builder: ((context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return const ProgressRing();
          MatchStatsModel matchStatsModel = snapshot.data;
          return Text(
            matchStatsModel.goal.toString(),
            style: const TextStyle(color: Colors.white),
          );
        }));
  }
}
