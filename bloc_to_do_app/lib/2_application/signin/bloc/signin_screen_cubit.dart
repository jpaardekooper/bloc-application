import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signin_screen_cubit_state.dart';

class SigninScreenCubit extends Cubit<SigninScreenState> {
  SigninScreenCubit() : super(SigninScreenInitial());
}
