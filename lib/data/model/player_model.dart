// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:desktop_apk/domain/entities/player.dart';

PlayerModel playerModelFromJson(String str) =>
    PlayerModel.fromJson(json.decode(str));

String playerModelToJson(PlayerModel data) => json.encode(data.toJson());

class Players {
  List<Player> players = [];

  Players();

  Players.fromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      Player player = PlayerModel.fromJson(item);
      players.add(player);
    }
  }
}

class PlayerModel extends Player {
  PlayerModel({
    required this.idPlayer,
    required this.name,
    required this.lastName,
    required this.nickname,
    required this.age,
    required this.height,
    required this.weight,
    required this.phone,
    required this.profession,
    required this.ci,
    required this.image,
    required this.imageFace,
    required this.position,
    required this.active,
  }) : super(
          ci: ci,
          age: age,
          name: name,
          image: image,
          phone: phone,
          height: height,
          active: active,
          weight: weight,
          idPlayer: idPlayer,
          lastName: lastName,
          position: position,
          nickname: nickname,
          imageFace: imageFace,
          profession: profession,
        );

  int idPlayer;
  String name;
  String lastName;
  String nickname;
  int age;
  int height;
  int weight;
  String phone;
  String profession;
  String ci;
  String image;
  String imageFace;
  String position;
  bool active;

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        idPlayer: json["idPlayer"],
        name: json["name"],
        lastName: json["last_name"],
        nickname: json["nickname"] ?? "",
        age: json["age"],
        height: json["height"],
        weight: json["weight"],
        phone: json["phone"] ?? 0,
        profession: json["profession"] ?? "",
        ci: json["ci"],
        image: json["image"] ?? "",
        imageFace: json["image_face"] ?? "",
        position: json["position"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "idPlayer": idPlayer,
        "name": name,
        "last_name": lastName,
        "nickname": nickname,
        "age": age,
        "height": height,
        "weight": weight,
        "phone": phone,
        "profession": profession,
        "ci": ci,
        "image": image,
        "image_face": imageFace,
        "position": position,
        "active": active,
      };

 @override
  String toString() {
    return "idPlayer: $idPlayer \n name: $name  \n lastName: $lastName  \n nickname: $nickname \n age: $age \n height: $height \n weight: $weight \n phone: $phone \n profession: $profession \n ci: $ci \n image: $image \n image_face: $imageFace \n position: $position \n active: $active";
  }
}
