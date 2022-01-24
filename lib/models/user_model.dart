class UserModel {
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? imageUrl;

  final String? userId;

  bool? isMechanic;
  final bool? isOnline;
  final int? lastSeen;

  UserModel(
      {this.userId,
      this.email,
      this.password,
      this.phoneNumber,
      this.fullName,
      this.imageUrl,
      this.isMechanic,
      this.isOnline,
      this.lastSeen});
}
