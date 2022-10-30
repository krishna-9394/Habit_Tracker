import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskUI extends StatefulWidget {
  const TaskUI({super.key});

  @override
  State<TaskUI> createState() => _TaskUIState();
}

class _TaskUIState extends State<TaskUI> {
  double percentage = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: ListTile(
          leading: CircularPercentIndicator(
            radius: 30,
            lineWidth: 5.0,
            percent: percentage,
            center: Text("$percentage% "),
            progressColor: Colors.green,
          ),
          title: const Text("Exercise"),
          subtitle: const Text("2:00/10 = 20%"),
          trailing: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              setState(() {
                percentage++;
              });
            },
          ),
        ));
  }
}
