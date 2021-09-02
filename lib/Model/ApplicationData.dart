class ApplicationData {
  List<dynamic> closingHours;
  List<dynamic> openingHours;
  int versionId;
  String deviceToken;
 

  ApplicationData({required this.closingHours, required this.openingHours, required this.versionId, required this.deviceToken});

  ApplicationData.fromJson(Map<String, dynamic> json)
      : closingHours = json['closingHours'],
        openingHours = json['openingHours'],
        versionId = json['versionId'],
        deviceToken = json['deviceToken'];

  Map<String, dynamic> toJson() => {
        'closingHours': closingHours,
        'openingHours': openingHours,
        'versionId': versionId,
        'deviceToken': deviceToken,
      };
}