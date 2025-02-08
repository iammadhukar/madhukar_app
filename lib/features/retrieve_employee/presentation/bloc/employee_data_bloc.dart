import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/usecases/get_emp_data.dart';
import 'employee_data_event.dart';
import 'employee_data_state.dart';

class EmployeeDatabloc extends Bloc<EmployeeDataEvent, EmployeeDataState> {
  final GetEmpDataUseCase _getEmpDataUseCase;
  EmployeeDatabloc(this._getEmpDataUseCase) : super(const InitialState()) {
    on<GetEmployeeDataEvent>(onGetEmpData);
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
}
