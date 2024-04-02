import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';



class PayApi {
  static var client = Dio(); 

  static Future<dynamic> pay(String amount) async {
  
      String theUrl = 'http://192.168.1.14:5000/api/payment/pay';
      try {
        Response response = await client
            .post(
              theUrl,
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
              // Stringify the updateFields before sending
              data: jsonEncode({
                "amount": amount,
                
              }),
            )
            .timeout(const Duration(seconds: 20));

        if (response.statusCode == 200) {
          print(response.data);
          return response.data;
        } else {
          throw Exception(response.data['error']);
        }
      } on TimeoutException catch (_) {
        throw Exception("Time Out"); // Throw exception on timeout
      } catch (e) {
        throw Exception(
            "Error updating user: $e"); // Catch all other exceptions
      }
  
  }

  static verifypay(String payment_id,) async {
 
    String theUrl = 'http://192.168.1.14:5000/api/payment/verifyPay/$payment_id';
    
    try {
      Response response = await client.get(
        theUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ).timeout(const Duration(seconds: 20));

      return response.data;
    } on TimeoutException catch (_) {
      throw Exception("Time Out");
    } catch (e) {
      throw Exception(" $e");
    }
 
}

}
