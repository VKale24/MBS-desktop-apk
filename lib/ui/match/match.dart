import 'package:fluent_ui/fluent_ui.dart';

import '../../global/color.dart';
import '../../global/network.dart';
import '../../data/model/team_match_model.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key, required this.listTeamMatchs}) : super(key: key);

  final ListTeamMatchs listTeamMatchs;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        
      ),
      content: Container(
        color: ColorApp.colorBlackFont,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LayoutBuilder(builder: ((context, constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight * .2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorApp.colorBlack,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * .2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FittedBox(
                              child: Text(
                                listTeamMatchs.listTeamMatchs[0].teamModel.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            listTeamMatchs.listTeamMatchs[0].teamModel.image ==
                                    "no image"
                                ? Image.asset("assets/images/no image.png")
                                : Image.network(
                                    "${Network.url}/image/${listTeamMatchs.listTeamMatchs[0].teamModel.image}"),
                          ],
                        ),
                        const Text(
                          "VS",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            listTeamMatchs.listTeamMatchs[1].teamModel.image ==
                                    "no image"
                                ? Image.asset("assets/images/no image.png")
                                : Image.network(
                                    "${Network.url}/image/${listTeamMatchs.listTeamMatchs[1].teamModel.image}"),
                            FittedBox(
                              child: Text(
                                  listTeamMatchs
                                      .listTeamMatchs[1].teamModel.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: constraints.maxWidth * .478,
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
                  ),
                ),
              ],
            );
          })),
        ),
      ),
    );
  }
}
