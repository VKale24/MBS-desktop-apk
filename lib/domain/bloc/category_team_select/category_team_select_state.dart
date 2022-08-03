part of 'category_team_select_bloc.dart';

@immutable
abstract class CategoryTeamSelectState {
  const CategoryTeamSelectState();

  List<Object?> get props => [];
}

class CategoryTeamSelectInitial extends CategoryTeamSelectState {
  const CategoryTeamSelectInitial();

  @override
  List<Object?> get props => [];
}

class StateInfoTeam extends CategoryTeamSelectState {
  const StateInfoTeam();
}

class StateCalendar extends CategoryTeamSelectState {
  const StateCalendar();
}

class StatePlayers extends CategoryTeamSelectState {
  const StatePlayers();
}

class StateAchievements extends CategoryTeamSelectState {
  const StateAchievements();
}
