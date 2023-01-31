class User {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? phoneNumber;
  List<Address>? addresses;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.phoneNumber,
    this.addresses,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    var addressesList = json['addresses'] as List;
    List<Address> addresses =
        addressesList.map((i) => Address.fromJson(i)).toList();

    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      addresses: addresses,
    );
  }
}

class Address {
  int? id;
  String? phoneNumber;
  String? emailAddress;
  String? address;
  String? postalCode;
  bool? primary;
  int? user;

  Address({
    this.id,
    this.phoneNumber,
    this.emailAddress,
    this.address,
    this.postalCode,
    this.primary,
    this.user,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      phoneNumber: json['phone_number'],
      emailAddress: json['email_address'],
      address: json['address'],
      postalCode: json['postal_code'],
      primary: json['primary'],
      user: json['user'],
    );
  }
}
