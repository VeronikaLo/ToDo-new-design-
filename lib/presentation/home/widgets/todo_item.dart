import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/todo/controller/controller_bloc.dart';
import '../../../domain/entities/todo.dart';
import '../../routes/router.gr.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  void _showDeleteDialog(
      {required BuildContext context, required ControllerBloc bloc}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Selected Todo to delete:"),
            content: Text(
              todo.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "CANCLE",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {
                    bloc.add(DeleteTodoEvent(todo: todo));
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "DELETE",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: () {
        AutoRouter.of(context).push(TodoDetailRoute(todo: todo));
      },
      onLongPress: () {
        final controllerBloc = context.read<ControllerBloc>();
        _showDeleteDialog(context: context, bloc: controllerBloc);
      },
      child: Material(
        elevation: 18,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: todo.color.color,
            borderRadius: BorderRadius.circular(20),
      ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                todo.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: themeData.textTheme.headline1!.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 15,),
              Text(
                todo.body,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: themeData.textTheme.bodyText1!.copyWith(fontSize: 16, fontStyle:FontStyle.italic ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        shape: const CircleBorder(),
                        activeColor: Colors.white,
                        checkColor: themeData.backgroundColor,
                        value: todo.done,
                        onChanged: (value){
                            if (value != null) {
                              BlocProvider.of<ControllerBloc>(context)
                               .add(UpdateTodoEvent(todo: todo, done: value));
                              }
                          }, ),
                    ),
                  ),
                  ],
              )
            ]),
        ),
      ),
    );
  }
}