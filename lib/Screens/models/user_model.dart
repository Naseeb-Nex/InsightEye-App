class UserModel {
  String? uid;
  String? email;
  String? category;
  String? password;
  String? name;
  String? address;
  String? location;
  String? imgUrl;
  String? designation;
  String? phn1;
  String? phn2;

  UserModel({
    this.uid,
    this.email,
    this.category,
    this.password,
    this.name,
    this.address,
    this.location,
    this.imgUrl,
    this.designation,
    this.phn1,
    this.phn2,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      category: map['category'],
      password: map['password'],
      name: map['name'],
      address: map['address'],
      designation: map['designation'],
      imgUrl: map['imgUrl'],
      phn1: map['phn1'],
      phn2: map['phn2'],
      location: map['location'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'category': category,
      'password': password,
      'name': name,
      'address': address,
      'location': location,
      'designation': designation,
      'imgUrl': imgUrl,
      'phn1': phn1,
      'phn2': phn2,
    };
  }
}
