import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vibe Social',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final _pages = [const FeedPage(), const SearchPage(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: const Color(0xFF6C63FF),
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.explore_rounded), label: 'Explore'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final names = ['Alex Chen', 'Jordan Lee', 'Sam Rivera', 'Taylor Swift', 'Morgan Blake', 'Casey Park', 'Riley Storm', 'Avery Moon', 'Quinn Fox', 'Drew Stone'];
  final posts = ['Just had an amazing day! 🌟', 'Check out this view 🏔️', 'Coffee time ☕', 'New adventure begins 🚀', 'Feeling grateful 💜', 'Sunset vibes 🌅', 'Weekend mood 🎉', 'Making memories 📸', 'Living my best life ✨', 'Good vibes only 🌈'];
  final avatarColors = [Color(0xFFFF6B9D), Color(0xFF4ECDC4), Color(0xFFFFA07A), Color(0xFF9B59B6), Color(0xFF3498DB), Color(0xFFE74C3C), Color(0xFF1ABC9C), Color(0xFFF39C12), Color(0xFF34495E), Color(0xFF16A085)];
  final gradients = [
    [Color(0xFFFF6B9D), Color(0xFFFFC371)],
    [Color(0xFF4ECDC4), Color(0xFF556270)],
    [Color(0xFFFFA07A), Color(0xFFFF7F50)],
    [Color(0xFF9B59B6), Color(0xFF3498DB)],
    [Color(0xFF3498DB), Color(0xFF2ECC71)],
  ];
  final likes = <int, int>{};
  final bookmarks = <int>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Vibe Social', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6C63FF), fontSize: 24)),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border_rounded, color: Color(0xFF6C63FF)), onPressed: () {}),
          IconButton(icon: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF6C63FF)), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final random = Random(index);
          final likeCount = likes[index] ?? random.nextInt(500);
          final commentCount = random.nextInt(50);
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [avatarColors[index % avatarColors.length], avatarColors[index % avatarColors.length].withOpacity(0.7)])),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Text(names[index][0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ),
                  title: Text(names[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: Text('${random.nextInt(24)}h ago', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  trailing: IconButton(icon: const Icon(Icons.more_horiz_rounded), onPressed: () {}),
                ),
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradients[index % gradients.length], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Center(child: Icon(Icons.image_rounded, size: 80, color: Colors.white.withOpacity(0.8))),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(likes.containsKey(index) ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: likes.containsKey(index) ? const Color(0xFFFF6B9D) : Colors.grey[700]),
                            onPressed: () => setState(() => likes.containsKey(index) ? likes.remove(index) : likes[index] = likeCount + 1),
                          ),
                          Text('${likes[index] ?? likeCount}', style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 16),
                          IconButton(icon: Icon(Icons.chat_bubble_outline_rounded, color: Colors.grey[700]), onPressed: () {}),
                          Text('$commentCount', style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 16),
                          IconButton(icon: Icon(Icons.send_rounded, color: Colors.grey[700]), onPressed: () {}),
                          const Spacer(),
                          IconButton(
                            icon: Icon(bookmarks.contains(index) ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: bookmarks.contains(index) ? const Color(0xFF6C63FF) : Colors.grey[700]),
                            onPressed: () => setState(() => bookmarks.contains(index) ? bookmarks.remove(index) : bookmarks.add(index)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black87, fontSize: 14),
                            children: [
                              TextSpan(text: '${names[index]} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: posts[index]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gradients = [
      [Color(0xFFFF6B9D), Color(0xFFFFC371)],
      [Color(0xFF4ECDC4), Color(0xFF556270)],
      [Color(0xFFFFA07A), Color(0xFFFF7F50)],
      [Color(0xFF9B59B6), Color(0xFF3498DB)],
      [Color(0xFF3498DB), Color(0xFF2ECC71)],
      [Color(0xFFE74C3C), Color(0xFFF39C12)],
      [Color(0xFF1ABC9C), Color(0xFF16A085)],
      [Color(0xFFF39C12), Color(0xFFE67E22)],
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          height: 40,
          decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(20)),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search posts, people...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[600]),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(4),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemCount: 30,
        itemBuilder: (context, index) {
          final random = Random(index + 50);
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradients[index % gradients.length], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Center(child: Icon(Icons.image_rounded, size: 40, color: Colors.white.withOpacity(0.6))),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.favorite, size: 12, color: Colors.white),
                        const SizedBox(width: 4),
                        Text('${random.nextInt(999)}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random(42);
    final gradients = [
      [Color(0xFFFF6B9D), Color(0xFFFFC371)],
      [Color(0xFF4ECDC4), Color(0xFF556270)],
      [Color(0xFFFFA07A), Color(0xFFFF7F50)],
      [Color(0xFF9B59B6), Color(0xFF3498DB)],
      [Color(0xFF3498DB), Color(0xFF2ECC71)],
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Profile', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.settings_rounded, color: Color(0xFF6C63FF)), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))]),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF9B59B6)])),
                      padding: const EdgeInsets.all(3),
                      child: const CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFF6C63FF),
                          child: Text('ME', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [Text('${random.nextInt(100)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF6C63FF))), const SizedBox(height: 4), Text('Posts', style: TextStyle(color: Colors.grey[600], fontSize: 13))]),
                          Column(children: [Text('${random.nextInt(1000)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF6C63FF))), const SizedBox(height: 4), Text('Followers', style: TextStyle(color: Colors.grey[600], fontSize: 13))]),
                          Column(children: [Text('${random.nextInt(500)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF6C63FF))), const SizedBox(height: 4), Text('Following', style: TextStyle(color: Colors.grey[600], fontSize: 13))]),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Alex Morgan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text('Living life one post at a time 🌟', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                      const SizedBox(height: 2),
                      Text('📍 San Francisco, CA', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                  ),
                  child: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
              itemCount: 15,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradients[index % gradients.length], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Icon(Icons.image_rounded, size: 40, color: Colors.white.withOpacity(0.7))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
