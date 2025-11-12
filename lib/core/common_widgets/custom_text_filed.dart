import 'package:flutter/material.dart';
import 'package:movies_app/core/config/app_colors.dart';

// ignore: must_be_immutable
class CustomTextFiled extends StatefulWidget {
  String label;
  IconData? icon;
  bool isPassword;
  String? Function(String?)? validator;
  TextEditingController controller;
  int? maxLines;
  CustomTextFiled({
    super.key,
    this.icon,
    required this.label,
    this.isPassword = false,
    required this.validator,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: TextFormField(
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: widget.maxLines,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPassword ? obscure : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.darkGray,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.transparent, width: 1.5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.transparent, width: 1.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.transparent, width: 1.5),
          ),

          label: Text(widget.label),
          prefixIcon: Icon(widget.icon, color: Colors.white),
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  child: Icon(
                    obscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
