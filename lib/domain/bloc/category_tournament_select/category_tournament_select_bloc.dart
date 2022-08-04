import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_tournament_select_event.dart';
part 'category_tournament_select_state.dart';

class CategoryTournamentSelectBloc
    extends Bloc<CategoryTournamentSelectEvent, CategoryTournamentSelectState> {
  CategoryTournamentSelectBloc()
      : super(const CategoryTournamentSelectInitial()) {
    on<SelectInfoTournament>(_onSelectInfoTournament);
    on<SelectTeamTournament>(_onSelectTeamTournament);
    on<SelectCalendarTournament>(_onSelectCalendar);
    on<SelectStats>(_onSelectStats);
  }
  void _onSelectInfoTournament(
    SelectInfoTournament event,
    Emitter<CategoryTournamentSelectState> emit,
  ) {
    emit(const StateInfoTournament());
  }
  void _onSelectTeamTournament(
    SelectTeamTournament event,
    Emitter<CategoryTournamentSelectState> emit,
  ) {
    emit(const StateTeamTournament());
  }

  void _onSelectCalendar(
    SelectCalendarTournament event,
    Emitter<CategoryTournamentSelectState> emit,
  ) {
    emit(const StateCalendarTournament());
  }

  void _onSelectStats(
    SelectStats event,
    Emitter<CategoryTournamentSelectState> emit,
  ) {
    emit(const StateStats());
  }
}
