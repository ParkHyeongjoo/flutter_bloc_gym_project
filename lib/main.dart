import 'package:bloc_gym_project/bloc/workout_cubit.dart';
import 'package:bloc_gym_project/screen/home_page_screen.dart';
import 'package:bloc_gym_project/states/workout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/workouts_cubit.dart';
import 'model/workout.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Workouts",
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color.fromARGB(255, 66, 74, 96)),
        )
      ),
      home: const WorkoutTime(),
    )
  );
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*BlocProvider<WorkoutsCubit>(
      create: (BuildContext context) {
        WorkoutsCubit workoutsCubit = WorkoutsCubit();
        if(workoutsCubit.state.isEmpty){
          print("...loading json since the state is empty");
          workoutsCubit.getWorkout();
        }else{
          print("...the state is not empty...");
        }
        return workoutsCubit;
      },
      child: BlocBuilder<WorkoutsCubit, List<Workout>>(
        builder: (context, state){
          return const HomePageScreen();
        }
      )
    );*/
      MultiBlocProvider(
          providers: [
            BlocProvider<WorkoutsCubit>(
                create: (BuildContext context) {
                  WorkoutsCubit workoutsCubit = WorkoutsCubit();
                  if(workoutsCubit.state.isEmpty){
                    print("...loading json since the state is empty");
                    workoutsCubit.getWorkout();
                  }else{
                    print("...the state is not empty...");
                  }
                  return workoutsCubit;
                }),
            BlocProvider<WorkoutCubit>(
                create: (BuildContext context) => WorkoutCubit()
            ),
          ],
          child: BlocBuilder<WorkoutCubit, WorkoutState>(
            builder: (context, state) {
              print("...point1...");
              if(state is WorkoutInitial){
                print("...point2...");
                return const HomePageScreen();
              }else if(state is WorkoutEditing){
                print("...point3..."); // TODO 2:11:40
                return Container();
              }
              print("...point4...");
              return Container();
            },
          )
      );
  }
}

