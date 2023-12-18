import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSaved;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final GlobalKey<FormFieldState>? formFieldKey;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    this.inputFormatters,
    this.isSecret = false,
    this.readOnly = false,
    this.initialValue,
    this.validator,
    this.controller,
    this.keyboardType,
    this.onSaved, this.formFieldKey,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        key: widget.formFieldKey,
        controller: widget.controller,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        validator: widget.validator,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
