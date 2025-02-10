import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';

class EmpListTile extends StatelessWidget {
  final EmpDataEntity employee;
  final Function onDeleteEmployee;
  final Function onClick;
  EmpListTile(
      {super.key,
      required this.employee,
      required this.onDeleteEmployee,
      required this.onClick});

  final DateFormat formatter = DateFormat('d MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(employee.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.archive, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        // Remove the itemployeeem from the list
        onDeleteEmployee();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onClick();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                employee.role,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: Color(0xff949C9E),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text(
                    "From ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color: Color(0xff949C9E),
                    ),
                  ),
                  Text(
                    formatter.format(DateTime.fromMillisecondsSinceEpoch(
                        employee.startDate)),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color: Color(0xff949C9E),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
