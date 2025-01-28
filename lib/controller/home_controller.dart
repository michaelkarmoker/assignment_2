import 'dart:async';
import 'dart:convert';

import 'package:assignment_2/data/repository/home_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/model/response/university_list_response.dart';
import '../util/debouncer.dart';
import '../view/base/custom_snackbar.dart';

class HomeController extends GetxController  {
    final HomeRepo homeRepo;
    HomeController({required this.homeRepo});

 RxBool   isLoading = false.obs;

 TextEditingController searchCtr=new TextEditingController();
 FocusNode searchFcs=new FocusNode();
 String searchText="Bangladesh";
 RxList<UniversityListResponse> universityList =new RxList();
 var filteredUniversities = <UniversityListResponse>[].obs;
 final Debouncer debouncer = Debouncer(milliseconds: 300);

  @override
  void onInit() {
    //initially calling the api
    getUniversityList();

    searchCtr.addListener(() {
      /// debouncer for delay on search
      debouncer.run(() {
        filterUniversities(searchCtr.text);
      });

    });
    super.onInit();

  }

///Get university list from api
    Future<void> getUniversityList() async {
       isLoading.value = true;

      Response response = await homeRepo.getUniversityList(countryName: searchText);
      if (response.statusCode == 200) {
        try{
          universityList.value=(response.body as List).map((data)=>UniversityListResponse.fromJson(data)).toList();

          filteredUniversities.value=universityList;

        }catch(e){
          showCustomSnackBar(e.toString());
        }
      } else {
        // ApiChecker.checkApi(jsonDecode(response.statusCode));
        showCustomSnackBar(response.statusCode!.toString());
      }
       isLoading.value = false;

    }
///filter university list by search text
    void filterUniversities(String query) {
      if (query.isEmpty) {
         print("no text--------");
        filteredUniversities.value=universityList;
      } else {
        print("text is ${query}");
        filteredUniversities.value=[];
        universityList.map((d){
          if(d.name!.toLowerCase().contains(query.toLowerCase())){
            filteredUniversities.value.add(d);
          }
        } ).toList();
      }
    }

    /// Debouncer for delaying search
    Map<Function, Timer> _timeouts = {};
    void debounce(Duration timeout, Function target, [List arguments = const []]) {
      if (_timeouts.containsKey(target)) {
        _timeouts[target]?.cancel();
      }

      Timer timer = Timer(timeout, () {
        Function.apply(target, arguments);
      });

      _timeouts[target] = timer;
    }
}