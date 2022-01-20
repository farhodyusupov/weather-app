
part of 'current_bloc.dart';


@immutable
abstract class CurrentState {}

class CurrentInitial extends CurrentState {}

class UpdateState extends CurrentState{
   final   Current current;


  int a=10;

  UpdateState(this.current);


}


