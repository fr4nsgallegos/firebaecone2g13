import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaecone2g13/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  CollectionReference userReference = FirebaseFirestore.instance.collection(
    'users',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Firebase Core Initialized'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userReference.get().then((value) {
                  List<QueryDocumentSnapshot> docs = value.docs;
                  // docs.forEach((doc) {
                  //   print(doc.data());
                  // });
                  List<UserModel> usersModelList = docs.map((doc) {
                    return UserModel.fromMap(
                      doc.data() as Map<String, dynamic>,
                    );
                  }).toList();
                  usersModelList.forEach((user) {
                    print(user.name);
                    print(user.lastname);
                    print(user.age);
                    print(user.weight);
                    print(user.nationality);
                    print('---');
                  });
                });
              },
              child: Text('Obtener información'),
            ),
            ElevatedButton(
              onPressed: () {
                userReference.where("age", isGreaterThan: 19).get().then((
                  value,
                ) {
                  List<QueryDocumentSnapshot> docs = value.docs;
                  List<UserModel> usersModelList = docs.map((doc) {
                    return UserModel.fromMap(
                      doc.data() as Map<String, dynamic>,
                    );
                  }).toList();

                  usersModelList.forEach((user) {
                    print(user.name);
                    print(user.lastname);
                    print(user.age);
                    print(user.weight);
                  });
                });
              },
              child: Text("Obtener informacioón filtrada"),
            ),
          ],
        ),
      ),
    );
  }
}
