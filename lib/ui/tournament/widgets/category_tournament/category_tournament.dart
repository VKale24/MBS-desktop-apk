import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/domain/bloc/tournament/tournament_bloc.dart';
import 'package:desktop_apk/domain/entities/tournament.dart';
import 'package:desktop_apk/ui/tournament/widgets/category_tournament/category_select_tournament.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTournament extends StatelessWidget {
  const CategoryTournament(
      {Key? key, required this.widget, required this.tournament})
      : super(key: key);
  final Widget widget;
  final Tournament tournament;
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
                    GestureDetector(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
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
                      ),
                      onTap: () {
                        BlocProvider.of<TournamentBloc>(context)
                            .add(const GetTournaments());
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 30,
                      // width: 200,
                      child: tournament.image == "no image"
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
                              "${Network.url}/image/${tournament.image}"),
                    ),
                    const SizedBox(width: 5.0),
                    SizedBox(
                      child: Text(
                        tournament.name.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CategorySelectTournament(tournament: tournament),

              //Widget enviado por parametro (Una de las categorias seleccionadas)
              widget
              //CategoryInfoTeam(team: team),
            ],
          ),
        ],
      ),
    );
  }
}
