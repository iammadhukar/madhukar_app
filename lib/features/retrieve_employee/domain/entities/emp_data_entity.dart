import 'package:equatable/equatable.dart';

class EmpDataEntity extends Equatable {
  String? id;
  final String name;
  final String role;
  final int startDate;
  final int endDate;

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
