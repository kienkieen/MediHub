class APIRequest {
  int accountNo;
  String? accountName;
  int? acqId;
  double? amount;
  String? addInfo;
  String? format;
  String? template;

  APIRequest({
    this.accountNo = 123464576,
    this.accountName = 'xyz',
    this.acqId = 123456789,
    this.amount = 10000.0,
    this.addInfo = 'Payment for services',
    this.format = 'text',
    this.template = 'compact',
  });

  Map<String, dynamic> toJson() => {
    'accountNo': accountNo,
    'accountName': accountName,
    'acqId': acqId,
    'amount': amount,
    'addInfo': addInfo,
    'format': format,
    'template': template,
  };
}

class DataResponse {
  int? acpId;
  String? accountName;
  String? qrCode;
  String? qrDataURL;

  DataResponse({this.acpId, this.accountName, this.qrCode, this.qrDataURL});

  factory DataResponse.fromJson(Map<String, dynamic> json) => DataResponse(
    acpId: json['acpId'],
    accountName: json['accountName'],
    qrCode: json['qrCode'],
    qrDataURL: json['qrDataURL'],
  );
}

class APIResponse {
  String? code;
  String? desc;
  DataResponse? data;

  APIResponse({this.code, this.desc, this.data});

  factory APIResponse.fromJson(Map<String, dynamic> json) => APIResponse(
    code: json['code'],
    desc: json['desc'],
    data: json['data'] != null ? DataResponse.fromJson(json['data']) : null,
  );
}
