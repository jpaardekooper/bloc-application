import 'package:bloc_to_do_app/1_domain/entities/unique_id.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_cubit_state.dart';

class NavigationCubit extends Cubit<NavigationCubitState> {
  NavigationCubit() : super(const NavigationCubitState());

  void selectedToDoCollectionChanged(CollectionId collectionId) {
    emit(NavigationCubitState(selectedCollectionId: collectionId));
  }

  void secondBodyHasChanged({required bool isSecondBodyDisplayed}) {
    if (state.isSecondBodyDisplayed != isSecondBodyDisplayed) {
      emit(NavigationCubitState(
        selectedCollectionId: state.selectedCollectionId,
        isSecondBodyDisplayed: isSecondBodyDisplayed,
      ));
    }
  }
}
