import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';

class EmpDataModel extends EmpDataEntity {
  EmpDataModel(
      {required super.id,
      required super.name,
      required super.role,
      required super.startDate,
      required super.endDate});
}
