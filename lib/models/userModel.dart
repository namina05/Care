class appUser{
    final String uid;
    final String email;
    final String phone;
    appUser({
        required this.uid,
        required this.email,
        required this.phone
    });

    Map<String,dynamic> toMap(){
        return{
            'uid' : uid,
            'email' : email,
            'phone' : phone,
            'createdAt' : DateTime.now()
        };
    }
    factory appUser.fromMap(Map<String, dynamic> map) {
      return appUser(
      uid: map['uid'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}