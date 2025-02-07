import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madhukar_app/core/resources/data_state.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/usecases/get_emp_data.dart';
import 'get_data_event.dart';
import 'get_data_state.dart';

class GetEmpDataBloc extends Bloc<GetLocalDataEvent, GetDataState> {
  final GetEmpDataUseCase _getEmpDataUseCase;
  GetEmpDataBloc(this._getEmpDataUseCase) : super(const DataLoadingState()) {
    on<GetEmpDataEvent>(onGetEmpData);
  }

//Call this method on event call
  onGetEmpData(GetEmpDataEvent event, Emitter<GetDataState> emit) async {
    //Call usecase to get data from repository
    final dataState = await _getEmpDataUseCase();

    //If data is success emit [DataLoadedState] else emit [DataFailedState]
    if (dataState is DataSuccess) {
      emit(DataLoadedState(dataState.data!));
    } else {
      emit(DataFailedState(dataState.error!));
    }
  }
}
