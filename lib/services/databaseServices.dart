import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nimbus/model/projectsModel.dart';

class DatabaseServices{
  //  Future<dynamic>getProjects() async{
  //   List<ProjectsModel> age=[];
  //   // FirebaseFirestore.instance
  //   //     .collection('projects')
  //   //     .get()
  //   //     .then((QuerySnapshot querySnapshot) {
  //   //   querySnapshot.docs.forEach((doc) {
  //   //     age.add(doc["dec"]);
  //   //     age.add(doc["name"]);
  //   //     age.add(doc["imgUrl"]);
  //   //
  //   //   });
  //   FirebaseFirestore.instance.collection('projects').snapshots();
  //     print(age);
  //
  //   });
  //   return age;
  // }
CollectionReference _collectionRef =
FirebaseFirestore.instance.collection('projects');

Future<dynamic> getData() async {
  List<ProjectsModel> _list = [];
  final QuerySnapshot result =
  await FirebaseFirestore.instance.collection('projects').get();
  final List<DocumentSnapshot> documents = result.docs;
  documents.forEach((element) {
    Map<String, dynamic> map = element.data() as  Map<String, dynamic>;
    _list.add(ProjectsModel.fromJson(map));
  });
  return _list;
}
  // Get docs from collection reference

}
