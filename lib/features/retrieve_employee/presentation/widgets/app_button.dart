import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onClick;
  final bool showBackgroundColor;
  final String title;
  const AppButton({
    super.key,
    required this.onClick,
    required this.showBackgroundColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        height: 40,
        width: 73,
        decoration: BoxDecoration(
          color: showBackgroundColor ? Color(0xff1DA1F2) : Color(0xffEDF8FF),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
            color: showBackgroundColor ? Colors.white : const Color(0xff1DA1F2),
          ),
        )),
      ),
    );
  }
}
