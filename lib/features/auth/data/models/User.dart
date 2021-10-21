class UserModel {
  String _firstName;
  String _lastName;
  String _password;
  String _email;
  String _phoneNumber;
  String _birthDate;
  String _street;
  String _zipCode;
  int _departmentIdentifier;

  UserModel({
    String firstName,
    String street,
    String zipCode,
    String lastName,
    String password,
    String email,
    int departmentIdentifier,
    String phoneNumber,
    String birthDate,
  })  : _email = email,
        _firstName = firstName,
        _lastName = lastName,
        _password = password,
        _phoneNumber = phoneNumber,
        _birthDate = birthDate,
        _street = street,
        _zipCode = zipCode,
        _departmentIdentifier = departmentIdentifier;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get password => _password;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get birthDate => _birthDate;
  String get street => _street;
  int get departmentIdentifier => _departmentIdentifier;
  String get zipCode => _zipCode;

  set firstName(first) => _firstName = first;
  set lastName(last) => _lastName = last;
  set password(pass) => _password = pass;
  set email(mail) => _email = mail;
  set phoneNumber(phone) => _phoneNumber = phone;
  set birthDate(birth) => _birthDate = birth;
  set street(st) => _street = st;
  set departmentIdentifier(dn) => _departmentIdentifier = dn;
  set zipCode(dn) => _zipCode = dn;

  UserModel.fromJson(Map<String, dynamic> json) {
    this._firstName = json['firstName'];
    this._lastName = json['lastName'];
    this._password = json['password'];
    this._email = json['email'];
    this._phoneNumber = json['phoneNumber'];
    this._birthDate = json['birthDate'];
    this._street = json['street'];
    this._departmentIdentifier = json['departmentIdentifier'];
    this._zipCode = json['zipCode'];
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
    data['departmentIdentifier'] = this.departmentIdentifier;
    data['zipCode'] = this.zipCode;
    return data;
  }
}
