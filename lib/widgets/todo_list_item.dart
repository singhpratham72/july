import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:july/constants/colors.dart';
import 'package:july/cubit/todo_cubit.dart';
import 'package:july/models/todo_model.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem(
      {Key? key, required this.todo, required this.scrollController})
      : super(key: key);

  final ToDo todo;
  final ScrollController scrollController;

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  TextEditingController? _controller;
  TodoCubit? todoListProvider;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.todo.text);
    todoListProvider = BlocProvider.of<TodoCubit>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.0,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: ApplicationColors.white,
          borderRadius: BorderRadius.circular(12.0)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              setState(() {
                if ((_controller?.text ?? "") != widget.todo.text) {
                  widget.todo.updateText(_controller?.text ?? "");
                }
                widget.todo.updateChecked();
              });
              await Future.delayed(const Duration(milliseconds: 200));
              todoListProvider?.updateItem(
                  widget.todo, widget.scrollController);
            },
            child: AnimatedContainer(
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 100),
                height: 18.0,
                width: 18.0,
                decoration: BoxDecoration(
                    color: (widget.todo.checked ?? false)
                        ? ApplicationColors.black
                        : ApplicationColors.darkGrey,
                    borderRadius: BorderRadius.circular(4.0)),
                child: (widget.todo.checked ?? false)
                    ? const Icon(
                        Icons.check_rounded,
                        color: ApplicationColors.white,
                        size: 14.0,
                      )
                    : const SizedBox.shrink()),
          ),
          const SizedBox(width: 8.0),
          Expanded(
              child: TextField(
                  controller: _controller,
                  readOnly: widget.todo.checked ?? false,
                  onSubmitted: (value) async {
                    setState(() {
                      widget.todo.updateText(value);
                    });
                    await Future.delayed(const Duration(milliseconds: 300));
                    todoListProvider?.updateItem(
                        widget.todo, widget.scrollController);
                  },
                  style: TextStyle(
                      decoration: (widget.todo.checked ?? false)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                  decoration: const InputDecoration.collapsed(hintText: ""))),
        ],
      ),
    );
  }
}
