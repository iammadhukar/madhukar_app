import 'package:madhukar_app/core/database/app_database.dart';
import 'package:madhukar_app/core/resources/data_state.dart';
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
}
