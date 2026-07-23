import 'package:flutter/material.dart';

class ApiEmpty extends StatelessWidget {
  final String title;
  final IconData icon;

  const ApiEmpty({
    super.key,
    this.title = "No data found",
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}