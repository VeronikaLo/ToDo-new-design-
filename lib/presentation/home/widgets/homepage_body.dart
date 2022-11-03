import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/home/widgets/todo_card.dart';
import 'package:todo_app/presentation/home/widgets/todo_item.dart';

import '../../../application/todo/observer/observer_bloc.dart';


class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  static const double _spacing = 20;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, state) {
        if(state is ObserverInitial){
          return Container();

        } else if(state is ObserverLoading){
          return Center(child: CircularProgressIndicator(color: themeData.colorScheme.tertiary) ,);

        } else if(state is ObserverFailure){
          return const Center(child: Text('FAILURE'),);

        } else if(state is ObserverSuccess){
          return Padding(
            padding: const EdgeInsets.all(_spacing),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:200, //item can have max 200 width
                crossAxisSpacing:_spacing,
                mainAxisSpacing: _spacing,
                childAspectRatio: 4/5  ),
              itemCount: state.todos.length , 
              itemBuilder: (context, index){
                final todo = state.todos[index];
                return  TodoItem(todo: todo,) ; //TodoCard(todo: todo)
              },),
          );
          
          /*ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index){
              final todo = state.todos[index];
              return TodoCard(todo: todo);
            },
          );*/
        }
        return Container();
      },
    );
  }
}
