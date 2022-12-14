import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/home/widgets/progress_bar.dart';
//import 'package:todo_app/presentation/home/widgets/todo_card.dart';
import 'package:todo_app/presentation/home/widgets/todo_item.dart';
import '../../../application/auth/auth_bloc/auth_bloc.dart';
import '../../../application/todo/observer/observer_bloc.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  static const double _spacing = 20;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, state) {
        if (state is ObserverInitial) {
          return Container();
        } else if (state is ObserverLoading) {
          return Center(
            child: CircularProgressIndicator(
                color: themeData.colorScheme.tertiary),
          );
        } else if (state is ObserverFailure) {
          return const Center(
            child: Text('FAILURE'),
          );
        } else if (state is ObserverSuccess) {
          return SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  collapsedHeight: 70,
                  expandedHeight: 280,
                  backgroundColor: themeData.scaffoldBackgroundColor,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                          'assets/scull.png'), //if image is too big - wrap it with Padding.only bootom..
                      titlePadding: const EdgeInsets.only(left: 20, bottom: 10),
                      title: Row(
                        children: [
                          const Text(
                            'ToDos',
                            textScaleFactor: 1.3,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignOutPressedEvent());
                            },
                            icon: const Icon(Icons.exit_to_app),
                          ),
                        ],
                      )),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(_spacing),
                  sliver: SliverToBoxAdapter(
                    child: ProgressBar(todos: state.todos),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(_spacing),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final todo = state.todos[index];
                        return TodoItem(
                          todo: todo,
                        );
                      },
                      childCount: state.todos.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                200, //item can have max 200 width
                            crossAxisSpacing: _spacing,
                            mainAxisSpacing: _spacing,
                            childAspectRatio: 4 / 5),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}


/*
GridView.builder(
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
                  },)
*/                  