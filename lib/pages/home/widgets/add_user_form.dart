import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/pages/home/home_controller.dart';

class UserForm extends StatelessWidget {
  const UserForm(
      {Key? key,
      required this.homeController,
      this.isUpdate = false,
      required this.onSubmit})
      : super(key: key);

  final HomeController homeController;
  final bool? isUpdate;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: homeController.nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: homeController.userNameController,
            decoration: const InputDecoration(
              labelText: 'UserName',
            ),
          ),
          TextField(
            controller: homeController.emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: homeController.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onSubmit,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(isUpdate! ? 'Update' : 'Add'),
            ),
          ),
        ],
      ),
    );
  }
}
