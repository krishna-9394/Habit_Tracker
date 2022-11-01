import 'package:hive/hive.dart';
import 'habit.dart';

class Boxes {
  static Box<Habit> getTransaction() =>
      Hive.box<Habit>('Habits List');
}