import 'package:cosmic_post_office_main/constant/constant_view.dart';
import 'package:flutter/material.dart';

class SMHelper {
  static void msgSnackBar(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void msgMaterialBanner(BuildContext ctx, String title, String body) {
    ScaffoldMessenger.of(ctx).removeCurrentMaterialBanner();
    ScaffoldMessenger.of(ctx).showMaterialBanner(
      MaterialBanner(
        overflowAlignment: OverflowBarAlignment.start,
        backgroundColor: Constants.primaryColorBlack,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            Text(
              body,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(ctx).hideCurrentMaterialBanner();
              },
              child: const Text(
                'Ok',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              )),
        ],
      ),
    );
  }
}
