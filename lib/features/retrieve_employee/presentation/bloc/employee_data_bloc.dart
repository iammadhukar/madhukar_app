import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/usecases/get_emp_data.dart';
import 'employee_data_event.dart';
import 'employee_data_state.dart';

class EmployeeDatabloc extends Bloc<EmployeeDataEvent, EmployeeDataState> {
  final GetEmpDataUseCase _getEmpDataUseCase;

  String? _employeeRole;
  String? get employeeRole => _employeeRole;

  DateTime? _employeeStartDate;
  DateTime? get employeeStartDate => _employeeStartDate;

  DateTime? _employeeEndDate;
  DateTime? get employeeEndDate => _employeeEndDate;

  EmployeeDatabloc(this._getEmpDataUseCase) : super(const InitialState()) {
    on<GetEmployeeDataEvent>(onGetEmpData);
    on<UpdateEmployeeRoleEvent>(onUpdateEmployeeRole);
    on<EmployeeStartDateSelectionEvent>(onEmployeeStartDateSelection);
    on<EmployeeEndDateSelectionEvent>(onEmployeeEndDateSelection);
  }

  //Call this method on event call
  onGetEmpData(
      GetEmployeeDataEvent event, Emitter<EmployeeDataState> emit) async {
    //Call usecase to get data from repository
    final dataState = await _getEmpDataUseCase();

    //If data is success emit [DataLoadedState] else emit [DataFailedState]
    if (dataState is DataSuccess) {
      emit(EmployeeDataFetchedState(data: dataState.data!));
    } else {
      emit(EmployeeDataFetchingError(error: dataState.error!));
    }
  }

  //For update employee role
  onUpdateEmployeeRole(
      UpdateEmployeeRoleEvent event, Emitter<EmployeeDataState> emit) {
    _employeeRole = event.role;
    emit(EmployeeRoleUpdatedState(role: event.role));
  }

  //For employee start date selection
  onEmployeeStartDateSelection(
      EmployeeStartDateSelectionEvent event, Emitter<EmployeeDataState> emit) {
    _employeeStartDate = event.startDate;
    emit(EmployeeStartDateUpdatedState(startDate: event.startDate));
  }

  //For employee end date selection
  onEmployeeEndDateSelection(
      EmployeeEndDateSelectionEvent event, Emitter<EmployeeDataState> emit) {
    _employeeEndDate = event.endDate;
    emit(EmployeeEndDateUpdatedState(endDate: event.endDate));
  }
}
