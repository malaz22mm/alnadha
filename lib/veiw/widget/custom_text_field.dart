import 'package:flutter/material.dart';
class CoustomTextFieldPersonal extends StatelessWidget {
  final TextEditingController controller;
  final bool isnum;
  final String initval;
  const CoustomTextFieldPersonal({super.key, required this.controller, required this.isnum, required this.initval});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isnum?TextInputType.number:TextInputType.name,
    );
  }
}