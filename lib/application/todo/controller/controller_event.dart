part of 'controller_bloc.dart';

@immutable
abstract class ControllerEvent {}

// 2 events: delete and update todo


class DeleteTodoEvent extends ControllerEvent {
  final Todo todo;
  
  DeleteTodoEvent({required this.todo});
}

class UpdateTodoEvent extends ControllerEvent {
  final Todo todo;
  final bool done;

  UpdateTodoEvent({required this.todo, required this.done});
}
