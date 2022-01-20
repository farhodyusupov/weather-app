
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/service/current_service.dart';

part 'current_event.dart';
part 'current_state.dart';

class CurrentBloc extends Bloc<CurrentEvent, CurrentState> {
  CurrentBloc() : super(CurrentInitial()) {
    on<UpdateEvent>((event, emit)  async {
      CurrentDio _currentDio = CurrentDio();
      Current current;
      current = await _currentDio.getCurrentData(event.cityName);


       emit(UpdateState(current));
    });

  }
}
