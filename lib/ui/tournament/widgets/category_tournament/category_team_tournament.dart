import 'package:desktop_apk/global/color.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CategoryTeamTournament extends StatefulWidget {
  const CategoryTeamTournament({Key? key}) : super(key: key);

  @override
  State<CategoryTeamTournament> createState() => _CategoryTeamTournamentState();
}

class _CategoryTeamTournamentState extends State<CategoryTeamTournament> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: ColorApp.colorBlackFont,
            borderRadius: BorderRadius.circular(10)),
      ),
    ));
  }
}
