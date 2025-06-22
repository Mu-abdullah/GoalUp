import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'coach_home_state.dart';

class CoachHomeCubit extends Cubit<CoachHomeState> {
  CoachHomeCubit() : super(CoachHomeInitial());
}
