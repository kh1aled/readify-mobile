class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String? profileImage;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"] as String,
      name: json["name"] as String,
      email: json["email"],
      profileImage: json["imageUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'profileImage': profileImage,
  };
}
