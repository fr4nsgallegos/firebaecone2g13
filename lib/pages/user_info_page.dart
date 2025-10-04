import 'package:firebaecone2g13/models/user_model.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  UserModel userModel;
  UserInfoPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nombre: ${userModel.name}'),
            Text('Apellido: ${userModel.lastname}'),
            Text('Edad: ${userModel.age}'),
            Text('Peso: ${userModel.weight}'),
            Text('Nacionalidad: ${userModel.nationality}'),
          ],
        ),
      ),
    );
  }
}
