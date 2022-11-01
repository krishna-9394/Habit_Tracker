import 'package:hive/hive.dart';
part 'habit.g.dart';
@HiveType(typeId: 0)
class Habit extends HiveObject{
  @HiveField(0)
  late String habitName;
  @HiveField(1)
  late int timeSpent;
  @HiveField(2)
  late int goalTime;
  @HiveField(3)
  late bool hasStarted;

}