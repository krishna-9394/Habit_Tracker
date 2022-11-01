import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskUI extends StatefulWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingTap;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;
  TaskUI(
      {super.key,
      required this.habitName,
      required this.onTap,
      required this.settingTap,
      required this.timeSpent,
      required this.timeGoal,
      required this.habitStarted});
  @override
  State<TaskUI> createState() => _TaskUIState();
}

class _TaskUIState extends State<TaskUI> {
  // method to convert seconds to min:sec
  String convertTime(int time){
    int sec = time%60;
    double min = time/60;
    return " ${min.round()}:$sec ";
  }
  late double percentage; 
  @override
  Widget build(BuildContext context) {
    percentage =  (widget.timeSpent/widget.timeGoal);
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Card(
        color: Colors.grey[250],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 10,
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onTap,
                  child: SizedBox(
                      width: 60,
                      child: Stack(children: [
                        CircularPercentIndicator(
                          radius: 32,
                          lineWidth: 5.0,
                          percent: percentage < 1 ? percentage : 1,
                          progressColor: percentage > 0.35 ? (percentage > 0.75 ? Colors.green : Colors.orange) : Colors.red,
                          center: widget.habitStarted
                              ? const Icon(
                                  Icons.pause,
                                  size: 26,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.play_arrow,
                                  size: 26,
                                  color: Colors.black,
                                ),
                        ),
                      ])),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.habitName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                      const SizedBox(height: 4,),
                      Text("${convertTime(widget.timeSpent)}/${convertTime(widget.timeGoal)} = ${double.parse((percentage*100).toStringAsFixed(1))}"),
                      // ${double.parse((().toStringAsFixed(0))}%
                      ]
                        ),
                const SizedBox(width: 60),
                GestureDetector(
                  onTap: widget.settingTap,
                  child: const Icon(Icons.settings)),
              ],
                )
            )
      ),
    );
  }
}
