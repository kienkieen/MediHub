import 'package:intl/intl.dart';

class UserMain {
  String userId; // ID người dùng
  String fullName; // Họ tên
  String gender; // Giới tính (Male/Female/Other)
  String job; // Nghề nghiệp
  DateTime dateOfBirth; // Ngày sinh
  String phoneNumber; // Số điện thoại
  String numberBHYT; // Số bảo hiểm y tế
  String email; // Email
  String city; // Thành phố
  String district; // Quận huyện
  String ward; // Phường xã
  String address; // Địa chỉ
  String idCardNumber; // Số CCCD
  String ethnicity; // Dân tộc
  String nationality; // Quốc tịch

  UserMain({
    required this.userId,
    required this.fullName,
    required this.gender,
    this.job = 'Chưa xác định',
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.numberBHYT,
    required this.email,
    required this.city,
    required this.district,
    required this.ward,
    required this.address,
    required this.idCardNumber,
    required this.ethnicity,
    required this.nationality,
  });

  // Chuyển đổi thành Map để lưu vào Firebase
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'gender': gender,
      'job': job,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'phoneNumber': phoneNumber,
      'numberBHYT': numberBHYT,
      'email': email,
      'city': city,
      'district': district,
      'ward': ward,
      'address': address,
      'idCardNumber': idCardNumber,
      'ethnicity': ethnicity,
      'nationality': nationality,
    };
  }

  // Factory method để tạo User từ Firebase Document
  factory UserMain.fromMap(Map<String, dynamic> map) {
    return UserMain(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      gender: map['gender'] ?? 'Other',
      job: map['job'] ?? 'Chưa xác định',
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      phoneNumber: map['phoneNumber'] ?? '',
      numberBHYT: map['numberBHYT'] ?? '',
      email: map['email'] ?? '',
      city: map['city'] ?? '',
      district: map['district'] ?? '',
      ward: map['ward'] ?? '',
      address: map['address'] ?? '',
      idCardNumber: map['idCardNumber'] ?? '',
      ethnicity: map['ethnicity'] ?? '',
      nationality: map['nationality'] ?? 'Vietnam',
    );
  }

  // Tính tuổi (Age Calculator)
  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  // Định dạng ngày sinh (VD: 15/03/1990)
  String get formattedDateOfBirth {
    return DateFormat('dd/MM/yyyy').format(dateOfBirth);
  }
}

class AgeService {
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static String getAgeGroup(int age) {
    if (age < 1) return '0-1 tuổi';
    if (age <= 5) return '1-5 tuổi';
    if (age <= 18) return '6-18 tuổi';
    return 'Trên 18 tuổi';
  }
}
