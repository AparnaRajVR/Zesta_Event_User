import 'package:get/get.dart';
import 'package:zesta_1/services/firebase_control.dart';

class InstanceBind extends Bindings{
  @override
  void dependencies() {
    
  Get.lazyPut<FirebaseControl>(()=>FirebaseControl());

  }

  
}