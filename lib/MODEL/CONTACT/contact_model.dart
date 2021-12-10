class Contact {
  late int? id;
  late String firstname;
  late String lastname;
  late String address;
  late String phoneNumber;

  Contact(
      {this.id,
      required this.firstname,
      required this.lastname,
      required this.address,
      required this.phoneNumber});
  factory Contact.fromMap(Map<String, dynamic> json) => Contact(
      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['address'],
      phoneNumber: json['phoneNumber']);
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FirstName': firstname,
      'LastName': lastname,
      'Address': address,
      'PhoneNumber': phoneNumber
    };
    return map;
  }
}
