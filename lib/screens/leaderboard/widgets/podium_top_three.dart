import 'package:flutter/material.dart';
import '../leaderboard_screen.dart';

class PodiumTopThree extends StatelessWidget {
  final List<LeaderboardUser> topThree;

  const PodiumTopThree({
    super.key,
    required this.topThree,
  });

  @override
  Widget build(BuildContext context) {
    if (topThree.length < 3) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24, bottom: 28, left: 16, right: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const Text(
            '🏆 Top Spender of the Month',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD32F2F),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Dapatkan cashback & voucher eksklusif',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Rank 2 (Silver)
              _buildPodiumItem(
                user: topThree[1],
                height: 140,
                medalColor: const Color(0xFFC0C0C0),
                medalIcon: '2',
              ),
              const SizedBox(width: 12),
              // Rank 1 (Gold - Paling Tinggi)
              _buildPodiumItem(
                user: topThree[0],
                height: 175,
                medalColor: const Color(0xFFFFD700),
                medalIcon: '1',
                isWinner: true,
              ),
              const SizedBox(width: 12),
              // Rank 3 (Bronze)
              _buildPodiumItem(
                user: topThree[2],
                height: 125,
                medalColor: const Color(0xFFCD7F32),
                medalIcon: '3',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumItem({
    required LeaderboardUser user,
    required double height,
    required Color medalColor,
    required String medalIcon,
    bool isWinner = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: isWinner ? 36 : 28,
              backgroundColor: medalColor,
              child: CircleAvatar(
                radius: isWinner ? 33 : 26,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
            ),
            Positioned(
              bottom: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: medalColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Text(
                  medalIcon,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          user.name.split(' ')[0],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isWinner ? 15 : 13,
          ),
        ),
        Text(
          user.points,
          style: TextStyle(
            color: const Color(0xFFD32F2F),
            fontWeight: FontWeight.w800,
            fontSize: isWinner ? 13 : 11,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: height - 80,
          decoration: BoxDecoration(
            color: isWinner ? const Color(0xFF111111) : Colors.grey.shade200,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          alignment: Alignment.center,
          child: Text(
            '#${user.rank}',
            style: TextStyle(
              color: isWinner ? Colors.white : Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
