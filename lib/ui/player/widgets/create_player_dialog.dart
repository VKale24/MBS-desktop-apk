
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:desktop_apk/common/color.dart';
import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/common/values.dart';
import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/domain/bloc/player/player_bloc.dart';
import 'package:desktop_apk/domain/logic/logic_functions.dart';
import 'package:desktop_apk/network/player_network.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlayerDialog extends StatefulWidget {
  const CreatePlayerDialog({Key? key, required this.refreshStateCallback})
      : super(key: key);

  final Function refreshStateCallback;

  @override
  State<CreatePlayerDialog> createState() => _CreatePlayerDialogState();
}

class _CreatePlayerDialogState extends State<CreatePlayerDialog> {
  bool isTextBoxEmpty = false;
  bool isErrorCastNumber = false;
  bool isImageUpload = false;
  late File imagePlayer;

  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController phone = TextEditingController();
  PlayerModel player = PlayerModel(
      idPlayer: 0,
      name: "",
      lastName: "",
      nickname: "nickname",
      age: 0,
      height: 0,
      weight: 0,
      phone: "",
      profession: "Estudiante",
      ci: "",
      image: "no image",
      imageFace: "no image",
      position: "",
      active: true);

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Center(
          child: Text(
        'Crear jugador',
        style: TextStyle(fontSize: 18),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isTextBoxEmpty
              ? Text("Todos los campos son obligatorios",
                  style: TextStyle(color: Colors.red))
              : const SizedBox.shrink(),
          isErrorCastNumber
              ? Text("Ha introducido un dato incorrectamente",
                  style: TextStyle(color: Colors.red))
              : const SizedBox.shrink(),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                  child: isImageUpload
                      ? Image.file(imagePlayer)
                      : Image.network(
                          "${Network.url}/image/${CommonValues.noImagePlayer}"),
                ),
              ),
              GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: ColorApp.colorBlack,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        FluentIcons.edit,
                        size: 10,
                      )),
                ),
                onTap: () async {
                  var image = await LogicFunctions.getImage();
                  if (image is File) {
                    setState(() {
                      imagePlayer = image;
                      isImageUpload = true;
                    });
                    /*BlocProvider.of<PlayerBloc>(context).add(
                                          UploadImageOfPlayer(player, image));*/
                  }
                },
              ),
            ],
          ),
          Container(
            //height: 32,
            //  width: 370,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Nombre",
                onChanged: (text) {
                  player.name = text;
                },
              ),
            ),
          ),
          Container(
            //height: 32,
            //  width: 370,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Apellidos",
                onChanged: (text) {
                  player.lastName = text;
                },
              ),
            ),
          ),
          Container(
            //  width: 370,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "CI",
                headerStyle: TextStyle(color: Colors.orange),
                onChanged: (text) {
                  player.ci = text;
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                keyboardType: TextInputType.number,
                placeholder: "Edad",
                controller: age,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Estatura",
                controller: height,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Peso",
                controller: weight,
              ),
            ),
          ),
          Container(
            //  width: 370,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Posición",
                headerStyle: TextStyle(color: Colors.orange),
                onChanged: (text) {
                  player.position = text;
                },
              ),
            ),
          ),
          Container(
            //height: 32,
            //  width: 370,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 78, 78),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextBox(
                placeholder: "Teléfono",
                onChanged: (text) {
                  player.phone = text;
                },
              ),
            ),
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
              onTap: () async {
                if (player.name.isEmpty ||
                    player.lastName.isEmpty ||
                    player.ci.isEmpty ||
                    age.text.isEmpty ||
                    height.text.isEmpty ||
                    weight.text.isEmpty ||
                    player.position.isEmpty ||
                    player.phone.isEmpty) {
                  setState(() {
                    isTextBoxEmpty = true;
                  });
                }
                try {
                  player.age = int.parse(age.text);
                  player.height = int.parse(height.text);
                  player.weight = int.parse(weight.text);
                } catch (e) {
                  setState(() {
                    isErrorCastNumber = true;
                  });
                }
                PlayerModel playerCreated =
                    await PlayerNetwork.instance.createPlayer(player);
                if (isImageUpload) {
                  BlocProvider.of<PlayerBloc>(context).add(UploadImageOfPlayer(
                      player: playerCreated, image: imagePlayer));
                  widget.refreshStateCallback();
                }
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
