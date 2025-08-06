import 'package:flutter/material.dart';
import 'package:alnadha/veiw/widget/addpropertytext.dart';

class CustomerOrder extends StatefulWidget {
  const CustomerOrder({super.key});

  @override
  State<CustomerOrder> createState() => _CustomerOrderState();
}

class _CustomerOrderState extends State<CustomerOrder> {
  TextEditingController con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  'continue',
                  style: TextStyle(fontSize: 20),
                ),
              ))
        ],
      ),
      appBar: AppBar(
        title: const Text("طلبي"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "ماذا تريد أن تطلب؟",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 30,
            ),
            AddPropertyText(
                nameofitem: "نوع السيارة",
                isreq: false,
                controller: con,
                isnum: false),
            const SizedBox(
              height: 30,
            ),
            AddPropertyText(
                nameofitem: "تفاصيل الطلب",
                isreq: false,
                controller: con,
                isnum: false),
            const SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'اختر الموقع والوجهة من الخريطة',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )))
          ],
        ),
      ),
    );
  }
}
