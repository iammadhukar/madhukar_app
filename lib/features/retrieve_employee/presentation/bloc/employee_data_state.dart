import 'package:equatable/equatable.dart';

import '../../domain/entities/emp_data_entity.dart';

abstract class EmployeeDataState extends Equatable {
  const EmployeeDataState();
}

class InitialState extends EmployeeDataState {
  const InitialState();

  @override
  List<Object?> get props => [];
}

class EmployeeDataFetchingState extends EmployeeDataState {
  const EmployeeDataFetchingState();
  @override
  List<Object?> get props => [];
}

class EmployeeDataFetchedState extends EmployeeDataState {
  final List<EmpDataEntity>? data;

  @override
  List<Object?> get props => [data];

  const EmployeeDataFetchedState({required this.data});
}

class EmployeeDataFetchingError extends EmployeeDataState {
  final String error;

  const EmployeeDataFetchingError({required this.error});

  @override
  List<Object?> get props => [error];
}

class EmployeeRoleNotUpdatedgState extends EmployeeDataState {
  const EmployeeRoleNotUpdatedgState();

  @override
  List<Object?> get props => [];
}

class EmployeeRoleUpdatedState extends EmployeeDataState {
  final String role;

  const EmployeeRoleUpdatedState({required this.role});

  @override
  List<Object?> get props => [role];
}

class EmployeeStartDateUpdatedState extends EmployeeDataState {
  final DateTime startDate;

  const EmployeeStartDateUpdatedState({required this.startDate});

  @override
  List<Object?> get props => [startDate];
}

class EmployeeEndDateUpdatedState extends EmployeeDataState {
  final DateTime endDate;

  const EmployeeEndDateUpdatedState({required this.endDate});

  @override
  List<Object?> get props => [endDate];
}

class EmployeeDataUpdatedState extends EmployeeDataState {
  final String? role;
  final DateTime? startDate;
  final DateTime? endDate;

  const EmployeeDataUpdatedState({this.role, this.startDate, this.endDate});

  EmployeeDataUpdatedState copyWith(
      String? role, DateTime? startDate, DateTime? endDate) {
    return EmployeeDataUpdatedState(
        role: role ?? this.role,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }

  @override
  List<Object?> get props => [role, startDate, endDate];
}
