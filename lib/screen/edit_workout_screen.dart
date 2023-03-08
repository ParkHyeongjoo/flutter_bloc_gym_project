import 'package:bloc_gym_project/helper/helpers.dart';
import 'package:bloc_gym_project/model/exercise.dart';
import 'package:bloc_gym_project/screen/edit_exercise_screen.dart';
import 'package:bloc_gym_project/states/workout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/workout_cubit.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state){
            WorkoutEditing we = state as WorkoutEditing;

            return Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  onPressed: (){
                    BlocProvider.of<WorkoutCubit>(context).goHome();
                  },
                ),
              ),
              body: SafeArea(
                child: ListView.builder(
                    itemCount: we.workout!.exercises.length,
                    itemBuilder: (context, index){
                      Exercise exercise = we.workout!.exercises[index];

                      if(we.exIndex == index){
                        return EditExerciseScreen(workout: we.workout, index: index, exIndex: we.exIndex);
                      }else{
                        return ListTile(
                          leading: Text(formatTime(exercise.prelude!, true)),
                          title: Text(exercise.title!),
                          trailing: Text(formatTime(exercise.duration!, true)),
                          onTap: () => BlocProvider.of<WorkoutCubit>(context).editExercise(index),
                        );
                      }
                    },
                ),
              ),
            );
          },
        ),
        onWillPop: () =>
          BlocProvider.of<WorkoutCubit>(context).goHome()
    );
  }
}
