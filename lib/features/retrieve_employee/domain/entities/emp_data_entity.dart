import 'package:equatable/equatable.dart';

class EmpDataEntity extends Equatable {
  String? id;
  String name;
  String role;
  int startDate;
  int endDate;

  EmpDataEntity({
    this.id,
    required this.name,
    required this.role,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [id, name, role, startDate, endDate];
}
