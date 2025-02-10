abstract class EmployeeDataEvent {
  const EmployeeDataEvent();
}

class GetEmployeeDataEvent extends EmployeeDataEvent {
  const GetEmployeeDataEvent();
}

class UpdateEmployeeRoleEvent extends EmployeeDataEvent {
  final String role;

  const UpdateEmployeeRoleEvent({required this.role});
}

class EmployeeStartDateSelectionEvent extends EmployeeDataEvent {
  final DateTime startDate;

  const EmployeeStartDateSelectionEvent({required this.startDate});
}

class EmployeeEndDateSelectionEvent extends EmployeeDataEvent {
  final DateTime endDate;

  const EmployeeEndDateSelectionEvent({required this.endDate});
}

class SaveEmployeeDataEvent extends EmployeeDataEvent {
  final String name;
  const SaveEmployeeDataEvent(this.name);
}

class CleanEmployeeEvent extends EmployeeDataEvent {
  const CleanEmployeeEvent();
}
