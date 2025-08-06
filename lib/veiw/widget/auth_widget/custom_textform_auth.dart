import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool? isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final Widget icons;
  final IconData? iconData;

  const CustomTextFormAuth({
    super.key,
    this.obscureText,
    this.onTapIcon,
    required this.hinttext,
    required this.mycontroller,
    required this.valid,
    required this.isNumber,
    required this.icons,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(

        keyboardType: isNumber!
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: mycontroller,
        obscureText: obscureText == null || obscureText == false ? false : true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white24,
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          prefixIcon: icons,
          suffixIcon: InkWell(
            onTap: onTapIcon,
            child:  Icon(iconData),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey), // Border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey), // Border color when enabled
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white12), // Border color when focused
          ),
        ),
      ),
    );
  }
}
