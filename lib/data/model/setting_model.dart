class PersonalInfoModel {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNumber;
  String? aboutMe;
  String? profilePhoto;
  String? city;
  bool? isBuyer;
  bool? isSeller;
  bool? isAgent;
  Null rating;
  int? numReviews;
  String? fullName;
  List<Null>? preferredLocations;

  PersonalInfoModel(
      {this.firstName,
        this.lastName,
        this.email,
        this.gender,
        this.phoneNumber,
        this.aboutMe,
        this.profilePhoto,
        this.city,
        this.isBuyer,
        this.isSeller,
        this.isAgent,
        this.rating,
        this.numReviews,
        this.fullName,
        this.preferredLocations});

  PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    aboutMe = json['about_me'];
    profilePhoto = json['profile_photo'];
    city = json['city'];
    isBuyer = json['is_buyer'];
    isSeller = json['is_seller'];
    isAgent = json['is_agent'];
    rating = json['rating'];
    numReviews = json['num_reviews'];
    fullName = json['full_name'];
    if (json['preferred_locations'] != null) {
      preferredLocations = <Null>[];
      json['preferred_locations'].forEach((v) {
        // preferredLocations!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['about_me'] = aboutMe;
    data['profile_photo'] = profilePhoto;
    data['city'] = city;
    data['is_buyer'] = isBuyer;
    data['is_seller'] = isSeller;
    data['is_agent'] = isAgent;
    data['rating'] = rating;
    data['num_reviews'] = numReviews;
    data['full_name'] = fullName;
    if (preferredLocations != null) {
      //data['preferred_locations'] =
      // this.preferredLocations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}