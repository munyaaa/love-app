part of 'pixelate_bloc.dart';

@immutable
abstract class PixelateState extends Equatable {}

class PixelateInitial extends PixelateState {
  final List<List<int>> pixelate;
  final int count;

  PixelateInitial({
    @required this.pixelate,
    @required this.count,
  });

  @override
  List<Object> get props => [pixelate, count];
}

class InCountedPixelate extends PixelateState {
  final List<List<int>> pixelate;
  final int count;

  InCountedPixelate({
    @required this.pixelate,
    @required this.count,
  });

  @override
  List<Object> get props => [pixelate, count];
}

class FinishLoading extends PixelateState {
  final List<List<int>> pixelate;
  final int count;

  FinishLoading({
    @required this.pixelate,
    @required this.count,
  });

  @override
  List<Object> get props => [pixelate, count];
}

class ShowResult extends PixelateState {
  final List<List<int>> pixelate;
  final int count;
  final int result;

  ShowResult({
    @required this.pixelate,
    @required this.count,
    @required this.result,
  });
  @override
  List<Object> get props => [pixelate, count, result];
}
