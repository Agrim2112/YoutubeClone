import '../entities/entities.dart';

class MyUser{
  String userId;
  String email;
  String name;
  String profilePic;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.profilePic});

  static final empty = MyUser(
      userId: '',
      email: '',
      name: '',
      profilePic: '',
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
        userId: userId,
        email: email,
        name: name,
        profilePic: profilePic,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: entity.userId,
        email: entity.email,
        name: entity.name,
        profilePic: entity.profilePic,
    );
  }

  @override
  String toString(){
    return 'MyUser: $userId, $name, $email,$profilePic';
  }
}