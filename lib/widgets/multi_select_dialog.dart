import 'package:flutter/material.dart';
import 'package:lettutor/model/user.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<LearnTopics> items;
  final List<int> selectedItems;
  final Function(List<int>)? onChanged;
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
  List<int> _selectedItems = [];
  bool _isShow = false;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: MultiSelectDialogField(
          title: Text(widget.title),
          initialValue: widget.selectedItems,
          buttonText: Text(
            widget.title,
            style: TextStyle(color: Colors.grey),
          ),
          buttonIcon: Icon(
            Icons.arrow_drop_down,
            size: 8,
            color: Colors.grey,
          ),
          items:
              widget.items.map((e) => MultiSelectItem(e.id!, e.name!)).toList(),
          onConfirm: (values) {
            widget.onChanged?.call(values);
          }),
    );
  }
}
