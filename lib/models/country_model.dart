class CountryModel {
  final int countryId;
  final String countryName;

  const CountryModel({required this.countryId, required this.countryName});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryId:   json['countryID']   as int,
      countryName: (json['countryName'] as String? ?? '').trim(),
    );
  }
}
