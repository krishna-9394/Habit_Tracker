import 'package:hive/hive.dart';
import 'Habits.g.dart';
@HiveType(typeId: 0)
class Habit extends HiveObject{
  @HiveField(0)
  late String habitName;
  @HiveField(1)
  late DateTime timeStamp;
}
@HiveType(typeId: 1)
class User{

}