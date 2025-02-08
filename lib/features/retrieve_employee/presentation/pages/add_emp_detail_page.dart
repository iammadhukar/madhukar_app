import 'package:flutter/material.dart';
import 'package:madhukar_app/config/util/emp_role.dart';

import '../widgets/app_button.dart';

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
              GestureDetector(
                onTap: () {
                  showRoleBottomSheet();
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 23),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffE5E5E5)),
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.work_outline,
                        color: Color(0xff1DA1F2),
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        'Select role',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff949C9E),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 22,
                        color: Color(0xff1DA1F2),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 23),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffE5E5E5)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                      ),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/calendar.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 13.8),
                        const Text('Today'),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      'assets/images/arrow_right.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffE5E5E5)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                      ),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/calendar.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 13.8),
                        const Text('No date'),
                      ]),
                    ),
                  ),
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

  showRoleBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: empRoles.length,
          itemBuilder: (context, index) {
            return Center(
              child: Text(
                empRoles[index],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
