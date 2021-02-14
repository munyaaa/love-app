import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:love_app/blocs/bloc/pixelate_bloc.dart';
import 'package:love_app/widgets/love_generator.dart';

// class LoveGeneratorPage extends StatefulWidget {
//   @override
//   _LoveGeneratorPageState createState() => _LoveGeneratorPageState();
// }

class LoveGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PixelateBloc>(
      create: (_) => PixelateBloc(),
      child: BlocListener<PixelateBloc, PixelateState>(
        listener: (BuildContext context, PixelateState state) {
          if (state is FinishLoading) {
            context.read<PixelateBloc>().add(GetResult(
                  pixelate: state.pixelate,
                  count: state.count,
                ));
          }
        },
        child: BlocBuilder<PixelateBloc, PixelateState>(
          builder: (BuildContext context, PixelateState state) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "How lucky is your love life?",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  // LoveGenerator(
                  //   lovePixelate: state.props[0],
                  // lovePixelate: [
                  //   [0, 0, 0, 0, 0, 0, 0, 0, 0],
                  //   [0, 0, 1, 1, 0, 1, 1, 0, 0],
                  //   [0, 1, 1, 1, 1, 1, 1, 1, 0],
                  //   [0, 1, 1, 1, 1, 1, 1, 1, 0],
                  //   [0, 0, 1, 1, 1, 1, 1, 0, 0],
                  //   [0, 0, 0, 1, 1, 1, 0, 0, 0],
                  //   [0, 0, 0, 0, 1, 0, 0, 0, 0],
                  //   [0, 0, 0, 0, 0, 0, 0, 0, 0],
                  // ],
                  // ),
                  LoveGenerator(
                    lovePixelate: state.props[0],
                    pixelateBloc: context.read<PixelateBloc>(),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: _buildButton(context.read<PixelateBloc>(), context),
                  ),
                  _buildResult(context.read<PixelateBloc>(), context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResult(PixelateBloc pixelateBloc, BuildContext context) {
    if (pixelateBloc.state is ShowResult) {
      return Container(
        child: Text(
          "Your have ${pixelateBloc.state.props[2]}% luckiness today",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildButton(PixelateBloc pixelateBloc, BuildContext context) {
    if (pixelateBloc.state is PixelateInitial) {
      return Container(
        margin: EdgeInsets.all(10.0),
        child: RaisedButton(
          onPressed: () {
            context.read<PixelateBloc>().add(
                  RandomizePixelate(
                    pixelate: pixelateBloc.state.props[0],
                    count: pixelateBloc.state.props[1],
                  ),
                );
          },
          child: Text(
            "Tap!",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          color: Colors.pink,
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                context.read<PixelateBloc>().add(
                      RandomizePixelate(
                        pixelate: pixelateBloc.state.props[0],
                        count: pixelateBloc.state.props[1],
                      ),
                    );
              },
              child: Text(
                "Tap!",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              color: Colors.pink,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                context.read<PixelateBloc>().add(
                      BackToInitial(),
                    );
              },
              child: Text(
                "Retry!",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              color: Colors.pink,
            ),
          ),
        ],
      );
    }
  }
}
