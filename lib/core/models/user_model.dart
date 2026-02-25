/// User model matching FakeStore API response.
///
/// API response format:
/// ```json
/// {
///   "id": 1,
///   "email": "john@gmail.com",
///   "username": "johnd",
///   "password": "m38rmF$",
///   "name": { "firstname": "john", "lastname": "doe" },
///   "phone": "1-570-236-7033",
///   "address": {
///     "city": "kilcoole",
///     "street": "new road",
///     "number": 7682,
///     "zipcode": "12926-3874"
///   }
/// }
/// ```
class UserModel {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;
  final String city;
  final String street;
  final int addressNumber;
  final String zipcode;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.city,
    required this.street,
    required this.addressNumber,
    required this.zipcode,
  });

  String get fullName => '$firstName $lastName';

  String get fullAddress => '$street, $addressNumber, $city, $zipcode';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as Map<String, dynamic>;
    final address = json['address'] as Map<String, dynamic>;

    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      username: json['username'] as String,
      firstName: name['firstname'] as String,
      lastName: name['lastname'] as String,
      phone: json['phone'] as String,
      city: address['city'] as String,
      street: address['street'] as String,
      addressNumber: address['number'] as int,
      zipcode: address['zipcode'] as String,
    );
  }
}
