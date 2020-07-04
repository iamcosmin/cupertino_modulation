library cupertino_modulation;
import 'package:flutter/cupertino.dart';

class UITrailingController extends StatefulWidget {
  // UITrailingController makes managing the trailing in CupertinoNavigationBar much easier and more freely.
  // UITrailingController takes 3 arguments: showLoading, onPress and a title.

  UITrailingController({
    @required this.title,
    @required this.needsProgress,
    @required this.onPress,
    @required this.textColor,
  });
  final Color textColor;
  final String title;
  final bool needsProgress;
  final Function onPress;

  @override
  _UITrailingControllerState createState() => _UITrailingControllerState();
}

class _UITrailingControllerState extends State<UITrailingController> {
  bool loading = false;
  // This function takes care of starting and stopping the loading when the action is done.
  bool isDown;

  @override
  void initState() {
    super.initState();
    setState(() => isDown = false);
  }
  needsProgressFunction() async {
    setState(() {
      loading = true;
    });
    widget.onPress();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (loading != true)
          GestureDetector(
            onTap: widget.needsProgress != true ? widget.onPress : needsProgressFunction,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 50),
              opacity: isDown ? 0.5 : 1,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ) else if (loading == true)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: const CupertinoActivityIndicator(),
            )
      ],
    );
  }
}
