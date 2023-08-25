part of 'navigation_cubit.dart';

class NavigationCubitState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? isSecondBodyDisplayed;

  const NavigationCubitState({
    this.selectedCollectionId,
    this.isSecondBodyDisplayed,
  });

  @override
  List<Object?> get props => [selectedCollectionId, isSecondBodyDisplayed];
}
