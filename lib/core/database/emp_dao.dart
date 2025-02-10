import 'package:floor/floor.dart';
import 'package:madhukar_app/features/retrieve_employee/data/models/emp_data_model.dart';

@dao
abstract class EmployeeDao {
  @Insert()
  Future<void> addEmployee(EmpDataModel employee);

  @delete
  Future<void> deleteEmployee(EmpDataModel employee);

  @Query('Select * from employee_data')
  Future<List<EmpDataModel>> getEmployeeData();

  @update
  Future<void> editEmployee(EmpDataModel employee);
}
