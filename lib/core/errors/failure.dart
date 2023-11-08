import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);
}

class ServerFaliure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CacheFaliure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
