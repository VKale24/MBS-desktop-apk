import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/ui/tournament/tournaments_page.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:desktop_apk/ui/home/home_page.dart';
import 'package:desktop_apk/ui/player/player_page.dart';
import 'package:desktop_apk/ui/team/team_page.dart';

int currentIndex = 0;

class Drawer extends StatefulWidget {
  const Drawer({Key? key}) : super(key: key);

  @override
  State<Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
          leading: Container(
        decoration:  const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle),
        child: Center(
            child:
                Image.network("${Network.url}/image/${CommonValues.imageMBS}")),
      )),
      pane: NavigationPane(
          header: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: DefaultTextStyle(
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                child: Text("Mi Barrio Sueña")),
          ),
          items: [
            PaneItem(
                icon: const Icon(FluentIcons.home),
                title: const Text("Pantalla Principal")),
            PaneItem(
                icon: const Icon(FluentIcons.people),
                title: const Text("Jugadores")),
            PaneItem(
                icon: const Icon(FluentIcons.diamond),
                title: const Text("Equipos")),
            PaneItem(
                icon: const Icon(FluentIcons.trophy2),
                title: const Text("Torneos")),
          ],
          selected: currentIndex,
          displayMode: PaneDisplayMode.open,
          onChanged: (i) {
            setState(() {
              currentIndex = i;
            });
          }),
      content: NavigationBody(
        index: currentIndex,
        children: const [
          HomePage(),
          PlayerPage(),
          TeamPage(),
          TournamentsPage()
        ],
      ),
    );
  }
}
