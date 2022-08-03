part of 'category_tournament_select_bloc.dart';

abstract class CategoryTournamentSelectEvent {
  const CategoryTournamentSelectEvent();

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
