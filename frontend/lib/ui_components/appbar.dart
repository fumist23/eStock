import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final bool _useLeading;
  final bool _useActions;
  const AppBarComponent({
    super.key,
    required String title,
    required bool useLeading,
    required bool useActions,
  })  : _title = title,
        _useLeading = useLeading,
        _useActions = useActions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        _title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      leading: _useLeading
          ? const Icon(
              Icons.chevron_left_outlined,
              color: Colors.black,
            )
          : null,
      actions: _useActions
          ? const [
              Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
              )
            ]
          : null,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
