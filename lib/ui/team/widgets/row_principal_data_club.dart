import 'package:fluent_ui/fluent_ui.dart';
import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/domain/entities/team.dart';

class RowPrincipalDataClub extends StatelessWidget {
  const RowPrincipalDataClub({
    Key? key,
    required this.team,
    required this.isMark,
    required this.title,
    required this.text,
  }) : super(key: key);

  final Team team;
  //Bandera para poner la fina mas oscura
  final bool isMark;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isMark
              //? const Color.fromARGB(255, 32, 18, 30).withOpacity(.4)
              ? ColorApp.colorBlackFont
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: 200,
                child: Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w600))),
            const SizedBox(
              width: 240,
            ),
            SizedBox(
                width: 400,
                child: Text(text,
                    style: const TextStyle(fontWeight: FontWeight.w600)))
          ],
        ),
      ),
    );
  }
}
