import 'package:flutter/material.dart';
import 'package:love_app/blocs/bloc/pixelate_bloc.dart';
import 'package:love_app/widgets/love_pixelate.dart';

class LoveGenerator extends StatefulWidget {
  final List<List<int>> lovePixelate;
  final PixelateBloc pixelateBloc;

  const LoveGenerator(
      {Key key, @required this.lovePixelate, @required this.pixelateBloc})
      : super(key: key);

  @override
  _LoveGeneratorState createState() => _LoveGeneratorState();
}

class _LoveGeneratorState extends State<LoveGenerator> {
  List<List<int>> _lovePixelate;

  @override
  void initState() {
    super.initState();
    _lovePixelate = widget.lovePixelate;
  }

  @override
  void didUpdateWidget(LoveGenerator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pixelateBloc.state is InCountedPixelate) {
      if (widget.lovePixelate != oldWidget.lovePixelate) {
        _lovePixelate = widget.lovePixelate;
        Future.delayed(Duration(milliseconds: 100), () async {
          widget.pixelateBloc.add(
            RandomizePixelate(
              pixelate: widget.pixelateBloc.state.props[0],
              count: widget.pixelateBloc.state.props[1],
            ),
          );
        });
      }
    } else if (widget.pixelateBloc.state is PixelateInitial) {
      _lovePixelate = widget.lovePixelate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: _generateLovePixelate(),
    );
  }

  Color _generateColor(int pixelate) {
    if (pixelate == -1) {
      return Color(0xffff8195);
    } else if (pixelate == -2) {
      return Color(0xffeff2f8);
    } else {
      return HSLColor.fromAHSL(1, pixelate.toDouble(), 1, 0.75).toColor();
    }
  }

  List<Widget> _generateLovePixelate() {
    List<Widget> widgetSet = List<Widget>();
    _lovePixelate.forEach((List<int> pixelateList) {
      List<Widget> rowWidgets = List<Widget>();
      pixelateList.forEach((int pixelate) {
        rowWidgets.add(
          LovePixelate(
            color: _generateColor(pixelate),
          ),
        );
      });
      widgetSet.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowWidgets,
        ),
      );
    });
    return widgetSet;
  }
}
