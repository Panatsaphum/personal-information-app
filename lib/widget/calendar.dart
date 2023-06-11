import 'package:flutter/material.dart';
import 'package:personal_information_app/theme/font_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  TextEditingController yearSelectedController = TextEditingController();
  List<DropdownMenuEntry<int>> yearEntry = [];
  int? yearSelected;
  DateTime currentDate = DateTime.now();
  DateTime? dateSelected;

  @override
  void initState() {
    getYesrs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.blueGrey,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Year:",
                  style: FontTheme.regular,
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownMenu(
                  menuHeight: 300,
                  dropdownMenuEntries: yearEntry,
                  controller: yearSelectedController,
                  onSelected: (value) {
                    setState(() {
                      yearSelected = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TableCalendar(
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              calendarFormat: CalendarFormat.month,
              focusedDay: DateTime(yearSelected ?? currentDate.year, dateSelected?.month ?? currentDate.month, currentDate.day),
              firstDay: DateTime(yearSelected ?? currentDate.year, 1, 0),
              lastDay: currentDate,
              currentDay: dateSelected,
              onDaySelected: (date, value) {
                setState(() {
                  dateSelected = value;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, dateSelected);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                  child: Text(
                    "เลือก",
                    style: FontTheme.regular,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getYesrs() {
    var currentYear = DateTime.now().year;
    var lastYear = currentYear - 120;
    for (int i = currentYear; i > lastYear; i--) {
      yearEntry.add(
        DropdownMenuEntry(
          value: i,
          label: i.toString(),
        ),
      );
    }
    setState(() {
      yearEntry;
      yearSelected = yearEntry.first.value;
      yearSelectedController.text = yearEntry.first.label;
    });
  }
}
