import 'package:alnadha/core/constant/image.dart';

import '../../data/model/onbordring_model.dart';

class StaticData {
  final String baseurl='https://al-nadha-1.onrender.com/api/';
  List<OnBordringModel> onBordingData = [
    OnBordringModel(
        title: "",
        subtitle:
            "Search for \n every thing you need \n near you",

        imageurl: AppImage.image3),
    OnBordringModel(
        title: "",
        subtitle:
            "fast delivery\n to your place",
        imageurl: AppImage.image2),
    OnBordringModel(
        title: "",
        subtitle:
"tracking shipper \n on the map"
        ,        imageurl: AppImage.image1),
  ];
}
