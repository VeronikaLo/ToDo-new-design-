import 'package:flutter/material.dart';
import 'package:todo_app/presentation/home/widgets/progress_bar_painter.dart';
import '../../../domain/entities/todo.dart';

class ProgressBar extends StatelessWidget {
  final List<Todo> todos;
  const ProgressBar({super.key, required this.todos});

  // function to get the percent of done todos
  double getDoneTodosPercentage({required List<Todo> todos}) {
    int done = 0;

    for (var todo in todos) {
      if (todo.done) {
        done++;
      }
    }

    double percent = (1 / todos.length) * done;
    return percent;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Todos progress',
              style: Theme.of(context).textTheme.headline1,
            ),
            Expanded(child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: CustomPaint(
                    painter: ProgressPainter(
                        donePercent: getDoneTodosPercentage(todos: todos),
                        bgColor: const Color.fromARGB(255, 232, 209, 209),
                        percentageColor: Colors.pink,
                        barWidth: constraints.maxWidth,
                        barHeight: 25)),
              );
            }))
          ]),
        ),
      ),
    );
  }
}
