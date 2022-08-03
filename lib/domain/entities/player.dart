import 'package:desktop_apk/data/model/player_model.dart';

class Player {
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

  Player({
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
  });

  PlayerModel copyWithPlayer({
    name,
    lastName,
    nickname,
    age,
    height,
    weight,
    phone,
    email,
    profession,
    ci,
    image,
    imageFace,
    position,
    active,
  }) =>
      PlayerModel(
          idPlayer: idPlayer,
          name: name == "" ? this.name : name,
          lastName: lastName == "" ? this.lastName : lastName,
          nickname: nickname == "" ? this.nickname : nickname,
          age: age == 0 ? this.age : age,
          height: height == 0 ? this.height : height,
          weight: weight == 0 ? this.weight : weight,
          phone: phone == 0 ? this.phone : phone,
          profession: profession == "" ? this.profession : profession,
          ci: ci == "" ? this.ci : ci,
          image: image == "" ? this.image : image,
          imageFace: imageFace == "" ? this.imageFace : imageFace,
          position: position == "" ? this.position : position,
          active: active == "" ? this.active : active);
}
