import 'package:flutter/material.dart';
import 'package:madhukar_app/config/util/emp_role.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/app_button.dart';

class AddEmployeeDetailPage extends StatefulWidget {
  const AddEmployeeDetailPage({super.key});

  @override
  State<AddEmployeeDetailPage> createState() => _AddEmployeeDetailPageState();
}

class _AddEmployeeDetailPageState extends State<AddEmployeeDetailPage> {
  final TextEditingController _nameController = TextEditingController();

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('d MMM yyyy');

  // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   setState(() {
  //     _selectedDate = args.value;
  //   });
  // }

  // void _selectPresetDate(DateTime date) {
  //   setState(() {
  //     _selectedDate = date;
  //   });
  // }

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
                    child: GestureDetector(
                      onTap: () {
                        selectDate();
                      },
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

  selectDate() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 0, vertical: 20.0),
        content: SizedBox(
          height: 544,
          width: 396,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: _presetButton("Today", DateTime.now(), false)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: _presetButton("Next Monday", _nextMonday(), true)),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child:
                          _presetButton("Next Tuesday", _nextTuesday(), false)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _presetButton("After 1 week",
                        DateTime.now().add(const Duration(days: 7)), false),
                  ),
                ],
              ),
            ),
            // Table Calendar
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TableCalendar(
                  focusedDay: _selectedDate,
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  availableGestures: AvailableGestures.all,
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/calendar.png',
                    height: 20,
                    width: 23,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    formatter.format(_selectedDate),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 40,
                      width: 73,
                      decoration: const BoxDecoration(
                          color: Color(0xffEDF8FF),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: const Center(child: Text("Cancel")),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Selected Date: ${formatter.format(_selectedDate)}")),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 73,
                      decoration: const BoxDecoration(
                          color: Color(0xff1DA1F2),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: const Center(child: Text("Save")),
                    ),
                  ),
                  // ElevatedButton(
                  //   child: const Text("Save"),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //           content: Text(
                  //               "Selected Date: ${formatter.format(_selectedDate)}")),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  /// Button for selecting preset dates
  Widget _presetButton(String text, DateTime date, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() {
        _selectedDate = date;
      }),
      child: Container(
        height: 36,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff1DA1F2) : const Color(0xffEDF8FF),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Center(
          child: Text(text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xff1DA1F2),
              )),
        ),
      ),
    );
  }

  /// Get next Monday's date
  DateTime _nextMonday() {
    DateTime now = DateTime.now();
    return now.add(Duration(days: (8 - now.weekday) % 7));
  }

  /// Get next Tuesday's date
  DateTime _nextTuesday() {
    DateTime now = DateTime.now();
    return now.add(Duration(days: (9 - now.weekday) % 7));
  }
}
