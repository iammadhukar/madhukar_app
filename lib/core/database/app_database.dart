import 'package:floor/floor.dart';
import 'package:madhukar_app/core/database/emp_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

import '../../features/retrieve_employee/data/models/emp_data_model.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [EmpDataModel])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDao get employeeDao;
}
