import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/di/service_locator.dart';
import 'package:flutter_sample_api_jwt/pages/home/home_controller.dart';
import 'package:flutter_sample_api_jwt/pages/user_list/user_list_page.dart';
import 'package:flutter_sample_api_jwt/pages/home/widgets/add_user_form.dart';

class AddUserBtn extends StatefulWidget {
  const AddUserBtn({
    Key? key,
  }) : super(key: key);

  @override
  State<AddUserBtn> createState() => _AddUserBtnState();
}

class _AddUserBtnState extends State<AddUserBtn> {
  final homeController = getIt<HomeController>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return UserForm(
              homeController: homeController,
              onSubmit: () async {
                await homeController.addNewUser().then((value) {
                  Navigator.pop(context);
                  setState(() {});
                });
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User Updated Successfully'),
                    duration: Duration(seconds: 1),
                  ),
                );

                Navigator.pop(context);
                homeController.nameController.clear();
                homeController.userNameController.clear();
                homeController.emailController.clear();
                homeController.passwordController.clear();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserListPage(),
                  ),
                );
              },
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
