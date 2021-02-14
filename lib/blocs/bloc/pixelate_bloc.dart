import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'pixelate_event.dart';
part 'pixelate_state.dart';

class PixelateBloc extends Bloc<PixelateEvent, PixelateState> {
  PixelateBloc()
      : super(PixelateInitial(
          pixelate: initializePixelate,
          count: 0,
        ));

  static List<List<int>> initializePixelate = [
    [-2, -2, -2, -2, -2, -2, -2, -2, -2],
    [-2, -2, -1, -1, -2, -1, -1, -2, -2],
    [-2, -1, -1, -1, -1, -1, -1, -1, -2],
    [-2, -1, -1, -1, -1, -1, -1, -1, -2],
    [-2, -2, -1, -1, -1, -1, -1, -2, -2],
    [-2, -2, -2, -1, -1, -1, -2, -2, -2],
    [-2, -2, -2, -2, -1, -2, -2, -2, -2],
    [-2, -2, -2, -2, -2, -2, -2, -2, -2],
  ];

  @override
  Stream<PixelateState> mapEventToState(
    PixelateEvent event,
  ) async* {
    if (event is RandomizePixelate) {
      List<List<int>> pixelates = event.pixelate;
      List<List<int>> newPixelates = List<List<int>>();
      pixelates.forEach((List<int> pixelate) {
        List<int> pixelTemp = List<int>();
        pixelate.forEach((int pixel) {
          if (pixel == -2) {
            pixelTemp.add(pixel);
          } else {
            pixelTemp.add(Random().nextInt(360));
          }
        });
        newPixelates.add(pixelTemp);
      });
      if(event.count > 20) 
        yield FinishLoading(pixelate: pixelates, count: 0);
      else
        yield InCountedPixelate(pixelate: newPixelates, count: event.count + 1);
    } else if(event is GetResult) {
      final int result = Random().nextInt(100) + 1;
      yield ShowResult(pixelate: event.pixelate, count: 0, result: result);
    } else {
      yield PixelateInitial(pixelate: initializePixelate, count: 0);
    }
  }
}
