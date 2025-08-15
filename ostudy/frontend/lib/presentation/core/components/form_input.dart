import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class CustomFormInput extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomFormInput({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.width,
    this.height,
    this.controller,
    this.validator,
  });

  @override
  State<CustomFormInput> createState() => _CustomFormInputState();
}

class _CustomFormInputState extends State<CustomFormInput> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    if (widget.controller == null)
      _controller.dispose(); // only dispose if local
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
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
        borderSide: const BorderSide(color: AppColors.orange200, width: 2),
      ),
      suffixIcon: widget.isPassword
          ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: _isFocused
                    ? NeutralColors.black800
                    : NeutralColors.black200,
              ),
              onPressed: _togglePasswordVisibility,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: widget.height ?? 60,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: NeutralColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox.expand(
        child: TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: _buildInputDecoration(),
          validator: widget.validator,
        ),
      ),
    );
  }
}
