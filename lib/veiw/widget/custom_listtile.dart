import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CoustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;
  final void Function() onTap;
  const CoustomListTile({super.key, required this.title, required this.subtitle, required this.iconData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade300
          ),
          child: ListTile(
            title: Text(title,style: TextStyle(fontSize: 15.sp),textAlign: TextAlign.end,),
            subtitle: Text(subtitle,textAlign: TextAlign.end,),
            autofocus: true,
            leading: const Icon(Icons.edit),
            trailing: Icon(iconData),
          )
      ),
    );
  }
}