import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/color.dart';
import '../../../domain/entities/team.dart';
import '../../../data/model/team_model.dart';
import '../../../domain/bloc/team/team_bloc.dart';

class EditTeamDialog extends StatelessWidget {
  const EditTeamDialog({Key? key, required this.team, required this.callback})
      : super(key: key);

  final Team team;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    TextEditingController town = TextEditingController();
    TextEditingController manager = TextEditingController();
    TextEditingController captain = TextEditingController();
    TextEditingController nameTeam = TextEditingController();
    TextEditingController description = TextEditingController();
    return ContentDialog(
      title: const Center(child: Text('Editar equipo')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 90,
                child: Text("Nombre:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                //height: 32,
                width: 220,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 78, 78),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextBox(
                    placeholder: team.name,
                    controller: nameTeam,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 90,
                child: Text("Manager:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                width: 220,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 78, 78),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextBox(
                    placeholder: team.manager,
                    controller: manager,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 90,
                child: Text("Capitán:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                width: 220,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 78, 78),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextBox(
                    placeholder: team.captain,
                    headerStyle: TextStyle(color: Colors.orange),
                    controller: captain,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 90,
                child: Text("Municipio:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                width: 220,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 78, 78),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextBox(
                    placeholder: team.town,
                    headerStyle: TextStyle(color: Colors.orange),
                    controller: town,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 90,
                child: Text("Descripción:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                width: 220,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 78, 78),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextBox(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    placeholder: team.description,
                    headerStyle: TextStyle(color: Colors.orange),
                    controller: description,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorApp.kPrimaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Aceptar",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ),
              onTap: () {
                TeamModel teamEdit = team.copyWithTeam(
                    name: nameTeam.text,
                    manager: manager.text,
                    captain: captain.text,
                    town: town.text,
                    description: description.text);
                BlocProvider.of<TeamBloc>(context).add(UpdateTeam(teamEdit));
                callback(teamEdit);
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 10.0),
            GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 173, 172, 172),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Cancelar",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
