import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String title, Color color, bool isWifi) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          isWifi != false
              ? const Icon(
                  Icons.wifi_off_rounded,
                  color: Color.fromARGB(255, 99, 115, 123),
                )
              : const Icon(
                  Icons.info,
                  color: Color.fromARGB(255, 99, 115, 123),
                ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(224, 23, 23, 23),
    ),
  );
}
