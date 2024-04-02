import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payement_api.dart';


class PaymenController extends GetxController {
  RxBool isInitLoading = false.obs;
 

   Future<void> pay(String amount) async {
    try {
      isInitLoading(true);
      final response = await PayApi.pay(amount);

      if (response != null) {
        print(response);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("payment_id", response['result']['payment_id']);
        final Uri url = Uri.parse(response['result']['link']);
        if (!await launchUrl(
          url,
          mode: LaunchMode.inAppWebView
          )) {
          throw Exception('Could not launch $url');
        }
        
        
      } else {
        throw Exception("Error");
      }
    } catch (error) {
      throw Exception(error);
    } finally {
      isInitLoading(false);
      
    }
  }




RxBool isMakePayLoading = false.obs;

Future<void> verifypay() async {
  final prefs = await SharedPreferences.getInstance();
  final payment_id = prefs.getString("payment_id");

  print(payment_id);
  if (payment_id == null) {
    return;
  }
  try {
    isMakePayLoading(true);
    final response = await PayApi.verifypay(payment_id);
    if (response != null) {
      
      if (response['result']['status'] == "SUCCESS") {
        print(response['result']['status']);
      } else if (response['result']['status'] == "FAILURE") {
        print(response['result']['status']);
      } 
    } else {
      throw Exception("Error");
    }
  } catch (error) {
    throw Exception(error);
  } finally {
    isMakePayLoading(false);
    prefs.remove("payment_id");
  }
}

}
