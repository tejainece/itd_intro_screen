library itd.flutter.intro_screen;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:itd_flutter_indicator/itd_flutter_indicator.dart';

/// Widget to display a single introduction page
class IntroPageWidget extends StatelessWidget {
  /// Data for the introduction page
  final IntroData data;

  /// Background color of the smoke screen between the image and the text
  final Color smokeScreenColor;

  /// Text color of title
  final Color titleColor;

  /// Text color of message
  final Color messageColor;

  const IntroPageWidget(this.data,
      {this.smokeScreenColor: const Color.fromRGBO(0, 0, 0, 0.3),
      this.titleColor: const Color(0xFFFFFFFF),
      this.messageColor: const Color(0xFFFFFFFF)});

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
          width: double.INFINITY,
          height: double.INFINITY,
          child: new Image.asset(data.image, fit: BoxFit.cover),
        ),
        new Container(color: smokeScreenColor),
        new Positioned(
          top: 45.0,
          left: 5.0,
          right: 5.0,
          child: new Text(
            data.title,
            textAlign: TextAlign.center,
            style: new TextStyle(color: titleColor, fontSize: 28.0),
          ),
        ),
        new Positioned(
          bottom: 60.0,
          left: 5.0,
          right: 5.0,
          child: new Text(
            data.message,
            textAlign: TextAlign.center,
            style: new TextStyle(color: messageColor, fontSize: 14.0),
          ),
        )
      ],
    );
  }
}

/// Data for an introduction page
class IntroData {
  final String title;

  final String message;

  final String image;

  const IntroData(this.title, this.message, this.image);
}

/// Widget to display a set of introduction pages with page indicator
class IntroWidget extends StatefulWidget {
  /// Set of introduction pages
  final List<IntroData> pages;

  /// Background color of the smoke screen between the image and the text
  final Color smokeScreenColor;

  /// Text color of title
  final Color titleColor;

  /// Text color of message
  final Color messageColor;

  /// Color of the dot, if it is displayed
  final Color indicatorInnerColor;

  /// Color of the outer circle
  final Color indicatorOuterColor;

  IntroWidget(this.pages,
      {this.smokeScreenColor: const Color.fromRGBO(0, 0, 0, 0.3),
      this.titleColor: const Color(0xFFFFFFFF),
      this.messageColor: const Color(0xFFFFFFFF),
      this.indicatorInnerColor: const Color(0xFFAAAAAA),
      this.indicatorOuterColor: const Color(0xFF008000)});

  _State createState() => new _State();
}

class _State extends State<IntroWidget> {
  List<IntroData> get pages => widget.pages;

  int _page = 0;

  Timer _timer;

  _State();

  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(new Duration(seconds: 10), (_) {
      setState(() {
        _page++;
        _page = _page % pages.length;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer is Timer) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(children: <Widget>[
      new IntroPageWidget(pages[_page],
          smokeScreenColor: widget.smokeScreenColor,
          titleColor: widget.titleColor,
          messageColor: widget.messageColor),
      new Positioned(
        bottom: 25.0,
        left: 0.0,
        right: 0.0,
        child: new Center(
            child: new IndicatorWidget(
          pages.length,
          _page,
          innerColor: widget.indicatorInnerColor,
          outerColor: widget.indicatorOuterColor,
        )),
      )
    ]);
  }
}
