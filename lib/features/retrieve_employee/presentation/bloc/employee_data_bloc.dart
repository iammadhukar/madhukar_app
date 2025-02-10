import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/usecases/save_emp_data.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/usecases/get_emp_data.dart';
import 'employee_data_event.dart';
import 'employee_data_state.dart';

class EmployeeDatabloc extends Bloc<EmployeeDataEvent, EmployeeDataState> {
  final GetEmpDataUseCase _getEmpDataUseCase;
  final SaveEmpDataUseCase _saveEmpDatauseCase;

  String? _employeeRole;
  String? get employeeRole => _employeeRole;

  DateTime? _employeeStartDate;
  DateTime? get employeeStartDate => _employeeStartDate;

  DateTime? _employeeEndDate;
  DateTime? get employeeEndDate => _employeeEndDate;

  EmployeeDatabloc(this._getEmpDataUseCase, this._saveEmpDatauseCase)
      : super(const InitialState()) {
    on<GetEmployeeDataEvent>(onGetEmpData);
    on<UpdateEmployeeRoleEvent>(onUpdateEmployeeRole);
    on<EmployeeStartDateSelectionEvent>(onEmployeeStartDateSelection);
    on<EmployeeEndDateSelectionEvent>(onEmployeeEndDateSelection);
    on<SaveEmployeeDataEvent>(onSaveEmployeeData);
    on<CleanEmployeeEvent>(onCleanEmployeeData);
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
    emit(EmployeeDataUpdatedState(
        role: _employeeRole,
        startDate: _employeeStartDate,
        endDate: _employeeEndDate));
  }

  //For employee start date selection
  onEmployeeStartDateSelection(
      EmployeeStartDateSelectionEvent event, Emitter<EmployeeDataState> emit) {
    _employeeStartDate = event.startDate;
    emit(EmployeeDataUpdatedState(
        role: _employeeRole,
        startDate: _employeeStartDate,
        endDate: _employeeEndDate));
  }

  //For employee end date selection
  onEmployeeEndDateSelection(
      EmployeeEndDateSelectionEvent event, Emitter<EmployeeDataState> emit) {
    _employeeEndDate = event.endDate;
    emit(EmployeeDataUpdatedState(
        role: _employeeRole,
        startDate: _employeeStartDate,
        endDate: _employeeEndDate));
  }

  onSaveEmployeeData(
      SaveEmployeeDataEvent event, Emitter<EmployeeDataState> emit) async {
    emit(const SavingEmployeeDataState());
    EmpDataEntity employee = EmpDataEntity(
      name: event.name,
      role: _employeeRole!,
      startDate: _employeeStartDate!.millisecondsSinceEpoch,
      endDate: _employeeEndDate!.millisecondsSinceEpoch,
    );

    //Call usecase to save data to repository
    await _saveEmpDatauseCase(param: employee);
    emit(const SavedEmployeeDataState());
  }

  onCleanEmployeeData(
      CleanEmployeeEvent event, Emitter<EmployeeDataState> emit) {
    _employeeRole = null;
    _employeeStartDate = null;
    _employeeEndDate = null;
    emit(const CleanedEmployeeState());
  }
}
