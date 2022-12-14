part of 'category_team_select_bloc.dart';

@immutable
abstract class CategoryTeamSelectEvent extends Equatable {
  const CategoryTeamSelectEvent();

  @override
  List<Object?> get props => [];
}

class SelectInfoTeam extends CategoryTeamSelectEvent {
  const SelectInfoTeam();
}

class SelectCalendar extends CategoryTeamSelectEvent {
  const SelectCalendar();
}

class SelectPlayers extends CategoryTeamSelectEvent {
  const SelectPlayers();
}

class SelectAchievements extends CategoryTeamSelectEvent {
  const SelectAchievements();
}
