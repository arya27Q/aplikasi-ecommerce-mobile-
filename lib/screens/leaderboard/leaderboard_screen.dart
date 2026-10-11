import 'package:flutter/material.dart';
import 'widgets/podium_top_three.dart';
import 'widgets/leaderboard_rank_card.dart';

class LeaderboardUser {
  final int rank;
  final String name;
  final String points;
  final String avatarUrl;
  final String badge;

  const LeaderboardUser({
    required this.rank,
    required this.name,
    required this.points,
    required this.avatarUrl,
    required this.badge,
  });
}

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<LeaderboardUser> topUsers = const [
    LeaderboardUser(
      rank: 1,
      name: 'Rian Pratama',
      points: '12,450 Pts',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
      badge: '👑 Diamond Shopper',
    ),
    LeaderboardUser(
      rank: 2,
      name: 'Sarah Amanda',
      points: '10,200 Pts',
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      badge: '🥈 Platinum Tier',
    ),
    LeaderboardUser(
      rank: 3,
      name: 'Fikri Haikal',
      points: '8,950 Pts',
      avatarUrl: 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150',
      badge: '🥉 Gold Member',
    ),
    LeaderboardUser(
      rank: 4,
      name: 'Yudhis Master',
      points: '7,400 Pts',
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      badge: 'Silver Sneakerhead',
    ),
    LeaderboardUser(
      rank: 5,
      name: 'Dinda Kirana',
      points: '6,180 Pts',
      avatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
      badge: 'Bronze Collector',
    ),
    LeaderboardUser(
      rank: 6,
      name: 'Budi Santoso',
      points: '5,500 Pts',
      avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      badge: 'Active Explorer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Shopper Leaderboard',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 110),
        child: Column(
          children: [
            // PODIUM TOP 3 (Modular Widget)
            PodiumTopThree(topThree: topUsers.take(3).toList()),

            const SizedBox(height: 20),

            // SISA RANKING LIST (4, 5, 6, ...)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 12),
                    child: Text(
                      'Peringkat Lainnya',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...topUsers.skip(3).map((user) => LeaderboardRankCard(user: user)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
