import 'package:fluent_ui/fluent_ui.dart';

class ConfirmAction extends StatelessWidget {
  const ConfirmAction(
      {Key? key,
      required this.title,
      required this.callbackTrue,
      required this.callbackFalse})
      : super(key: key);

  final String title;

  final Function() callbackTrue;
  final Function() callbackFalse;

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      // title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListBody(
          children: <Widget>[
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
      actions: <Widget>[
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
                          color: Colors.black, fontWeight: FontWeight.w800)),
                ),
              ),
            ),
          ),
          onTap: () {
            callbackFalse();
          },
        ),
        GestureDetector(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("Aceptar",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            onTap: () {
              callbackTrue();
            })
      ],
    );
  }
}

class MessageAlertDialog extends StatelessWidget {
  const MessageAlertDialog({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      // title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      actions: <Widget>[
        GestureDetector(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Aceptar",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              //callback();
            })
      ],
    );
  }
}
