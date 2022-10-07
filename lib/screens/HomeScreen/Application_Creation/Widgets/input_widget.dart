import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class StudentLinkInput extends StatefulWidget {
  TextEditingController controller;
  TextInputType keyboard;
  var lable;
  var hint;
  Widget prefixIcon;
  Widget sufixIcon;
  bool enable;
  double padleft;
  var maxLines = 0;
  Function(String)? onChanged;

  int maxLength;
  TextInputAction textInputAction;
  int length;
  RegExp regexp;

  StudentLinkInput({
    this.onChanged,
    required this.maxLength,
    required this.keyboard,
    this.lable,
    this.hint,
    required this.prefixIcon,
    required this.sufixIcon,
    required this.enable,
    required this.padleft,
    required this.maxLines,
    required this.controller,
    required this.textInputAction,
    required this.length,
    required this.regexp,
  });

  @override
  _StudentLinkInputState createState() => _StudentLinkInputState();
}

class _StudentLinkInputState extends State<StudentLinkInput> {
  var clr = Colors.black12;
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = widget.controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < widget.length) {
      return 'Too short';
    }
    if (widget.regexp.stringMatch(text) == true)
      // return null if the text is valid
      return 'valid';
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GlobalWidget().DecorativeContainer(Container(
      margin: EdgeInsets.only(right: 10),
      padding:
          EdgeInsets.only(left: widget.padleft == null ? 0 : widget.padleft),
      child: TextField(
        maxLength: widget.maxLength,
        enabled: widget.enable,
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        onChanged: widget.onChanged,
        maxLines: widget.maxLines,
        cursorColor: clr,
        keyboardType: widget.keyboard,
        style: TextStyle(
          letterSpacing: .5,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: StudentLinkTheme().h3,
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorText: _errorText,
          labelStyle: TextStyle(
            color: Colors.black,
            letterSpacing: .5,
            fontSize: 16,
          ),
          labelText: widget.lable,
          hintStyle: TextStyle(
            color: StudentLinkTheme().disText,
            letterSpacing: .5,
            fontSize: StudentLinkTheme().h4,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.sufixIcon,
          hintText: widget.hint,
          fillColor: Colors.white,
        ),
        //autofocus: true,
        enableInteractiveSelection: true,
      ),
    ));
  }
}

class StudentLinkInputedit extends StatelessWidget {
  TextEditingController controller;
  TextInputType keyboard;
  var lable;
  var hint;
  Widget prefixIcon;
  Widget sufixIcon;
  bool enable;
  double padleft;
  var maxLines = 0;
  Function(String)? onChanged;

  int maxLength;
  TextInputAction textInputAction;
  int length;
  RegExp regexp;
  StudentLinkInputedit(
      {Key? key,
      this.onChanged,
      required this.maxLength,
      required this.keyboard,
      this.lable,
      this.hint,
      required this.prefixIcon,
      required this.sufixIcon,
      required this.enable,
      required this.padleft,
      required this.maxLines,
      required this.controller,
      required this.textInputAction,
      required this.length,
      required this.regexp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var clr = Colors.black12;

    return GlobalWidget().DecorativeContainer(Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.only(left: padleft == null ? 0 : padleft),
      child: TextField(
        maxLength: maxLength,
        enabled: enable,
        textInputAction: textInputAction,
        controller: controller,
        onChanged: onChanged,
        maxLines: maxLines,
        cursorColor: clr,
        keyboardType: keyboard,
        style: TextStyle(
          letterSpacing: .5,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: StudentLinkTheme().h3,
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          labelStyle: TextStyle(
            color: Colors.black,
            letterSpacing: .5,
            fontSize: 16,
          ),
          labelText: lable,
          hintStyle: TextStyle(
            color: StudentLinkTheme().disText,
            letterSpacing: .5,
            fontSize: StudentLinkTheme().h4,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          hintText: hint,
          fillColor: Colors.white,
        ),
      ),
    ));
  }
}
