import 'package:madhukar_app/core/resources/data_state.dart';

import '../entities/emp_data_entity.dart';

abstract class EmpDataRepository {
  Future<DataState<List<EmpDataEntity>>> getEmployees();
}
