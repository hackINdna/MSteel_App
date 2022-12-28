import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';

typedef OnSavedCallback = void Function(String?)?;
typedef ValidatorCallback = String? Function(String?)?;

class PasswordTextFormField extends StatefulWidget {
  final String hintText;
  final OnSavedCallback onSaved;
  final OnSavedCallback onChanged;
  final ValidatorCallback validator;
  final TextEditingController? controller;
  final bool darkBg;

  const PasswordTextFormField({
    super.key,
    this.hintText = "",
    this.onSaved,
    this.onChanged,
    this.validator,
    this.controller,
    this.darkBg = false,
  });

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _passwordVisible = false;
  //String _password = "";
  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _passwordVisible,
      enableSuggestions: false,
      autocorrect: false,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            width: 2,
            color: Color(0xff34A2B4),
          ),
        ),
        errorStyle: (widget.darkBg)
            ? const TextStyle(
                color: Colors.white60,
              )
            : null,
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            width: 2,
            color: Colors.redAccent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            width: 2,
            color: themeColors.last,
          ),
        ),
        fillColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () => _toggle(),
        ),
      ),
      onSaved: (newValue) => widget.onSaved!(newValue),
      onChanged: (value) {
        //widget.onChanged!(value);
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        } else {
          return;
        }
      },
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        } else {
          //our normal min 6 digit validator
          if (value != null && value.length > 5) {
            return null;
          } else {
            return "Minimum password length is 6 digits.";
          }
        }
      },
    );
  }
}
