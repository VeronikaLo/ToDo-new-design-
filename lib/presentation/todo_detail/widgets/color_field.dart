import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/todo_color.dart';

import '../../../application/todo/todoform/todoform_bloc.dart';

class ColorField extends StatelessWidget {
  final TodoColor color;
  const ColorField({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index){
          final itemColor = TodoColor.predefinedColors[index];

          return InkWell(
            onTap: (){
              BlocProvider.of<TodoformBloc>(context).add(ColorChangedEvent(color: itemColor));
            },
            child: Material(
              color: itemColor,
              elevation: 10,
              shape: CircleBorder(
                side: BorderSide(
                  width: 2,
                  color: itemColor == color.color
                  ? Colors.white 
                  : Colors.black,)),
              child: const SizedBox(width: 50, height: 50,),
            ),
          );
        }, 
        separatorBuilder: (context, index) => const SizedBox(width: 10), 
        itemCount: TodoColor.predefinedColors.length),
    );
  }
}