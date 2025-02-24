import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madhukar_app/features/retrieve_employee/presentation/bloc/employee_data_event.dart';

import '../../domain/entities/emp_data_entity.dart';
import '../bloc/employee_data_bloc.dart';
import '../bloc/employee_data_state.dart';
import '../widgets/app_button.dart';
import '../widgets/date_selector.dart';
import '../widgets/role_widget.dart';

class AddEmployeeDetailPage extends StatefulWidget {
  EmpDataEntity? employee;
  AddEmployeeDetailPage({super.key, this.employee});

  @override
  State<AddEmployeeDetailPage> createState() => _AddEmployeeDetailPageState();
}

class _AddEmployeeDetailPageState extends State<AddEmployeeDetailPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.employee?.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const SizedBox.shrink(),
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: widget.employee == null
            ? const Text('Add Employee Details')
            : const Text('Edit Employee Details'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          // FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.only(top: 24.0),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffE5E5E5)),
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                ),
                child: TextFormField(
                  // autofocus: true,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Employee name',
                    hintStyle: TextStyle(color: Color(0xff949C9E)),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 24, // Minimum width to create space
                      minHeight: 24,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 8, right: 12),
                      child: Icon(
                        Icons.person_outline,
                        color: Color(0xff1DA1F2),
                        size: 24,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              RoleWidget(),
              const SizedBox(height: 23),
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<EmployeeDatabloc, EmployeeDataState>(
                        builder: (context, state) {
                      DateTime? sDate;
                      if (state is EmployeeDataUpdatedState) {
                        sDate = state.startDate;
                      }

                      return DateSelector(
                        date: sDate ?? DateTime.now(),
                        onDateSelection: (date) {
                          context.read<EmployeeDatabloc>().add(
                              EmployeeStartDateSelectionEvent(startDate: date));
                        },
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      'assets/images/arrow_right.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Expanded(child:
                      BlocBuilder<EmployeeDatabloc, EmployeeDataState>(
                          builder: (context, state) {
                    DateTime? eDate;
                    if (state is EmployeeDataUpdatedState) {
                      eDate = state.endDate;
                    }
                    return DateSelector(
                      date: eDate,
                      onDateSelection: (date) {
                        context
                            .read<EmployeeDatabloc>()
                            .add(EmployeeEndDateSelectionEvent(endDate: date));
                      },
                    );
                  })),
                ],
              ),
              BlocListener<EmployeeDatabloc, EmployeeDataState>(
                listener: (context, state) {
                  if (state is SavingEmployeeDataState) {
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        content: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is SavedEmployeeDataState) {
                    Navigator.of(context).pop();
                    context
                        .read<EmployeeDatabloc>()
                        .add(const CleanEmployeeEvent());
                  }
                },
                child: const SizedBox.shrink(),
              ),
              BlocListener<EmployeeDatabloc, EmployeeDataState>(
                listener: (context, state) {
                  if (state is CleanedEmployeeState) {
                    context
                        .read<EmployeeDatabloc>()
                        .add(const GetEmployeeDataEvent());
                    Navigator.of(context).pop();
                  }
                },
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        AppButton(
          onClick: () {
            // Navigator.of(context).pop();
            context.read<EmployeeDatabloc>().add(const CleanEmployeeEvent());
          },
          showBackgroundColor: false,
          title: 'Cancel',
        ),
        AppButton(
          onClick: () {
            if (_nameController.text.isNotEmpty) {
              if (widget.employee == null) {
                context
                    .read<EmployeeDatabloc>()
                    .add(SaveEmployeeDataEvent(_nameController.text));
              } else {
                widget.employee!.name = _nameController.text;
                context
                    .read<EmployeeDatabloc>()
                    .add(EditEmployeeEvent(widget.employee!));
              }
            }
          },
          showBackgroundColor: true,
          title: 'Save',
        ),
      ],
    );
  }
}
