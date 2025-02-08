abstract class EmployeeDataEvent {
  const EmployeeDataEvent();
}

class GetEmployeeDataEvent extends EmployeeDataEvent {
  const GetEmployeeDataEvent();
}

class SaveEmployeeDataEvent extends EmployeeDataEvent {
  const SaveEmployeeDataEvent();
}
