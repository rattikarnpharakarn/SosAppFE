class ReturnResponse {
  String message = '';
  String code = '';
  // ignore: prefer_typing_uninitialized_variables
  final data;

  ReturnResponse({
    required this.message,
    required this.code,
    this.data,
  });

  factory ReturnResponse.fromJson(Map<String, dynamic> json) {
    return ReturnResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }

  // Map toJson() {
  //   return {
  //     'code': code,
  //     'message': message,
  //     'data': data,
  //   };
  // }
}
