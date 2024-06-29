
class UserModel {
  late String userId;
  late String name;
  late String email;
  late String phoneNumber;
  late String bio;
  late String profilePic;
  late int unreadMessagesCount = 0;


  UserModel({required this.email,
    required this.userId,
    required this.name,
    required this.bio,
    required this.phoneNumber,
    required this.profilePic,
    required this.unreadMessagesCount,

  });
  @override
  String toString() {
    return 'UserModel{userId: $userId, name: $name, email: $email, phoneNumber: $phoneNumber, bio: $bio, profilePic: $profilePic, unreadMessagesCount: $unreadMessagesCount}';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userId = json['uid'];
    if (userId is! String) {
      throw FormatException(
          'Invalid JSON: required "userId" field of type String in $json');
    }
    final name = json['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $json');
    }

    final email = json['email'];
    if (email is! String) {
      throw FormatException(
          'Invalid JSON: required "email" field of type String in $json');
    }

    final phoneNumber = json['phoneNumber'];
    if (phoneNumber is! String) {
      throw FormatException(
          'Invalid JSON: required "phoneNumber" field of type String in $json');
    }

    final bio = json['bio'];
    if (bio is! String) {
      throw FormatException(
          'Invalid JSON: required "bio" field of type String in $json');
    }

    final profilePic = json['profilePic'];
    if (profilePic is! String) {
      throw FormatException(
          'Invalid JSON: required "profilePic" field of type String in $json');
    }

    final unreadMessagesCount = json['unreadMessagesCount'];
    if (unreadMessagesCount is! int) {
      throw FormatException(
          'Invalid JSON: required "unreadMessagesCount" field of type int in $json');
    }

    return UserModel(
      name: name,
      userId: userId,
      email: email,
      phoneNumber: phoneNumber,
      bio: bio,
      profilePic: profilePic,
      unreadMessagesCount: unreadMessagesCount,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': userId,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'profilePic': profilePic,
      'unreadMessagesCount': unreadMessagesCount,
    };
  }
}
/*class UserService {
  UserModel? _user;
  UserModel? get user => _user;

  Future<void> setUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user.toJson().toString());
    _user = user;
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userJson as Map));
    }
    return null;
  }

  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    _user = null;
  }
}*/
