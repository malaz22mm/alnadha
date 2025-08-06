import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  //final String labeltext;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool? isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final Widget icons;
  final IconData? iconData;

  const CustomTextFormAuth(
      {Key? key,
      this.obscureText,
      this.onTapIcon,
      required this.hinttext,
     // required this.labeltext,
      required this.mycontroller,
      required this.valid,
      required this.isNumber, required this.icons, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(

        keyboardType: isNumber!
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: mycontroller,
        obscureText: obscureText == null || obscureText == false  ? false : true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
            prefixIcon: icons,
            hintText: hinttext,
            hintStyle: const TextStyle(fontSize: 14,color: Colors.grey,),
            //floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            // label: Container(
            //     margin: const EdgeInsets.symmetric(horizontal: 9),
            //     child: Text(labeltext)),
            suffixIcon: InkWell(child: Icon(iconData), onTap: onTapIcon),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
