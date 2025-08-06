import 'package:flutter/material.dart';

class CustomCardSetting extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const CustomCardSetting({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: items.map((item) {
          return ListTile(
            onTap: item['onTap'] ?? () {},
            title: Text(
              item['title'] ?? '',
              style:const  TextStyle(fontFamily: "Tejwal"),
            ),
            trailing: Icon(item['trailingIcon'] ?? Icons.arrow_forward_ios),
            leading: Icon(item['leadingIcon'] ?? Icons.perm_identity_sharp),
          );
        }).toList(),
      ),
    );
  }
}