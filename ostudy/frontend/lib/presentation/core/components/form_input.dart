import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class CustomFormInput extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final double? width;
  final double? height;

  const CustomFormInput({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.width,
    this.height,
  });

  @override
  State<CustomFormInput> createState() => _CustomFormInputState();
}

class _CustomFormInputState extends State<CustomFormInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: widget.height,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.white(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox.expand(
        child: TextField(
          focusNode: _focusNode,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: ParagraphBody.smallRegular,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: NeutralColors.black100),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.orange200, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color:
                          _isFocused ? Colors.grey[800] : Colors.grey[400],
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
