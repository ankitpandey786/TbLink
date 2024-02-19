import 'package:flutter/material.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ElevatedButton(
        onPressed: () { },
        child: const Text("LOG OUT"),
      )
    );
  }
}
