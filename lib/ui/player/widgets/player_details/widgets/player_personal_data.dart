import 'package:fluent_ui/fluent_ui.dart';
import 'package:desktop_apk/domain/entities/player.dart';

class PlayerPersonalData extends StatelessWidget {
  const PlayerPersonalData({Key? key, required this.player}) : super(key: key);
  final Player player;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Nombre: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: "${player.name} ${player.lastName}")
                ]),
          ),
          const SizedBox(
            height: 5.0,
          ),
          RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Posición: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: player.position)
                ]),
          ),
          const SizedBox(
            height: 5.0,
          ),
          RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Edad: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: "${player.age} años")
                ]),
          ),
          const SizedBox(
            height: 5.0,
          ),
          RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                    text: "CI: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: player.ci.toString())
                ]),
          ),
          const SizedBox(
            height: 5.0,
          ),
          RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Estatura: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: "${player.height} cm")
                ]),
          ),
          const SizedBox(
            height: 5.0,
          ),
          RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Peso: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: "${player.weight} kg")
                ]),
          ),
          const SizedBox(
            height: 5.0,
          ),
          RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Teléfono: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: player.phone)
                ]),
          ),
          const SizedBox(
            height: 5.0,
          ),
          RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Estado: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: player.active ? "Activo" : "Inactivo".toString(),
                    style: TextStyle(
                        color: player.active ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
