import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/bloc/current_weather/current_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var name, country, dateTime,image, temp, hum,wind;
  TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  late final Box box;

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('weatherBox');
  }

  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  _addInfo(String name, String country, String dateTime, String image, int temp,
      int humid, int wind) async {
    box.put("name", name);
    box.put("country", country);
    box.put("dateTime", dateTime);
    box.put("image", image);
    box.put("temp", temp);
    box.put("humid", humid);
    box.put("wind", wind);
    print('Info added to box!');
  }

  _getInfo(var key) {
    box.get(key);
  }

  @override
  Widget build(BuildContext context) {
    CurrentBloc _bloc = BlocProvider.of<CurrentBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(6, 13, 38, 1),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  controller: textEditingController,
                  validator: (value) {
                    if (value!.isEmpty) return "Enter city name";
                    if (value.length < 3) {
                      return "Minimum 3 letter";
                    }
                    return null;
                  },
                ),
              ),
              Center(
                child: BlocBuilder<CurrentBloc, CurrentState>(
                    builder: (context, state) {
                  if (state is UpdateState) {
                    _addInfo(
                        state.current.location.name,
                        state.current.location.country,
                        state.current.location.localtime,
                        state.current.current.weatherIcons.first,
                        state.current.current.temperature,
                        state.current.current.humidity,
                        state.current.current.windSpeed);
                    return Column(
                      children: [
                        Container(
                          child: Text(
                            state.current.location.country +
                                ", " +
                                state.current.location.name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                          padding: EdgeInsets.all(25),
                        ),
                        Container(
                          child: Text(
                            state.current.location.localtime.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          child: Image(
                            image: NetworkImage(
                                state.current.current.weatherIcons.first),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        Text(
                          state.current.current.temperature.toString() + " C",
                          style: TextStyle(color: Colors.white, fontSize: 45),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Humidity: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              state.current.current.humidity.toString() + "%",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Wind: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              state.current.current.windSpeed.toString() +
                                  "km/h",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return _getInfo("country")!=null?Column(
                    children: [
                      Container(
                        child: Text(
                           _getInfo("country")+
                              ", " +
                              _getInfo("name"),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                        padding: EdgeInsets.all(25),
                      ),
                      // Container(
                      //   child: Text(
                      //     state.current.location.localtime.toString(),
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      // Container(
                      //   child: Image(
                      //     image: NetworkImage(
                      //         state.current.current.weatherIcons.first),
                      //   ),
                      //   padding: EdgeInsets.all(10),
                      // ),
                      // Text(
                      //   state.current.current.temperature.toString() + " C",
                      //   style: TextStyle(color: Colors.white, fontSize: 45),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       "Humidity: ",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     Text(
                      //       state.current.current.humidity.toString() + "%",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       "Wind: ",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     Text(
                      //       state.current.current.windSpeed.toString() +
                      //           "km/h",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ):Text("Type the city name you want to see");
                }),
              ),
              TextButton(
                onPressed: () async {
                  _bloc.add(UpdateEvent(textEditingController.text));
                },
                child: const Text("Click me"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

saveLocale() {}
