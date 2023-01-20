import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:july/cubit/todo_cubit.dart';
import 'package:july/cubit/todo_state.dart';
import 'package:july/models/todo_model.dart';
import '../widgets/greeting_text.dart';
import '../widgets/new_task_container.dart';
import '../widgets/new_task_textfield.dart';
import '../widgets/todo_list_item.dart';

final todoListKey = GlobalKey<AnimatedListState>();

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();
  TodoCubit? todoListProvider;
  bool _editable = false;
  @override
  void initState() {
    todoListProvider = BlocProvider.of<TodoCubit>(context, listen: false);
    todoListProvider?.fetchList();
    super.initState();
  }

  @override
  void dispose() {
    todoListProvider?.saveList();
    todoListProvider?.close();
    _scrollController.dispose();
    super.dispose();
  }

  switchNewTaskWidget(bool edit) {
    setState(() {
      _editable = edit;
    });
  }

  addTodoItem(String text) {
    if (text.isNotEmpty) {
      ToDo todoItem = ToDo(text: text, checked: false);
      todoListProvider?.addItem(todoItem);
    }
    switchNewTaskWidget(false);
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              if (state is LoadedState) {
                List<ToDo> todoList = state.todoList;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GreetingText(scrollController: _scrollController),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: _editable
                            ? NewTaskTextField(
                                callback: addTodoItem,
                              )
                            : NewTaskContainer(callback: switchNewTaskWidget),
                      ),
                      Expanded(
                        child: AnimatedList(
                          controller: _scrollController,
                          shrinkWrap: true,
                          initialItemCount: todoList.length,
                          itemBuilder: (context, index, animation) {
                            return Dismissible(
                              key: Key(todoList[index].id),
                              onDismissed: (_) {
                                todoListProvider?.removeItem(todoList[index]);
                              },
                              child: TodoListItem(
                                todo: todoList[index],
                                key: Key(todoList[index].id),
                                scrollController: _scrollController,
                              ),
                            );
                          },
                          key: todoListKey,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ));
  }
}
