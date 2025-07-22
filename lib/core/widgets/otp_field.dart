
import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';

class OtpField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode; // Add this to handle moving to the previous field

  const OtpField({
    required this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.previousFocusNode, // Add this parameter
  });

  @override
  _OtpFieldState createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  bool _hasValue = false;

  @override
  void initState() {
    super.initState();
    // Listen to changes in the controller to update the border color
    widget.controller.addListener(() {
      setState(() {
        _hasValue = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: _hasValue
              ? AppColors.primaryColor
              : AppColors.greyTextColor.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && widget.nextFocusNode != null) {
            // Move to the next field when a value is entered
            FocusScope.of(context).requestFocus(widget.nextFocusNode);
          } else if (value.isEmpty && widget.previousFocusNode != null) {
            // Move to the previous field when the value is deleted
            FocusScope.of(context).requestFocus(widget.previousFocusNode);
          }
        },
      ),
    );
  }
}
