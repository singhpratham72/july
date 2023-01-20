import 'package:july/models/todo_model.dart';

abstract class TodoState {}

class InitialState extends TodoState {
  List<Object> get props => [];
}

class LoadingState extends TodoState {
  List<Object> get props => [];
}

class LoadedState extends TodoState {
  LoadedState(this.todoList);
  final List<ToDo> todoList;
  List<Object> get props => todoList;
}

class ErrorState extends TodoState {
  List<Object> get props => [];
}
