import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:studenthub/models/task.dart';
import 'package:studenthub/data/dummy_data.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super(listTask);

  bool createNewTask(Task task) {
    if (state.isNotEmpty) {
      final listTaskExist = state.where((t) => t.id == task.id);
      if (listTaskExist.isEmpty) {
        state = [...state, task];
      }
    }
    return true;
  }

  bool changeListTasks(List<Task> listTask) {
    state = [...listTask];
    return true;
  }

  bool markTaskCompleted(String id) {
    if (state.isNotEmpty) {
      state[state.indexWhere((element) => element.id == id)].isCompleted = true;
      final temp = state[state.indexWhere((element) => element.id == id)];
      state = state.where((t) => t.id != id).toList();
      state = [...state, temp];
    }
    return false;
  }

  bool deleteTask(String id) {
    if (state.isNotEmpty) {
      state = state.where((t) => t.id != id).toList();
      return true;
    }
    return false;
  }
}

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
