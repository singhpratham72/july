import 'dart:convert';
import 'package:flutter/material.dart';

class ToDo {
  final String id = UniqueKey().toString();
  String? text;
  bool? checked;

  ToDo({this.text, this.checked});

  updateText(String newText) {
    text = newText;
  }

  updateChecked() {
    checked = !(checked ?? false);
  }

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
        text: json['text'] as String?, checked: json['checked'] as bool?);
  }

  static Map<String, dynamic> toMap(ToDo todo) => {
        'id': todo.id,
        'text': todo.text,
        'checked': todo.checked,
      };

  static String encode(List<ToDo> todoList) => json.encode(
        todoList.map<Map<String, dynamic>>((todo) => ToDo.toMap(todo)).toList(),
      );

  static List<ToDo> decode(String todoList) =>
      (json.decode(todoList) as List<dynamic>)
          .map<ToDo>((todo) => ToDo.fromJson(todo))
          .toList();
}
