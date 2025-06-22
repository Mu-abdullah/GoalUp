import 'package:flutter_bloc/flutter_bloc.dart';

class GenericItemsCubit<T> extends Cubit<List<T>> {
  GenericItemsCubit(super.initialItems);

  void addItem(T newItem) {
    emit([...state, newItem]);
  }

  void updateItem(int index, T updatedItem) {
    final updatedList = List<T>.from(state);
    updatedList[index] = updatedItem;
    emit(updatedList);
  }

  void removeItem(int index) {
    final updatedList = List<T>.from(state);
    updatedList.removeAt(index);
    emit(updatedList);
  }

  //get list of items
  List<T> getItems() {
    return state;
  }
}
