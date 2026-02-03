import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CustomDateNow extends StatelessWidget {
  CustomDateNow({super.key});
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('MMMM d , y');
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateFormat.format(selectedDate),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        Text(
          'Today',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ],
    );
  }
}
