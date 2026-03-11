import "package:flutter/material.dart";

const green =  Color.fromARGB(255, 52, 139, 52);
const red = Color.fromARGB(255, 255, 0, 0);

class HealthCircle extends StatelessWidget {

  final double value;
  final double max;
  final double min;
  final String label;
  final IconData icon;

  const HealthCircle({
    super.key,
    required this.min,
    required this.value,
    required this.max,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Stack(
          alignment: Alignment.center,
          children: [

            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: 1,
                strokeWidth: 5,
                strokeCap: StrokeCap.round,
                color: (value>max || value<min)? red:green,
                backgroundColor: Colors.grey.shade300,
              ),
            ),

            Icon(icon, color: red, size: 26),
          ],
        ),

        SizedBox(height: 6),

        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Times New Roman",
            color: red
          ),
        )
      ],
    );
  }
}