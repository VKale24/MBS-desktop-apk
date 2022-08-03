import 'package:fluent_ui/fluent_ui.dart';

class Prueba extends StatelessWidget {
  const Prueba({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationView(
        content: ListView(
      controller: ScrollController(),
      scrollDirection: Axis.horizontal,
      children: [
        Container(
            height: 100,
            width: 400,
            color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 10)),
        Container(
            height: 100,
            width: 400,
            color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 10)),
        Container(
            height: 100,
            width: 400,
            color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 10)),
        Container(
            height: 100,
            width: 400,
            color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 10)),
      ],
    ));
  }
}
