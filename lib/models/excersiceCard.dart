
import 'package:flutter/material.dart' ;
const red =  Color.fromARGB(255, 200, 92, 92);

class ExerciseCard extends StatelessWidget {
  final String title;

  const ExerciseCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: red),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Times New Roman",color: red,fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}



