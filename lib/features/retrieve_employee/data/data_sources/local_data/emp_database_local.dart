import 'package:madhukar_app/features/retrieve_employee/data/models/emp_data_model.dart';

import '../../../../../core/database/app_database.dart';

class EmpDatabaseLocal {
  Future<List<EmpDataModel>> getAllEmployeeLocal(
      AppDatabase localDatabase) async {
    List<EmpDataModel> data = await localDatabase.employeeDao.getEmployeeData();
    return data;
  }

  Future<void> saveEmployee(
      EmpDataModel employee, AppDatabase localDatabase) async {
    await localDatabase.employeeDao.addEmployee(employee);
  }

  Future<void> deleteEmployee(
      EmpDataModel employee, AppDatabase localDatabase) async {
    await localDatabase.employeeDao.deleteEmployee(employee);
  }

  Future<void> editEmployee(
      EmpDataModel employee, AppDatabase localDatabase) async {
    await localDatabase.employeeDao.editEmployee(employee);
  }
}
