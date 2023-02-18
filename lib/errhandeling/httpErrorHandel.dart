import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:m_steel/util/general.dart';

void httpErrorHandel({
  required BuildContext context,
  required http.Response res,
  required VoidCallback onSuccess,
}) async {
  if (res.statusCode == 200) {
    onSuccess();
  } else if (res.statusCode == 400 || res.statusCode == 401) {
    showSnackBar(context, jsonDecode(res.body)["msg"]);
    Navigator.pop(context);
  } else if (res.statusCode == 500 || res.statusCode == 501) {
    showSnackBar(context, jsonDecode(res.body)["error"]);
    Navigator.pop(context);
  } else {
    showSnackBar(context, jsonDecode(res.body));
    Navigator.pop(context);
  }
}
