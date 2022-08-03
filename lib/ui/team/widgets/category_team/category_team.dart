import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/domain/bloc/team/team_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/ui/team/widgets/category_team/category_select_club.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTeam extends StatefulWidget {
  const CategoryTeam({Key? key, required this.widget, required this.team}) : super(key: key);

  final Widget widget;
  final Team team;

  @override
  State<CategoryTeam> createState() => _CategoryTeamState();
}

class _CategoryTeamState extends State<CategoryTeam> {
  @override
  Widget build(BuildContext context) {
    return NavigationView(
        content: Stack(
          children: [
            Opacity(
                opacity: .25,
                child: Image.asset(
                  "assets/images/wallpapers/fontClub.jpg",
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 40,
                            width: 40,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 7.0),
                              child: Icon(
                                FluentIcons.decrease_indent_arrow,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          onTap: () {
                            BlocProvider.of<TeamBloc>(context)
                                .add(const GetTeams());
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        // width: 200,
                        child: widget.team.image == "no image"
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
                                "${Network.url}/image/${widget.team.image}"),
                      ),
                      const SizedBox(width: 5.0),
                      SizedBox(
                        child: Text(
                          widget.team.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                CategorySelectTeam(team: widget.team),

                //Widget enviado por parametro (Una de las categorias seleccionadas)
                widget.widget
                //CategoryInfoTeam(team: team),
              ],
            ),
          ],
        ),
      
    );
  }
}
