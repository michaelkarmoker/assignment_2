import 'package:get/get_connect/http/src/response/response.dart';

import '../../util/app_constants.dart';
import '../api/api_client.dart';

class HomeRepo{
  HomeRepo({required this.apiClient});
  final ApiClient apiClient;


  Future<Response> getUniversityList({
    required String  countryName,

  }) async {
    Response _response = await apiClient.getData(AppConstants.UNIVERSITY_SEARCH ,query: {"country":countryName});
    return _response;
  }
}