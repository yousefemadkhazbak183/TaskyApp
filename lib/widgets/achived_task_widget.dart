import 'dart:math';

import 'package:flutter/material.dart';

class ArchivedTaskWidget extends StatelessWidget {
  ArchivedTaskWidget({
    super.key,
    required this.totalTasks,
    required this.totalDoneTasks,
    required this.percent,
  });

  int totalTasks = 0;

  int totalDoneTasks = 0;

  double percent = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achieved Tasks',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFFCFC),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "$totalDoneTasks Out of $totalTasks",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFC6C6C6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    value: percent,
                    backgroundColor: Color(0xFF6D6D6D),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF15B86C),
                    ),
                    strokeWidth: 5,
                  ),
                ),
              ),
              Text(
                "${percent * 100}%",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFFFCFC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
