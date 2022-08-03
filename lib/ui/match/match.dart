import 'package:desktop_apk/common/color.dart';
import 'package:fluent_ui/fluent_ui.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return NavigationView(
      content: Container(
        color: ColorApp.colorBlackFont,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LayoutBuilder(builder: ((context, constraints) {
            return Row(
              children: [
                Container(
                  width: constraints.maxWidth * .5,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0))),
                ),
                Container(
                  width: .5,
                  color: Colors.white,
                ),
                Container(
                    width: constraints.maxWidth * .498,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0)))),
              ],
            );
          })),
        ),
      ),
    );
  }
}
