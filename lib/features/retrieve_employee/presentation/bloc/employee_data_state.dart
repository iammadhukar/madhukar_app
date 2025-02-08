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

class EmployeeRoleUpdatedState extends EmployeeDataState {
  final String role;

  const EmployeeRoleUpdatedState({required this.role});
}

class EmployeeStartDateUpdatedState extends EmployeeDataState {
  final DateTime startDate;

  const EmployeeStartDateUpdatedState({required this.startDate});
}

class EmployeeEndDateUpdatedState extends EmployeeDataState {
  final DateTime endDate;

  const EmployeeEndDateUpdatedState({required this.endDate});
}
