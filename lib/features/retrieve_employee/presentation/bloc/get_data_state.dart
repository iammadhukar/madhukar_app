import 'package:equatable/equatable.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';

abstract class GetDataState extends Equatable {
  final List<EmpDataEntity>? data;
  final String? error;

  const GetDataState({this.data, this.error});

  @override
  List<Object?> get props => [data, error];
}

class DataLoadingState extends GetDataState {
  const DataLoadingState();
}

class DataLoadedState extends GetDataState {
  const DataLoadedState(List<EmpDataEntity> data) : super(data: data);
}

class DataFailedState extends GetDataState {
  const DataFailedState(String error) : super(error: error);
}
