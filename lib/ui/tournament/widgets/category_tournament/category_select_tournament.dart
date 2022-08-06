import 'package:desktop_apk/domain/entities/tournament.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/domain/bloc/category_tournament_select/category_tournament_select_bloc.dart';

class CategorySelectTournament extends StatelessWidget {
  const CategorySelectTournament({
    Key? key,
    required this.tournament,
  }) : super(key: key);
  final Tournament tournament;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryTournamentSelectBloc,
        CategoryTournamentSelectState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: _categorySelect(
                      text: "Datos Principales",
                      selected: state is StateInfoTournament),
                ),
                onTap: () {
                  BlocProvider.of<CategoryTournamentSelectBloc>(context)
                      .add(const SelectInfoTournament());
                },
              ),
              GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: _categorySelect(
                      text: "Equipos", selected: state is StateTeamTournament),
                ),
                onTap: () {
                  BlocProvider.of<CategoryTournamentSelectBloc>(context)
                      .add(const SelectTeamTournament());
                },
              ),
              GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: _categorySelect(
                      text: "Calendario",
                      selected: state is StateCalendarTournament),
                ),
                onTap: () {
                  BlocProvider.of<CategoryTournamentSelectBloc>(context)
                      .add(const SelectCalendarTournament());
                },
              ),
              GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: _categorySelect(
                      text: "Estadísticas", selected: state is StateStats),
                ),
                onTap: () {
                  BlocProvider.of<CategoryTournamentSelectBloc>(context)
                      .add(const SelectStats());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _categorySelect({required String text, required bool selected}) {
    return Container(
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
    );
  }
}
