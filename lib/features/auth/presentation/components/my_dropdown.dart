import 'package:flutter/material.dart';

class MyDropDown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String hint;

  const MyDropDown({
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.surface,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButton<T>(
        value: value,
        hint: Text(hint),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary, fontSize: 16),
        underline: SizedBox(),
        onChanged: onChanged,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
      ),
    );
  }
}
