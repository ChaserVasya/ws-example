import 'package:get_ip_address/get_ip_address.dart';

void main() async {
  try {
    var ipAddress = IpAddress(type: RequestType.json);
    dynamic data = await ipAddress.getIpAddress();
    print(data.toString());
  } on IpAddressException catch (exception) {
    print(exception.message);
  }
}
