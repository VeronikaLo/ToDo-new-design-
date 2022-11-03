import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

import '../../../core/failures/todo_failures.dart';
import '../../../domain/entities/todo.dart';
import '../../../domain/entities/todo_color.dart';

part 'todoform_event.dart';
part 'todoform_state.dart';

class TodoformBloc extends Bloc<TodoformEvent, TodoformState> {
  final TodoRepository todoRepository;
  TodoformBloc({required this.todoRepository}) : super(TodoformState.initial()) {
 
    on<InitializeTodoDetailPage>((event, emit) {
      //if we have a todo --> editing true, if not --> take params from initialstate
      if (event.todo != null) {
        emit(state.copyWith(todo: event.todo, isEditing: true));
      } else {
        emit(state);
      }
    });


    on<ColorChangedEvent>((event, emit) {
      emit(state.copyWith(
          todo: state.todo.copyWith(color: TodoColor(color: event.color))));
    });

    on<SavePressedEvent>((event, emit) async {
      Either<TodoFailure, Unit>? failureOrSuccess;

      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

      if (event.title != null && event.body != null) {
        final Todo editedTodo =
            state.todo.copyWith(title: event.title, body: event.body);

        if (state.isEditing) {
          failureOrSuccess = await todoRepository.update(editedTodo);
        } else {
          failureOrSuccess = await todoRepository.create(editedTodo);
        }
      }

      emit(state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          failureOrSuccessOption: optionOf(failureOrSuccess)));
    });
  


  }
}
