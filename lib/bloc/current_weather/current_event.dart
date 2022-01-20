part of 'current_bloc.dart';

@immutable
abstract class CurrentEvent {}

class UpdateEvent extends CurrentEvent{
  final String cityName;

  UpdateEvent(this.cityName);
}
