import 'package:equatable/equatable.dart';

class EmpDataEntity extends Equatable {
  final String id;
  final String name;
  final String role;
  final int startDate;
  final int endDate;

  EmpDataEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.startDate,
    required this.endDate,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, role, startDate, endDate];
}
