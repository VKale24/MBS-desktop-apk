import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/domain/bloc/category_team_select/category_team_select_bloc.dart';

class CategorySelectTeam extends StatelessWidget {
  const CategorySelectTeam({
    Key? key,
    required this.team,
  }) : super(key: key);
  final Team team;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryTeamSelectBloc, CategoryTeamSelectState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              GestureDetector(
                child: _categorySelect(
                    text: "Datos Principales",
                    selected: state is StateInfoTeam),
                onTap: () {
                  BlocProvider.of<CategoryTeamSelectBloc>(context)
                      .add(const SelectInfoTeam());
                },
              ),
              GestureDetector(
                child: _categorySelect(
                    text: "Calendario", selected: state is StateCalendar),
                onTap: () {
                  BlocProvider.of<CategoryTeamSelectBloc>(context)
                      .add(const SelectCalendar());
                },
              ),
              GestureDetector(
                child: _categorySelect(
                    text: "Jugadores", selected: state is StatePlayers),
                onTap: () {
                  BlocProvider.of<CategoryTeamSelectBloc>(context)
                      .add(const SelectPlayers());
                },
              ),
              /*GestureDetector(
                child: _categorySelect(
                    text: "Logros", selected: state is StateAchievements),
                onTap: () {
                  BlocProvider.of<CategoryTeamSelectBloc>(context)
                      .add(const SelectAchievements());
                },
              )*/
            ],
          ),
        );
      },
    );
  }

  Widget _categorySelect({required String text, required bool selected}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: selected
                ? const Color.fromARGB(255, 219, 160, 33)
                : ColorApp.colorBlack,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}
