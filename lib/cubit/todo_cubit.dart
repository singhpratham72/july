import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:july/cubit/todo_state.dart';
import 'package:july/screens/landing_screen.dart';
import 'package:july/models/todo_model.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(LoadedState([]));

  void addItem(ToDo todoItem) {
    try {
      todoList.insert(0, todoItem);
      todoListKey.currentState?.insertItem(0);
      emit(LoadedState(todoList));
    } catch (_) {}
    saveList();
  }

  void addItemToLast(ToDo todoItem) {
    try {
      todoList.add(todoItem);
      todoListKey.currentState?.insertItem(todoList.length - 1);
      emit(LoadedState(todoList));
    } catch (_) {}
    saveList();
  }

  void removeItem(ToDo todoItem) {
    try {
      int index = todoList.indexWhere((item) => item.id == todoItem.id);
      todoListKey.currentState?.removeItem(index, (_, __) => const SizedBox());
      todoList.remove(todoItem);
      emit(LoadedState(todoList));
    } catch (_) {}
    saveList();
  }

  void updateItem(ToDo todoItem, ScrollController scrollController) async {
    if (todoItem.text?.isEmpty ?? true) {
      removeItem(todoItem);
    } else {
      if (todoItem.checked ?? false) {
        removeItem(todoItem);
        addItemToLast(todoItem);
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn);
      } else {
        removeItem(todoItem);
        addItem(todoItem);
        scrollController.animateTo(0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn);
      }
    }
  }

  Future<void> saveList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Encode and store data in SharedPreferences
      final String encodedData = ToDo.encode(todoList);
      await prefs.setString('july', encodedData);
    } catch (_) {}
  }

  Future<void> fetchList() async {
    emit(LoadingState());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Fetch and decode data
      final String todoListString = prefs.getString('july') ?? "";
      final List<ToDo> loadedTodoList = ToDo.decode(todoListString);
      emit(LoadedState(loadedTodoList));
    } catch (_) {
      emit(LoadedState([]));
    }
  }

  List<ToDo> get todoList => (state as LoadedState).todoList;
}
