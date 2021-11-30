import 'package:afolio06/auth/models/users_model.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  Rx<UsersModel> currentUser = UsersModel().obs;
}
