import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xipel/core/utilities/analytics.dart';
import 'package:xipel/features/blocs/pixelate_bloc/pixelate_bloc.dart';
import 'package:xipel/features/widgets/love_button.dart';
import 'package:xipel/features/widgets/love_generator.dart';
import 'package:xipel/features/widgets/love_title.dart';

class LoveGeneratorPage extends StatefulWidget {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  @override
  _LoveGeneratorPageState createState() => _LoveGeneratorPageState();
}

class _LoveGeneratorPageState extends State<LoveGeneratorPage> {
  @override
  void initState() {
    super.initState();
    Analytics.analytics.setCurrentScreen(
      screenName: "love_generator_page",
      screenClassOverride: "LoveGeneratorPage",
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PixelateBloc>(
      create: (_) => PixelateBloc(),
      child: BlocListener<PixelateBloc, PixelateState>(
        listener: (BuildContext context, PixelateState state) {
          if (state is FinishLoading) {
            context.read<PixelateBloc>().add(
                  GetResult(
                    pixelate: state.pixelate,
                    count: state.count,
                  ),
                );
          }
        },
        child: BlocBuilder<PixelateBloc, PixelateState>(
          builder: (BuildContext context, PixelateState state) {
            return Container(
              margin: EdgeInsets.only(
                top: _verticalLayoutPadding(),
              ),
              child: _layoutContent(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                  child: LoveTitle(),
                ),
                pixelate: LoveGenerator(
                  lovePixelate: state.props[0],
                  pixelateBloc: context.read<PixelateBloc>(),
                ),
                button: Container(
                  margin: EdgeInsets.all(10.0),
                  child: _buildButton(context.read<PixelateBloc>(), context),
                ),
                result: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: _buildResult(context.read<PixelateBloc>(), context),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  double _verticalLayoutPadding() {
    if (LoveGeneratorPage.isSmallScreen(context)) {
      return 30.0;
    } else {
      return 60.0;
    }
  }

  Widget _layoutContent({
    Widget title,
    Widget pixelate,
    Widget button,
    Widget result,
  }) {
    if (LoveGeneratorPage.isSmallScreen(context)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title,
          pixelate,
          button,
          result,
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          pixelate,
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                title,
                button,
                result,
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _buildResult(PixelateBloc pixelateBloc, BuildContext context) {
    if (pixelateBloc.state is ShowResult) {
      return RichText(
        text: TextSpan(
          text: "You have ",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "${pixelateBloc.state.props[2]}%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextSpan(text: ' luckiness today'),
          ],
        ),
      );
    } else {
      return Container(
        height: 20,
      );
    }
  }

  Widget _buildButton(PixelateBloc pixelateBloc, BuildContext context) {
    if (pixelateBloc.state is PixelateInitial) {
      return LoveButton(
        text: "Tap!",
        onPressed: () {
          Analytics.analytics.logEvent(name: "randomize_luck");
          context.read<PixelateBloc>().add(
                RandomizePixelate(
                  pixelate: pixelateBloc.state.props[0],
                  count: pixelateBloc.state.props[1],
                ),
              );
        },
      );
    } else {
      return LoveButton(
        text: "Retry",
        onPressed: () {
          Analytics.analytics.logEvent(name: "retry");
          context.read<PixelateBloc>().add(
                BackToInitial(),
              );
        },
      );
    }
  }
}
