import 'package:flutter/material.dart';

import '../../core/constant/colors.dart';

class EditOrderPage extends StatefulWidget {
  final Map<String, dynamic> order;

  const EditOrderPage({super.key, required this.order});

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  late TextEditingController locationController;
  String status = "";

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController(text: widget.order['location']);
    status = widget.order['status'];
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تعديل الطلب #${widget.order['id']}"),
          backgroundColor: AppColors.darkbluecolor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("الموقع", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text("حالة الطلب", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: status,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'بانتظار السائق', child: Text('بانتظار السائق')),
                  DropdownMenuItem(value: 'قيد التوصيل', child: Text('قيد التوصيل')),
                  DropdownMenuItem(value: 'تم التوصيل', child: Text('تم التوصيل')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      status = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkbluecolor),
                  onPressed: () {
                    // حفظ التعديلات (ممكن تخزينها في Firebase أو تعديل الـList لاحقًا)
                    Navigator.pop(context);
                  },
                  child: const Text("حفظ التعديلات", style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
