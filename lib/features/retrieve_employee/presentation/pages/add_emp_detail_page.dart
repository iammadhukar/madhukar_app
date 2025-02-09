import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madhukar_app/features/retrieve_employee/presentation/bloc/employee_data_event.dart';

import '../bloc/employee_data_bloc.dart';
import '../bloc/employee_data_state.dart';
import '../widgets/app_button.dart';
import '../widgets/date_selector.dart';
import '../widgets/role_widget.dart';

class AddEmployeeDetailPage extends StatefulWidget {
  const AddEmployeeDetailPage({super.key});

  @override
  State<AddEmployeeDetailPage> createState() => _AddEmployeeDetailPageState();
}

class _AddEmployeeDetailPageState extends State<AddEmployeeDetailPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const SizedBox.shrink(),
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('Add Employee Details'),
      ),
      body: Form(
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
              )
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        AppButton(
          onClick: () {
            Navigator.of(context).pop();
          },
          showBackgroundColor: false,
          title: 'Cancel',
        ),
        AppButton(
          onClick: () {},
          showBackgroundColor: true,
          title: 'Save',
        ),
      ],
    );
  }
}
