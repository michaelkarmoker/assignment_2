import 'package:assignment_2/controller/home_controller.dart';
import 'package:assignment_2/data/repository/home_repo.dart';

import 'package:get/get.dart';





import '../data/api/api_client.dart';

import 'app_constants.dart';

Future<void> init() async {
/// this is dependency injection

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL ));

  //repo
  Get.lazyPut(() => HomeRepo(apiClient: Get.find() ));
  //controller
  Get.lazyPut(() => HomeController( homeRepo: Get.find()));








}
