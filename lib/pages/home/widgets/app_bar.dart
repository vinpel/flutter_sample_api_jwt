import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/data/repository/secure_storage_repository.dart';
import 'package:flutter_sample_api_jwt/di/service_locator.dart';
import 'package:flutter_sample_api_jwt/pages/login/login_page.dart';
import 'package:flutter_sample_api_jwt/pages/user_list/user_list_page.dart';

import 'package:ndialog/ndialog.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  const BaseAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = getIt<SecureStorageRepository>();
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: const Text('Users'),
      actions: [
        TextButton(
          child: const Text(
            '[List of user]',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserListPage(),
              ),
            );
          },
        ),
        TextButton(
          child: const Text(
            '[Erase token, go back LoginPage]',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            storage.deleteToken();
            NDialog(
              dialogStyle: DialogStyle(titleDivider: true),
              title: const Text("NDialog"),
              content:
                  const Text("Token have been deleted from secure storage"),
              actions: <Widget>[
                TextButton(
                    child: const Text("Okay"),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()))),
              ],
            ).show(context, transitionType: DialogTransitionType.Shrink);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
