import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaecone2g13/models/user_model.dart';
import 'package:firebaecone2g13/pages/user_info_page.dart';
import 'package:flutter/material.dart';

class FutureListPage extends StatelessWidget {
  FutureListPage({super.key});

  CollectionReference userReference = FirebaseFirestore.instance.collection(
    'users',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: userReference.get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> docs = querySnapshot.docs;
              List<UserModel> usersModelList = docs.map((doc) {
                return UserModel.fromMap(doc.data() as Map<String, dynamic>);
              }).toList();
              return ListView.builder(
                itemCount: usersModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UserInfoPage(
                                userModel: usersModelList[index],
                              );
                            },
                          ),
                        );
                      },
                      title: Text(
                        '${usersModelList[index].name} ${usersModelList[index].lastname}',
                      ),
                      subtitle: Text(
                        'Edad: ${usersModelList[index].age} - Nacionalidad: ${usersModelList}',
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
