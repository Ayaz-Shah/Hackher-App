class HostSignUpModel {
  HostSignUpModel({
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.role,
    required this.dob,
    required this.isMenopause,
    required this.deviceType,
    required this.deviceToken,
    required this.city,
    required this.state,
    required this.country,
    required this.gender,
    required this.address,
    required this.contact,
  });

  // Fields for the Host Sign-Up Model
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String role;
  final String dob;
  final String isMenopause;
  final String deviceType;
  final String deviceToken;
  final String city;
  final String state;
  final String country;
  final String gender;
  final String address;
  final String contact;

  // Factory constructor to create an instance from JSON
  factory HostSignUpModel.fromJson(Map<String, dynamic> json) {
    return HostSignUpModel(
      fname: json['fname'] as String? ?? '',
      lname: json['lname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      role: json['role'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      isMenopause: json['is_menopause'] as String? ?? '',
      deviceType: json['device_type'] as String? ?? '',
      deviceToken: json['device_token'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      address: json['address'] as String? ?? '',
      contact: json['contact'] as String? ?? '',
    );
  }

  // Method to convert the object into JSON
  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'password': password,
      'role': role,
      'dob': dob,
      'is_menopause': isMenopause,
      'device_type': deviceType,
      'device_token': deviceToken,
      'city': city,
      'state': state,
      'country': country,
      'gender': gender,
      'address': address,
      'contact': contact,
    };
  }

  // Method to create a copy of the current instance with optional changes
  HostSignUpModel copyWith({
    String? fname,
    String? lname,
    String? email,
    String? password,
    String? role,
    String? dob,
    String? isMenopause,
    String? deviceType,
    String? deviceToken,
    String? city,
    String? state,
    String? country,
    String? gender,
    String? address,
    String? contact,
  }) {
    return HostSignUpModel(
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      dob: dob ?? this.dob,
      isMenopause: isMenopause ?? this.isMenopause,
      deviceType: deviceType ?? this.deviceType,
      deviceToken: deviceToken ?? this.deviceToken,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      contact: contact ?? this.contact,
    );
  }
}
