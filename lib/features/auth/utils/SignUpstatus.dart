import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikos/features/auth/data/models/User.dart';

class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {}

class None extends SignUpState {}

class SignUpDone extends SignUpState {
  final UserModel user;

  SignUpDone({@required this.user});

  @override
  List<Object> get props => [user];
}

class SignUpFailure extends SignUpState {
  final String message;
  final int err;
  SignUpFailure({
    @required this.message,
    this.err,
  });

  @override
  List<Object> get props => [message];
}
