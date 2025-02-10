import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/util/emp_role.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/emp_data_entity.dart';
import '../bloc/employee_data_bloc.dart';
import '../bloc/employee_data_event.dart';
import '../bloc/employee_data_state.dart';

class RoleWidget extends StatelessWidget {
  final EmpDataEntity? employee;
  RoleWidget({super.key, this.employee});

  final employeeDataBloc = sl<EmployeeDatabloc>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showRoleBottomSheet(context);
      },
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(top: 23),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE5E5E5)),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.work_outline,
              color: Color(0xff1DA1F2),
            ),
            const SizedBox(width: 12.0),
            BlocBuilder<EmployeeDatabloc, EmployeeDataState>(
              bloc: employeeDataBloc,
              builder: (context, state) {
                String role = "";

                if (state is EmployeeDataUpdatedState) {
                  role = state.role ?? "";
                }

                print("role $role $state");
                return Text(
                  role.isEmpty ? 'Select role' : role,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: role.isEmpty ? Color(0xff949C9E) : Color(0xff323238),
                  ),
                );
              },
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_drop_down,
              size: 22,
              color: Color(0xff1DA1F2),
            )
          ],
        ),
      ),
    );
  }

  showRoleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: empRoles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                context
                    .read<EmployeeDatabloc>()
                    .add(UpdateEmployeeRoleEvent(role: empRoles[index]));
              },
              child: Center(
                child: Text(
                  empRoles[index],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              // height: 1,
              thickness: 0.5,
              color: Colors.grey,
            );
          },
        ),
      ),
    );
  }
}
