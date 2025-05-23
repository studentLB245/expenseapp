import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
    required this.label,
    required this.icon,
  });

  final double fill;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade800,
                ),
              ),
              if (fill > 0)
                FractionallySizedBox(
                  heightFactor: fill.clamp(0.0, 1.0),
                  child: Container(
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.tealAccent,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
