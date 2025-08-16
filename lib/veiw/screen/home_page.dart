import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alnadha/veiw/screen/edit_profile.dart';
import 'package:alnadha/veiw/screen/show_order.dart';

import '../../core/constant/colors.dart';
import '../../core/constant/routing.dart';
import '../../core/services/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;


  late String token;

  @override
  void initState() {
    super.initState();
    final MyServices myServices = Get.find();

    // قراءة التوكين: أولًا من arguments، إذا null خذ من SharedPreferences
    token = Get.arguments != null && Get.arguments['token'] != null
        ? Get.arguments['token']
        : myServices.pref.getString("token") ?? '';

    print('📦 Token received: $token');
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages =  [
      MainContent(token:token),      // الصفحة الرئيسية
      OrdersPage(),       // تتبع الطلب
      EditProfilePage(),     // الإعدادات
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("مرحباً بك", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          selectedItemColor: AppColors.darkbluecolor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping),
              label: 'تتبع الطلب',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'الإعدادات',
            ),
          ],
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  final String token;
  const MainContent({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "هل ترغب بإرسال أو تتبع طلب؟",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 24),

          // كرت إنشاء طلب
          buildCard(
            title: "إنشاء طلب",
            description: "أرسل هدية أو مستند بسرعة بخطوات بسيطة",
            imagePath: "assets/images/photo_2025-07-17_00-09-43 (2).jpg",
            buttonText: "ابدأ الآن",
            onPressed: () => Get.toNamed(AppRoute.createorder,arguments: {
              'token': token,
            }),
          ),

          const SizedBox(height: 20),

          // كرت تتبع الطلب
          buildCard(
            title: "تتبع الطلب",
            description: "تابع حالة طلباتك الحالية مباشرة من هنا",
            imagePath: "assets/images/photo_2025-07-17_00-09-42.jpg",
            buttonText: "تتبع الآن",
            onPressed: () => Get.toNamed("/orderpage", arguments: {'token': token}),
          ),
        ],
      ),
    );
  }

  Widget buildCard({
    required String title,
    required String description,
    required String imagePath,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Card(
      color:  AppColors.gray,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkbluecolor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(buttonText, style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// صفحات أخرى بسيطة


