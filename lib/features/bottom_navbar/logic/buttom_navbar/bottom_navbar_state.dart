part of 'bottom_navbar_cubit.dart';

abstract class BottomNavbarState extends Equatable {
  final int itemIndex;
  const BottomNavbarState(this.itemIndex);

  @override
  List<Object> get props => [];
}

class BottomNavbarHome extends BottomNavbarState {
  const BottomNavbarHome(super.itemIndex);
  @override
  String toString() => 'BottomNavbarHome';
}

class BottomNavbarProfile extends BottomNavbarState {
  const BottomNavbarProfile(super.itemIndex);
  @override
  String toString() => 'BottomNavbarProfile';
}

class BottomNavbarMessage extends BottomNavbarState {
  const BottomNavbarMessage(super.itemIndex);
  @override
  String toString() => 'BottomNavbarMessage';
}

class BottomNavbarSetting extends BottomNavbarState {
  const BottomNavbarSetting(super.itemIndex);
  @override
  String toString() => 'BottomNavbarSetting';
}
