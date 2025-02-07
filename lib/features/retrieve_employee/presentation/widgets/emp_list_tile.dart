import 'package:flutter/widgets.dart';
import 'package:madhukar_app/features/retrieve_employee/domain/entities/emp_data_entity.dart';

class EmpListTile extends StatelessWidget {
  final EmpDataEntity employee;
  const EmpListTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              "From",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
                color: Color(0xff949C9E),
              ),
            ),
            Text(
              employee.startDate.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
                color: Color(0xff949C9E),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
