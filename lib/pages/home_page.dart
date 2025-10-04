import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaecone2g13/models/user_model.dart';
import 'package:firebaecone2g13/pages/streams/stream_firestore_page.dart';
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
                userReference
                    .where("age", isGreaterThan: 19)
                    .where("nationality", isEqualTo: "peruano")
                    .get()
                    .then((value) {
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
            ElevatedButton(
              onPressed: () {
                // Agregrando un usuario directamente desde un mapa
                // userReference
                //     .add({
                //       "name": "Ana",
                //       "lastname": "Lopez",
                //       "age": 25,
                //       "weight": 60.5,
                //       "nationality": "chilena",
                //     })
                //     .then((value) {
                //       print(value);
                //       print(value.id);
                //       print("Usuario agregado correctamente");
                //     })
                //     .catchError((error) {
                //       print("Error al agregar el usuario: $error");
                //     });

                // Agregando un usuario desde un modelo
                UserModel newUser = UserModel(
                  name: "Carlos",
                  lastname: "Gonzales",
                  age: 30,
                  weight: 75.5,
                  nationality: "peruano",
                );
                userReference
                    .add(newUser.toMap())
                    .then((value) {
                      print(value);
                      print(value.id);
                      print("Usuario agregado correctamente");
                    })
                    .catchError((error) {
                      print("Error al agregar el usuario: $error");
                    });
              },
              child: Text("Agregar un usuario"),
            ),
            ElevatedButton(
              onPressed: () {
                userReference
                    .doc("1PWbHs8po2GiW0foV2mA")
                    .set({
                      "name": "Merlina",
                      "lastname": "Addams",
                      "age": 28,
                      "weight": 54.3,
                      "nationality": "estadounidense",
                    })
                    .then((value) {
                      print("Usuario agregado con id específico");
                    })
                    .catchError((error) {
                      print("Error al agregar el usuario: $error");
                    });
              },
              child: Text("Inserción con id específico"),
            ),
            ElevatedButton(
              onPressed: () {
                userReference
                    .doc("user_1234562")
                    .update({"age": 31})
                    .then((value) {
                      print("Usuario actualizado correctamente");
                    })
                    .catchError((error) {
                      print("Error al actualizar el usuario: $error");
                    });
              },
              child: Text("Actualizar un usuario"),
            ),
            ElevatedButton(
              onPressed: () {
                userReference
                    .doc("1PWbHs8po2GiW0foV2mA")
                    .delete()
                    .then((value) {
                      print("Usuario eliminado correctamente");
                    })
                    .catchError((error) {
                      print("Error al eliminar el usuario: $error");
                    });
              },
              child: Text("Eliminar un usuario"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreamFirestorePage(),
                  ),
                );
              },
              child: Text("Streams"),
            ),
          ],
        ),
      ),
    );
  }
}
