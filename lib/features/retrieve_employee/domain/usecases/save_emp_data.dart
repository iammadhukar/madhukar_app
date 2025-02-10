import 'package:madhukar_app/core/usecases/usecase.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';

import '../repository/emp_data_repository.dart';

class SaveEmpDataUseCase extends UseCase<void, EmpDataEntity> {
  final EmpDataRepository _repository;

  SaveEmpDataUseCase(EmpDataRepository repository) : _repository = repository;

  @override
  Future<void> call({EmpDataEntity? param}) async {
    await _repository.saveEmployee(param!);
  }
}
