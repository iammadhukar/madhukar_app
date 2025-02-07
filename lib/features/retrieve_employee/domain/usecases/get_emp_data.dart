import 'package:madhukar_app/core/resources/data_state.dart';
import 'package:madhukar_app/core/usecases/usecase.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/repository/emp_data_repository.dart';

class GetEmpDataUseCase extends UseCase<DataState<List<EmpDataEntity>>, void> {
  final EmpDataRepository _repository;

  GetEmpDataUseCase(this._repository);
  @override
  Future<DataState<List<EmpDataEntity>>> call(param) {
    return _repository.getEmployees();
  }
}
