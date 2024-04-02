import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'payementController.dart';

void main() {
  PaymenController paymenController = Get.put(PaymenController());
  paymenController.verifypay();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  PaymenController paymenController = Get.put(PaymenController());
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pay Page'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              paymenController.pay('100');
              print('Payment processing...');
            },
            child: Obx(() {
              return paymenController.isInitLoading.value
                  ? CircularProgressIndicator()
                  : Text('Pay Now');
            }),
          ),
        ),
      ),
    );
  }
}
