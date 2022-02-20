import 'package:nimbus/model/projectsModel.dart';
import 'package:get/get.dart';
import 'package:nimbus/services/databaseServices.dart';

class Controller extends GetxController {
  var count = 10.obs;
  List<ProjectsModel> p = <ProjectsModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProjects();
  }
  List<ProjectsModel> projectsData=[];
getProjects() async {
 projectsData=await DatabaseServices().getData();
 p=projectsData;
 print("getx  "+projectsData.first.projName);
}
}