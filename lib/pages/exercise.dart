import 'package:care/models/health.dart';
import 'package:care/service/dailyStats.dart';
import 'package:flutter/material.dart';

const Color dRed = Color.fromARGB(255, 199, 33, 33);
const Color red = Color.fromARGB(255, 200, 92, 92);
final ValueNotifier<int> reps = ValueNotifier(0);
final ValueNotifier<bool> isRunning = ValueNotifier(false);
const String font = 'Times New Roman';
const TextStyle body = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontFamily: font
);
const TextStyle textstyle = TextStyle(
  color: dRed,
  fontWeight: FontWeight.bold,
  fontFamily: font,
);

class exercisePage extends StatelessWidget {

  final Map<String, dynamic> data;

  exercisePage({super.key, required this.data}) {
    loadStats();
  }

  Future<void> loadStats() async {
    int count = await DailyStatsService().getTodayStats(data['id']);
    reps.value = count;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: dRed,
          ),
        ),
        title: Text(
          data['name'],
          style: textstyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0,top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['description'],style: body,),Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Text(
                "Recommended: ${data['recommendedSets']} sets × ${data['recommendedReps']} reps",
                style: body,
              ),
            ),
ValueListenableBuilder(
  valueListenable: reps,
  builder: (context, value, child) {
    return Column(
      children: [
                const SizedBox(height: 50),
          //      Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          // children: [
          //   Text(
          //     value.toString(),
          //     style: const TextStyle(
          //       fontSize: 32,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ],),

        const SizedBox(height: 40),

        ValueListenableBuilder(
          valueListenable: isRunning,
          builder: (context, running, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                iconAlignment: IconAlignment.end,
                backgroundColor: running? dRed : green,
                shape: CircleBorder(),
                padding: const EdgeInsets.all(90
                ),
              ),
              onPressed: ()async {
                  // if (running) {
                  //   await DailyStatsService().updateStatsCount(
                  //     data['id'], 
                  //     reps.value,
                  //   );
                  // }
                isRunning.value = !running;
              },
              child: Text(
                running ? "STOP EXERCISE" : "START EXERCISE",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 30),
        
      ],
    );
  },
)
          ],
        ),
      ),
    );
  }
}