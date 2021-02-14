part of 'pixelate_bloc.dart';

@immutable
abstract class PixelateEvent {}

class RandomizePixelate extends PixelateEvent {
  final List<List<int>> pixelate;
  final int count;

  RandomizePixelate({@required this.pixelate, @required this.count});
}

class GetResult extends PixelateEvent {
  final List<List<int>> pixelate;
  final int count;

  GetResult({@required this.pixelate, @required this.count});
}

class BackToInitial extends PixelateEvent {}