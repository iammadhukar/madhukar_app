import 'package:madhukar_app/core/database/app_database.dart';
import 'package:madhukar_app/core/resources/data_state.dart';
import 'package:madhukar_app/features/retrieve_employee/data/models/emp_data_model.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/repository/emp_data_repository.dart';

import '../data_sources/local_data/emp_database_local.dart';

class EmpDataRepositoryImpl implements EmpDataRepository {
  final EmpDatabaseLocal _databaseLocal;
  final AppDatabase _localDatabase;

  EmpDataRepositoryImpl(this._databaseLocal, this._localDatabase);
  @override
  Future<DataState<List<EmpDataEntity>>> getEmployees() async {
    try {
      final List<EmpDataEntity> data =
          await _databaseLocal.getAllEmployeeLocal(_localDatabase);
      return DataSuccess(data);
    } catch (e) {
      return const DataFailure("Something went wrong. Please try again later.");
    }
  }

  @override
  Future<void> saveEmployee(EmpDataEntity data) async {
    try {
      _databaseLocal.saveEmployee(
          EmpDataModel.fromEntity(data), _localDatabase);
    } catch (e) {
      // return const DataFailure('Unable to save data. Please try again.');
    }
  }

  @override
  Future<void> deleteEmployee(EmpDataEntity data) async {
    try {
      _databaseLocal.deleteEmployee(
          EmpDataModel.fromEntity(data), _localDatabase);
    } catch (e) {
      // return const DataFailure('Unable to save data. Please try again.');
    }
  }

  @override
  Future<void> editEmployee(EmpDataEntity data) async {
    try {
      await _databaseLocal.editEmployee(
          EmpDataModel.fromEntity(data), _localDatabase);
    } catch (e) {
      // return const DataFailure('Unable to save data. Please try again.');
    }
  }
}
