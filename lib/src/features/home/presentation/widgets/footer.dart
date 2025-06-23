import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FooterApp extends StatelessWidget {
  final String username;
  final dynamic expiresAt;

  const FooterApp({
    super.key,
    required this.username,
    required this.expiresAt,
  });

  String _formatDate(dynamic input) {
    if (input == null || input == 'Unlimited') return 'Unlimited';
    try {
      final dateTime = DateTime.tryParse(input);
      return dateTime != null
          ? DateFormat('yyyy-MM-dd HH:mm').format(dateTime)
          : 'Invalid';
    } catch (e) {
      return 'Invalid';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Expiration: ${_formatDate(expiresAt)}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "Username: $username",
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
