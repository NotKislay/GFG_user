import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FamilyDobContainer extends StatefulWidget {
  final String? date;
  final Function(String?) onDateChanged;

  const FamilyDobContainer({
    required this.date,
    required this.onDateChanged,
    super.key,
  });

  @override
  State<FamilyDobContainer> createState() => _FamilyDobContainerState();
}

class _FamilyDobContainerState extends State<FamilyDobContainer> {
  String? dateValue = '';
  @override
  void initState() {
    dateValue = widget.date;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final newDate = await dateSelection(context);
        if (newDate != null) {
          widget.onDateChanged(newDate);
          setState(() {
            dateValue = newDate;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(54, 38, 8, 37)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Icon(
            Icons.calendar_month,
            color: Colors.grey,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: 24,
            width: 1,
            color: Colors.grey,
          ),
          Text(
            (dateValue == null  || dateValue!.isEmpty)
                ? "Select the Date"
                : dateValue!,
            style: const TextStyle(fontSize: 16),
          ),
        ]),
      ),
    );
  }

  Future<String?> dateSelection(context) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: (widget.date == null || widget.date!.isEmpty)
          ? DateTime.now()
          : DateTime.parse(widget.date!),
      firstDate: DateTime(1925),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      final String formattedDate = formatter.format(selectedDate);
      return formattedDate;
    } else {
      return null;
    }
  }
}
