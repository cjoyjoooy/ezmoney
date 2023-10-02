import 'package:flutter/material.dart';

import 'appstyle.dart';

class ComboBox extends StatelessWidget {
  const ComboBox({
    Key? key, // Fix: Added the missing Key parameter
    required this.label,
    required this.value,
    required this.itemList,
    required this.onChangeValue, // Fix: Added the missing onChangeValue parameter
  }) : super(key: key); // Fix: Call the super constructor with key

  final String label;
  final dynamic value;
  final List<DropdownMenuItem<String>>
      itemList; // Fix: Changed itemList to List<DropdownMenuItem<String>>
  final void Function(String) onChangeValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: fontDefault(secondaryColor(1), FontWeight.w500),
      value: value,
      items: itemList,
      onChanged: (selectedValue) {
        onChangeValue(selectedValue as String);
      },
      validator: (value) {
        if (value == '') {
          return 'Please enter your gender';
        }
        return null;
      },
      icon: Icon(
        Icons.arrow_drop_down,
        color: secondaryColor(.5),
      ),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(250, 250, 250, .4),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(155, 128, 231, 1),
          ),
        ),
        labelStyle: fontDefault(secondaryColor(.5), FontWeight.w400),
        labelText: label,
      ),
      dropdownColor: primaryColor(1),
    );
  }
}
