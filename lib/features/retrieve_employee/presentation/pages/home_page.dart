import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';
import 'package:madhukar_app/features/retrieve_employee/presentation/bloc/employee_data_event.dart';
import 'package:madhukar_app/features/retrieve_employee/presentation/pages/add_emp_detail_page.dart';

import '../bloc/employee_data_bloc.dart';
import '../bloc/employee_data_state.dart';
import '../widgets/emp_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        title: const Text("Employee List"),
        backgroundColor: const Color(0xff1DA1F2),
      ),
      body: BlocConsumer<EmployeeDatabloc, EmployeeDataState>(
        listener: (context, state) {
          if (state is EmployeeDeletingState) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          } else if (state is EmployeeDeletedState) {
            Navigator.of(context).pop();
            showDeleteSnakeBar();
            context.read<EmployeeDatabloc>().add(const GetEmployeeDataEvent());
          }
        },
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EmployeeDataFetchingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EmployeeDataFetchingError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is EmployeeDataFetchedState) {
            if (state.data!.isNotEmpty) {
              List<EmpDataEntity> _currentEmployees =
                  getEmployeeList(state.data!, "current");
              List<EmpDataEntity> _oldEmployees =
                  getEmployeeList(state.data!, "old");
              return Column(
                children: [
                  _currentEmployees.isNotEmpty
                      ? Container(
                          height: 56.0,
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.3),
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            "Current Employees",
                            style: TextStyle(
                              color: Color(0xff1DA1F2),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  _currentEmployees.isNotEmpty
                      ? ListView.separated(
                          itemCount: _currentEmployees.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return EmpListTile(
                              employee: _currentEmployees[index],
                              onDeleteEmployee: () {
                                context.read<EmployeeDatabloc>().add(
                                    DeleteEmployeeEvent(
                                        _currentEmployees[index]));
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.grey,
                            );
                          },
                        )
                      : const SizedBox.shrink(),
                  _oldEmployees.isNotEmpty
                      ? Container(
                          height: 56.0,
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.3),
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            "Previous Employees",
                            style: TextStyle(
                              color: Color(0xff1DA1F2),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  _oldEmployees.isNotEmpty
                      ? ListView.separated(
                          itemCount: _oldEmployees.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return EmpListTile(
                              employee: _oldEmployees[index],
                              onDeleteEmployee: () {
                                context.read<EmployeeDatabloc>().add(
                                    DeleteEmployeeEvent(_oldEmployees[index]));
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.grey,
                            );
                          },
                        )
                      : const SizedBox.shrink(),
                ],
              );
            } else {
              return Center(
                child: Image.asset(
                  "assets/images/emp_not_found.png",
                  height: 244.38,
                  width: 261.79,
                ),
              );
            }
          } else {
            return const Center(
              child: SizedBox.shrink(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddEmployeeDetailPage()));
        },
        child: Image.asset("assets/images/fab_icon.png"),
      ),
    );
  }

  showDeleteSnakeBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Employee deleted"),
        duration:
            Duration(seconds: 2), // Duration for how long the snackbar appears
      ),
    );
  }

  List<EmpDataEntity> getEmployeeList(
      List<EmpDataEntity> employees, String type) {
    if (type == "old") {
      return employees
          .where((e) => DateTime.fromMillisecondsSinceEpoch(e.endDate)
              .isBefore(DateTime.now()))
          .toList();
    } else {
      return employees
          .where((e) => DateTime.fromMillisecondsSinceEpoch(e.endDate)
              .isAfter(DateTime.now().subtract(const Duration(days: 1))))
          .toList();
    }
  }
}
