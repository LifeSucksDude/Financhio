import 'package:flutter/material.dart';

class MyDropdownWidget extends StatefulWidget {
  final List<String> dropdownItems;
  final Color textColor;
  final String hintText;
  final Function(String?) onItemSelected;

  MyDropdownWidget({
    required this.dropdownItems,
    required this.textColor,
    required this.hintText,
    required this.onItemSelected,
  });

  @override
  _MyDropdownWidgetState createState() => _MyDropdownWidgetState();
}

class _MyDropdownWidgetState extends State<MyDropdownWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          height: 56,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 208, 208, 208),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: DropdownButtonFormField<String>(
            hint:selectedValue==null?Text(widget.hintText): Text('notnull'),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              
            ),
            value: selectedValue,
             elevation: 3,
            
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down_outlined),
            items: widget.dropdownItems.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 20, color: widget.textColor),
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                print(selectedValue);

              });
              widget.onItemSelected(value);
            },
          ),
        ),
      ),
    );
  }
}
