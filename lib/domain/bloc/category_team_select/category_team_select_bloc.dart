import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_team_select_event.dart';
part 'category_team_select_state.dart';

class CategoryTeamSelectBloc
    extends Bloc<CategoryTeamSelectEvent, CategoryTeamSelectState> {
  CategoryTeamSelectBloc() : super(const CategoryTeamSelectInitial()) {
    on<SelectInfoTeam>(_onSelectInfoTeam);
    on<SelectCalendar>(_onSelectCalendar);
    on<SelectPlayers>(_onSelectPlayers);
    on<SelectAchievements>(_onSelectAchievements);
  }

  void _onSelectInfoTeam(
    SelectInfoTeam event,
    Emitter<CategoryTeamSelectState> emit,
  ) {
    emit(const StateInfoTeam());
  }

  void _onSelectCalendar(
    SelectCalendar event,
    Emitter<CategoryTeamSelectState> emit,
  ) {
    emit(const StateCalendar());
  }

  void _onSelectPlayers(
    SelectPlayers event,
    Emitter<CategoryTeamSelectState> emit,
  ) {
    emit(const StatePlayers());
  }

  void _onSelectAchievements(
    SelectAchievements event,
    Emitter<CategoryTeamSelectState> emit,
  ) {
    emit(const StateAchievements());
  }
}
