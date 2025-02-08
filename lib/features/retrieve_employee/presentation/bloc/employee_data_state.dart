import '../../domain/entities/emp_data_entity.dart';

abstract class EmployeeDataState {
  const EmployeeDataState();
}

class InitialState extends EmployeeDataState {
  const InitialState();
}

class EmployeeDataFetchingState extends EmployeeDataState {
  const EmployeeDataFetchingState();
}

class EmployeeDataFetchedState extends EmployeeDataState {
  final List<EmpDataEntity>? data;

  const EmployeeDataFetchedState({required this.data});
}

class EmployeeDataFetchingError extends EmployeeDataState {
  final String error;

  const EmployeeDataFetchingError({required this.error});
}
