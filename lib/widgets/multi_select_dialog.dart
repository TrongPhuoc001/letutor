import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>)? onChanged;
  final String title;

  const MultiSelectDialog(
      {Key? key,
      required this.items,
      required this.selectedItems,
      required this.title,
      this.onChanged})
      : super(key: key);

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<String> _selectedItems = [];
  bool _isShow = false;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
        title: Text(widget.title),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        items: widget.items.map((e) => MultiSelectItem(e, e)).toList(),
        onConfirm: (values) {
          widget.onChanged?.call(values);
        });
  }
}
