//User Model
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  final bool? isAdmin;
  final String referral;
  final int? points;
  final String? referredBy;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoUrl,
    this.isAdmin,
    required this.referral,
    this.points,
    this.referredBy,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
      referral: data['referral'],
      points: data['points'] ?? 0,
      referredBy: data['referredBy'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "photoUrl": photoUrl,
        'isAdmin': isAdmin,
        'referral': referral,
        'points': points,
        'referredBy':referredBy,
      };
}
