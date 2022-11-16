import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/pages/home/home_controller.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm(
      {Key? key,
      required this.homeController,
      this.isUpdate = false,
      required this.onSubmit})
      : super(key: key);

  final HomeController homeController;
  final bool? isUpdate;
  final VoidCallback onSubmit;

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  bool? checkedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.homeController.userNameController,
            readOnly: true,
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'UserName',
            ),
          ),
          CheckboxListTile(
            title: const Text("Invalidate all connexion (this one included)"),
            value: widget.homeController.disconnectOtherSession,
            onChanged: (newValue) {
              setState(() {
                widget.homeController.disconnectOtherSession = newValue;
              });
            },
            controlAffinity: ListTileControlAffinity.platform,
          ),
          TextField(
            controller: widget.homeController.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Old Password',
            ),
          ),
          TextField(
            controller: widget.homeController.nextPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'New Password',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.onSubmit,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.isUpdate! ? 'Update' : 'Add'),
            ),
          ),
        ],
      ),
    );
  }
}
