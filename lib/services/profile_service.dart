import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_client.dart';

class ProfileData {
  final int userId;
  final int personId;
  final int? clientId;
  final String email;
  final String role;
  final String firstName;
  final String lastName;
  final String? secondName;
  final String? thirdName;
  final String? phone;
  final String? gender;
  final String? profileImageUrl;
  final String? countryName;
  final int countryId;
  final DateTime? birthDate;

  const ProfileData({
    required this.userId,
    required this.personId,
    this.clientId,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.secondName,
    this.thirdName,
    this.phone,
    this.gender,
    this.profileImageUrl,
    this.countryName,
    required this.countryId,
    this.birthDate,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      userId:          json['userId']   as int,
      personId:        json['personId'] as int,
      clientId:        json['clientId'] as int?,
      email:           (json['email']     as String? ?? ''),
      role:            (json['role']      as String? ?? ''),
      firstName:       (json['firstName'] as String? ?? ''),
      lastName:        (json['lastName']  as String? ?? ''),
      secondName:       json['secondName']     as String?,
      thirdName:        json['thirdName']      as String?,
      phone:            json['phone']          as String?,
      gender:           json['gender']         as String?,
      profileImageUrl:  json['profileImageUrl'] as String?,
      countryName:      json['countryName']    as String?,
      countryId:        (json['countryId'] as int? ?? 0),
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'] as String)
          : null,
    );
  }
}

class ProfileService {
  /// GET /api/profile/me
  static Future<ProfileData> getMyProfile(String token) async {
    final res = await ApiClient.get('/api/profile/me', token);
    return ProfileData.fromJson(ApiClient.decodeMap(res));
  }

  /// PUT /api/profile/me
  static Future<void> updateProfile({
    required Map<String, dynamic> fields,
    required String token,
  }) async {
    await ApiClient.put('/api/profile/me', fields, token);
  }

  /// POST /api/profile/me/image  (multipart)
  static Future<void> uploadAvatar({
    required File image,
    required String token,
  }) async {
    final file = await http.MultipartFile.fromPath('image', image.path);
    await ApiClient.postMultipart(
      '/api/profile/me/image',
      {},
      {'image': file},
      token,
    );
  }
}
