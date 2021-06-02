import 'package:flutter/material.dart';

class RoundedTextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool rightIcon;
  final Color color;
  final Color backgroundColor;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const RoundedTextFieldWidget(
      {Key key, this.hintText, this.icon, this.rightIcon = false, this.onChanged, this.color = Colors.white, this.backgroundColor = Colors.blueAccent, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 16, top: 4, bottom: 0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(36),
      ),
      child: rightIcon
          ? TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: color,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  icon,
                  color: color,
                ),
                hintText: hintText,
                hintStyle: TextStyle(color: color),
                border: InputBorder.none,
              ),
            )
          : TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: color,
              decoration: InputDecoration(
                icon: Icon(
                  icon,
                  color: color,
                ),
                hintText: hintText,
                hintStyle: TextStyle(color: color),
                border: InputBorder.none,
              ),
            ),
    );
  }
}
