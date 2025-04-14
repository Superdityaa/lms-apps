import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ToggleSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onToggle;
  final Color activeColor;
  final Color inactiveColor;

  const ToggleSwitch({
    Key? key,
    this.initialValue = false,
    required this.onToggle,
    this.activeColor = AppColors.orange500,
    this.inactiveColor = NeutralColors.black200,
  }) : super(key: key);

  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
  }

  void _toggleSwitch() {
    setState(() {
      isToggled = !isToggled;
    });
    widget.onToggle(isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isToggled ? widget.activeColor : widget.inactiveColor,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: isToggled ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(5),
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
