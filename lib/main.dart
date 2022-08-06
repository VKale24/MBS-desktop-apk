import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'global/color.dart';
import 'ui/common/drawer.dart';
import 'global/service_locator.dart';
import 'domain/bloc/team/team_bloc.dart';
import 'domain/bloc/match/match_bloc.dart';
import 'domain/bloc/player/player_bloc.dart';
import 'domain/bloc/team_match/team_match_bloc.dart';
import 'domain/bloc/tournament/tournament_bloc.dart';
import 'domain/bloc/match_stats/match_stats_bloc.dart';
import 'domain/bloc/team_tournament/teamtournament_bloc.dart';
import 'domain/bloc/category_team_select/category_team_select_bloc.dart';
import 'domain/bloc/category_tournament_select/category_tournament_select_bloc.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TeamBloc()),
        BlocProvider(create: (_) => MatchBloc()),
        BlocProvider(create: (_) => PlayerBloc()),
        BlocProvider(create: (_) => TeamMatchBloc()),
        BlocProvider(create: (_) => MatchStatsBloc()),
        BlocProvider(create: (_) => TournamentBloc()),
        BlocProvider(create: (_) => TeamTournamentBloc()),
        BlocProvider(create: (_) => CategoryTeamSelectBloc()),
        BlocProvider(create: (_) => CategoryTournamentSelectBloc()),
      ],
      child: FluentApp(
          debugShowCheckedModeBanner: false,
          title: 'MBS',
          theme: ThemeData(
              focusTheme: const FocusThemeData(
                glowFactor: 4.0,
              ),
              scaffoldBackgroundColor: ColorApp.colorBlackFont,
              brightness: Brightness.dark,
              accentColor: Colors.yellow,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              typography: Typography.fromBrightness(color: Colors.white),
              snackbarTheme: SnackbarThemeData(
                  decoration: BoxDecoration(
                      color: Colors.successPrimaryColor,
                      borderRadius: BorderRadius.circular(10)))),
          home: const InitData()),
    );
  }
}

class InitData extends StatefulWidget {
  const InitData({Key? key}) : super(key: key);

  @override
  State<InitData> createState() => _InitDataState();
}

class _InitDataState extends State<InitData> {
  @override
  void initState() {
    BlocProvider.of<PlayerBloc>(context).add(
      const GetPlayers(),
    );
    BlocProvider.of<TeamBloc>(context).add(
      const GetTeams(),
    );
    BlocProvider.of<TournamentBloc>(context).add(
      const GetTournaments(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Drawer();
  }
}
