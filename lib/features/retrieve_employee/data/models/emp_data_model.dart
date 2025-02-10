import 'package:floor/floor.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';

@Entity(tableName: 'employee_data')
class EmpDataModel extends EmpDataEntity {
  EmpDataModel({
    super.id,
    required super.name,
    required super.role,
    required super.startDate,
    required super.endDate,
  });

  factory EmpDataModel.fromEntity(EmpDataEntity entity) {
    return EmpDataModel(
      id: entity.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: entity.name,
      role: entity.role,
      startDate: entity.startDate,
      endDate: entity.endDate,
    );
  }
}
