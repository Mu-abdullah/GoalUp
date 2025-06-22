import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/coach_bottom_navigation.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit(this.isAdmin) : super(BottomBarInitial());
  static BottomBarCubit get(context) => BlocProvider.of(context);

  final bool isAdmin;

  ///[When use bottom navigation bar]
  int currentIndex = 0;
  var titles = CoachBottomNavigation.titles;
  var pages = CoachBottomNavigation.itemsBody;
  void onTabTapped(int index) {
    currentIndex = index;
    emit(BottomBarTapped());
  }
}
