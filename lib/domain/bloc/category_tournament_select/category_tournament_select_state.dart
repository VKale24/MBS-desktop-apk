part of 'category_tournament_select_bloc.dart';

abstract class CategoryTournamentSelectState {
  const CategoryTournamentSelectState();
}

class CategoryTournamentSelectInitial extends CategoryTournamentSelectState {
  const CategoryTournamentSelectInitial();
}

class StateInfoTournament extends CategoryTournamentSelectState {
  const StateInfoTournament();
}

class StateTeamTournament extends CategoryTournamentSelectState {
  const StateTeamTournament();
}

class StateCalendarTournament extends CategoryTournamentSelectState {
  const StateCalendarTournament();
}

class StateStats extends CategoryTournamentSelectState {
  const StateStats();
}
