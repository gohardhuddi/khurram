import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:layout/layout.dart';
import 'package:nimbus/presentation/routes/router.gr.dart';
import 'package:nimbus/values/values.dart';
import 'app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isAndroid){
  //   await Firebase.initializeApp();
  // }
  // else{ await Firebase.initializeApp(
  //     options: FirebaseOptions(apiKey: "AIzaSyCcV0gMnldVkdvKX3s1jqhDyHNhyFKUaUI", appId: "1:8223601843:web:2e2030764debf308cbacc6", messagingSenderId: "8223601843", projectId: "khurramshahzad-37e0c")
  // );}
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: "AIzaSyCcV0gMnldVkdvKX3s1jqhDyHNhyFKUaUI", appId: "1:8223601843:web:2e2030764debf308cbacc6", messagingSenderId: "8223601843", projectId: "khurramshahzad-37e0c")
  );

  runApp(Nimbus());
}

class Nimbus extends StatefulWidget {
  @override
  State<Nimbus> createState() => _NimbusState();
}

class _NimbusState extends State<Nimbus> {
  final _appRouter = AppRouter();
@override
void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // addUser(users);
    getuser();

  }
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetMaterialApp.router(
        title: StringConst.APP_NAME,
        theme: AppTheme.lightThemeData,
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
  // Future<void> addUser(var users) {
  //   // Call the user's CollectionReference to add a new user
  //   return users
  //       .add({
  //     'full_name': "abc", // John Doe
  //     'company': "abc", // Stokes and Sons
  //     'age': "17" // 42
  //   })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
Future<void> getuser()async{
  List<dynamic> age=[];
  FirebaseFirestore.instance
      .collection('projects')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
   age.add(doc["dec"]);
      age.add(doc["name"]);
      age.add(doc["imgUrl"]);

    });
    print(age);
  });
}
}
