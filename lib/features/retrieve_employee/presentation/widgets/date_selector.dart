import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelector extends StatelessWidget {
  final DateTime? date;
  final Function(DateTime) onDateSelection;
  DateSelector({super.key, this.date, required this.onDateSelection});

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateFormat formatter = DateFormat('d MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectDate(context).then((value) {
          if (value != null) {
            onDateSelection(value);
          }
        });
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE5E5E5)),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        child: Row(children: [
          Image.asset(
            'assets/images/calendar.png',
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 13.8),
          date == null
              ? const Text(
                  "No date",
                  style: TextStyle(
                    color: Color(0xff949C9E),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                )
              : Text(
                  DateUtils.isSameDay(DateTime.now(), date)
                      ? "Today"
                      : formatter.format(date!),
                  style: const TextStyle(
                    color: Color(0xff323238),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
        ]),
      ),
    );
  }

  Future<DateTime?> selectDate(BuildContext context) {
    DateTime? selectedDate = date;
    int selectedButton = date != null ? checkSelectedButton(date!) : 1;
    return showDialog<DateTime?>(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
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
                        child: _presetButton(
                            "Today",
                            DateTime.now(),
                            selectedButton == 1,
                            (date) => setState(() {
                                  selectedButton = 1;
                                  selectedDate = date;
                                }))),
                    const SizedBox(width: 16),
                    Expanded(
                        child: _presetButton(
                            "Next Monday",
                            _nextMonday(),
                            selectedButton == 2,
                            (date) => setState(() {
                                  selectedButton = 2;
                                  selectedDate = _nextMonday();
                                }))),
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
                        child: _presetButton(
                            "Next Tuesday",
                            _nextTuesday(),
                            selectedButton == 3,
                            (date) => setState(() {
                                  selectedButton = 3;
                                  selectedDate = _nextTuesday();
                                }))),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _presetButton(
                          "After 1 week",
                          DateTime.now().add(const Duration(days: 7)),
                          selectedButton == 4,
                          (date) => setState(() {
                                selectedButton = 4;
                                selectedDate =
                                    DateTime.now().add(const Duration(days: 7));
                              })),
                    ),
                  ],
                ),
              ),
              // Table Calendar
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TableCalendar(
                    focusedDay: selectedDate ?? DateTime.now(),
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                    onDaySelected: (sDay, focusedDay) {
                      setState(() {
                        selectedDate = sDay;
                        selectedButton = checkSelectedButton(sDay);
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
                      formatter.format(selectedDate ?? DateTime.now()),
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
                        Navigator.pop(context, selectedDate);
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
                  ],
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }

  int checkSelectedButton(DateTime selectedDate) {
    if (DateUtils.isSameDay(DateTime.now(), selectedDate)) {
      return 1;
    } else if (DateUtils.isSameDay(_nextMonday(), selectedDate)) {
      return 2;
    } else if (DateUtils.isSameDay(_nextTuesday(), selectedDate)) {
      return 3;
    } else if (DateUtils.isSameDay(
        DateTime.now().add(const Duration(days: 7)), selectedDate)) {
      return 4;
    } else {
      return 5;
    }
  }

  /// Button for selecting preset dates
  Widget _presetButton(String text, DateTime date, bool isSelected,
      Function(DateTime) onDateSelection) {
    return GestureDetector(
      onTap: () => onDateSelection(date),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(vertical: 8),
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
