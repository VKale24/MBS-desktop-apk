part of 'category_tournament_select_bloc.dart';

abstract class CategoryTournamentSelectEvent extends Equatable {
  const CategoryTournamentSelectEvent();
  
  @override
  List<Object?> get props => [];
}

class SelectInfoTournament extends CategoryTournamentSelectEvent {
  const SelectInfoTournament();
}

class SelectTeamTournament extends CategoryTournamentSelectEvent {
  const SelectTeamTournament();
}

class SelectCalendarTournament extends CategoryTournamentSelectEvent {
  const SelectCalendarTournament();
}

class SelectStats extends CategoryTournamentSelectEvent {
  const SelectStats();
}
