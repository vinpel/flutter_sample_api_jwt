import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/data/models/user_model.dart';
import 'package:flutter_sample_api_jwt/di/service_locator.dart';
import 'package:flutter_sample_api_jwt/pages/home/home_controller.dart';
import 'package:flutter_sample_api_jwt/pages/home/widgets/chg_pwd_form.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final homeController = getIt.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of user from my_backend'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: homeController.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text(
                "Error: $error",
              ),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: homeController.listOfUsers.length,
              itemBuilder: (context, index) {
                final UserModel user = homeController.listOfUsers[index];
                return ListTile(
                  onLongPress: () async {
                    /*await homeController.deleteUser(index).then((value) {
                  setState(() {});
                }).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User Deleted Successfully'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                });*/
                  },
                  onTap: () {
                    homeController.emailController.text = user.email!;
                    homeController.userNameController.text = user.username!;
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ChangePasswordForm(
                          homeController: homeController,
                          isUpdate: true,
                          onSubmit: () async {
                            await homeController
                                .updateUserPassword(
                              homeController.userNameController.text,
                              homeController.passwordController.text,
                              homeController.nextPasswordController.text,
                              homeController.disconnectOtherSession ?? false,
                            )
                                .then((value) {
                              Navigator.pop(context);
                              setState(() {});
                            });
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('User Password Updated Successfully'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  leading: Text((index + 1).toString()),
                  title: Text(user.username!),
                  subtitle: Text(user.email!),
                );
              },
            );
          }
          return Material(
            color: Colors.white,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  Text("Searching token in secure_storage"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
