import 'package:flutter/material.dart';
import '../leaderboard_screen.dart';

class LeaderboardRankCard extends StatelessWidget {
  final LeaderboardUser user;

  const LeaderboardRankCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            '#${user.rank}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(width: 14),
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  user.badge,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            user.points,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              color: Color(0xFFD32F2F),
            ),
          ),
        ],
      ),
    );
  }
}
