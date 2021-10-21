import 'package:intl/intl.dart';

class UserProfile {
  String _firstName;
  String _lastName;
  String _id;
  String _password;
  String _email;
  String _phoneNumber;
  String _birthDate;
  String _street;
  String _zipCode;
  String _departmentName;
  String _provider;
  DateTime _createdAt;

  UserProfile({
    String firstName,
    String street,
    String zipCode,
    String lastName,
    String password,
    String email,
    String departmentName,
    String phoneNumber,
    String birthDate,
    String provider,
    DateTime createdAt,
    String id,
  })  : _id = id,
        _email = email,
        _firstName = firstName,
        _lastName = lastName,
        _password = password,
        _phoneNumber = phoneNumber,
        _birthDate = birthDate,
        _street = street,
        _zipCode = zipCode,
        _departmentName = departmentName,
        _createdAt = createdAt,
        _provider = provider;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get password => _password;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get birthDate => _birthDate;
  String get street => _street;
  String get departmentName => _departmentName;
  String get zipCode => _zipCode;
  String get provider => _provider;
  DateTime get createdAt => _createdAt;
  String get id => _id;

  set id(id) => _id = id;
  set firstName(first) => _firstName = first;
  set lastName(last) => _lastName = last;
  set password(pass) => _password = pass;
  set email(mail) => _email = mail;
  set phoneNumber(phone) => _phoneNumber = phone;
  set birthDate(birth) => _birthDate = birth;
  set street(st) => _street = st;
  set departmentName(dn) => _departmentName = dn;
  set zipCode(dn) => _zipCode = dn;
  set provider(dn) => _provider = dn;
  set createdAt(dn) => _createdAt = dn;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      birthDate: json['birthDate'],
      street: json['street'],
      departmentName: json['departmentName'],
      zipCode: json['zipCode'],
      id: json['id'],
      // createdAt:
      //   DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(json['createdAt']),
      provider: json['zipCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['birthDate'] = this.birthDate;
    data['street'] = this.street;
    data['departmentName'] = this.departmentName;
    data['zipCode'] = this.zipCode;
    data['createdAt'] = this.createdAt;
    data['provider'] = this.provider;
    data['id'] = this.id;
    return data;
  }
}
