import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/domain/bloc/player/player_bloc.dart';
import 'package:desktop_apk/ui/common/user_alert.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:desktop_apk/global/color.dart';
import 'package:desktop_apk/domain/entities/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPlayerDialog extends StatefulWidget {
  const EditPlayerDialog(
      {Key? key, required this.player, required this.functionCallback})
      : super(key: key);
  final Player player;
  final Function functionCallback;

  @override
  State<EditPlayerDialog> createState() => _EditPlayerDialogState();
}

class _EditPlayerDialogState extends State<EditPlayerDialog> {
  String name = "";
  String lastName = "";
  String position = "";
  int age = 0;
  String ci = "";
  int height = 0;
  int weight = 0;
  String phone = "";
  String active = "";
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Center(
          child: Text(
        'Editar jugador',
        style: TextStyle(fontSize: 18),
      )),
      content: LayoutBuilder(
        builder: ((context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              fieldName(constraints.maxWidth),
              fieldLastName(constraints.maxWidth),
              fieldCI(constraints.maxWidth),
              fieldPosition(constraints.maxWidth),
              fieldAge(constraints.maxWidth),
              fieldHeight(constraints.maxWidth),
              fieldWeight(constraints.maxWidth),
              fieldPhone(constraints.maxWidth),
              //fieldState(),
            ],
          );
        }),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorApp.kPrimaryColor,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 2,
                              color: Colors.black)
                        ]),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Aceptar",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                onTap: () async {
                  //*********** HACEMOS EL COPY WITH
                  try {
                    PlayerModel playerUpdated = widget.player.copyWithPlayer(
                        name: name,
                        lastName: lastName,
                        age: age,
                        ci: ci,
                        nickname: "",
                        height: height,
                        weight: weight,
                        position: position,
                        phone: phone,
                        email: "",
                        image: "",
                        imageFace: "",
                        profession: "",
                        active: "");

                    //**ACTUALIZO EL PLAYER CON EL CALLBACK */
                    widget.functionCallback(playerUpdated);
                    //**ACTUALIZO EL JUGADOR EN LA BD */
                    BlocProvider.of<PlayerBloc>(context)
                        .add(UpdatePlayer(player: playerUpdated));
                    Navigator.pop(context);
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const MessageAlertDialog(
                            title: "El jugador no se pudo actualizar",
                          );
                        });
                  }
                }),
            const SizedBox(
              width: 20.0,
            ),
            GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.errorPrimaryColor,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 2, spreadRadius: 2, color: Colors.black)
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Cancelar",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
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

  Container fieldName(double maxWidth) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth * .22,
            child: const Text("Nombre:",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            height: 32,
            width: maxWidth * .7,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextBox(
              placeholder: widget.player.name,
              headerStyle: TextStyle(color: Colors.orange),
              // prefixIcon: Icon(Icons.email_outlined, size: 20,),
              /* hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              */
              onChanged: (text) {
                setState(() {
                  name = text;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container fieldLastName(double maxWidth) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth * .22,
            child: const Text("Apellidos: ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: maxWidth * .7,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextBox(
              placeholder: widget.player.lastName,
              headerStyle: TextStyle(color: Colors.orange),
              // prefixIcon: Icon(Icons.email_outlined, size: 20,),
              /* hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              */
              onChanged: (text) {
                setState(() {
                  lastName = text;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container fieldPosition(double maxWidth) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth * .22,
            child: const Text("Posición:",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          DropDownButton(
            leading: const Icon(FluentIcons.align_left),
            title: Text(widget.player.position),
            items: [
              MenuFlyoutItem(text: const Text('Pivot'), onPressed: () {}),
              MenuFlyoutItem(text: const Text('Ala'), onPressed: () {}),
              MenuFlyoutItem(text: const Text('Cierre'), onPressed: () {}),
              MenuFlyoutItem(text: const Text('Portero'), onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }

  Container fieldAge(double maxWidth) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth * .22,
            child: const Text("Edad: ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: maxWidth * .35,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextBox(
              placeholder: widget.player.age.toString(),
              headerStyle: TextStyle(color: Colors.orange),
              // prefixIcon: Icon(Icons.email_outlined, size: 20,),
              /* hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              */
              onChanged: (text) {
                setState(() {
                  age = int.parse(text);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container fieldCI(double maxWidth) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth * .22,
            child: const Text("CI: ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: maxWidth * .7,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextBox(
              placeholder: widget.player.ci.toString(),
              headerStyle: TextStyle(color: Colors.orange),
              // prefixIcon: Icon(Icons.email_outlined, size: 20,),
              /* hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              */
              onChanged: (text) {
                setState(() {
                  ci = text;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container fieldHeight(double maxWidth) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth * .22,
            child: const Text("Estatura: ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: maxWidth * .35,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextBox(
              placeholder: widget.player.height.toString(),
              headerStyle: TextStyle(color: Colors.orange),
              // prefixIcon: Icon(Icons.email_outlined, size: 20,),
              /* hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              */
              onChanged: (text) {
                setState(() {
                  height = int.parse(text);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container fieldWeight(double maxWidth) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth * .22,
            child: const Text("Peso: ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: maxWidth * .35,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextBox(
              placeholder: widget.player.weight.toString(),
              headerStyle: TextStyle(color: Colors.orange),
              // prefixIcon: Icon(Icons.email_outlined, size: 20,),
              /* hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              */
              onChanged: (text) {
                setState(() {
                  weight = int.parse(text);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container fieldPhone(double maxWidth) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth * .22,
            child: const Text("Teléfono: ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: maxWidth * .35,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextBox(
              placeholder: widget.player.phone.toString(),
              headerStyle: TextStyle(color: Colors.orange),
              // prefixIcon: Icon(Icons.email_outlined, size: 20,),
              /* hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              */
              onChanged: (text) {
                setState(() {
                  phone = text;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container fieldState(double maxWidth) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          SizedBox(
            width: maxWidth * .22,
            child: const Text("Estado:",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          /* Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: DropdownButton<String>(
                dropdownColor: ColorApp.colorBlackFont,
                autofocus: true,
                focusColor: const Color.fromARGB(255, 78, 78, 78),
                value:
                    active == "" ? widget.player.active.toString() : active,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(
                    color: Colors.amber, fontWeight: FontWeight.bold),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    active = newValue!;
                  });
                },
                items: <String>['true', 'false']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(value == "true" ? "Activo" : "Inactivo"),
                    ),
                  );
                }).toList(),
              )),*/
        ],
      ),
    );
  }
}
