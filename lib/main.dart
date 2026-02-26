import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibe Social',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
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
  final names = ['Alex', 'Jordan', 'Sam', 'Taylor', 'Morgan', 'Casey', 'Riley', 'Avery', 'Quinn', 'Drew'];
  final posts = ['Just had an amazing day! 🌟', 'Check out this view 🏔️', 'Coffee time ☕', 'New adventure begins 🚀', 'Feeling grateful 💜', 'Sunset vibes 🌅', 'Weekend mood 🎉', 'Making memories 📸', 'Living my best life ✨', 'Good vibes only 🌈'];
  final colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.teal, Colors.pink, Colors.indigo, Colors.cyan, Colors.amber];
  final likes = <int, int>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vibe Social', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purple,
        actions: [IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {})],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final random = Random(index);
          final likeCount = likes[index] ?? random.nextInt(500);
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colors[index % colors.length],
                    child: Text(names[index][0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  title: Text(names[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${random.nextInt(24)}h ago'),
                  trailing: const Icon(Icons.more_vert),
                ),
                Container(
                  height: 200,
                  color: colors[index % colors.length].withOpacity(0.3),
                  child: Center(child: Icon(Icons.image, size: 80, color: colors[index % colors.length])),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(likes.containsKey(index) ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                            onPressed: () => setState(() => likes.containsKey(index) ? likes.remove(index) : likes[index] = likeCount + 1),
                          ),
                          IconButton(icon: const Icon(Icons.comment_outlined), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),
                          const Spacer(),
                          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('${likes[index] ?? likeCount} likes', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black),
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
    final colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.teal, Colors.pink, Colors.amber, Colors.indigo, Colors.cyan, Colors.lime, Colors.deepOrange];
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
        itemCount: 30,
        itemBuilder: (context, index) {
          return Container(
            color: colors[index % colors.length],
            child: Center(child: Icon(Icons.image, size: 40, color: Colors.white.withOpacity(0.7))),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.purple,
        actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.purple,
                  child: const Text('ME', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [Text('${random.nextInt(100)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const Text('Posts')]),
                      Column(children: [Text('${random.nextInt(1000)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const Text('Followers')]),
                      Column(children: [Text('${random.nextInt(500)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const Text('Following')]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Name', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text('Living life one post at a time 🌟'),
                const Text('📍 Somewhere amazing'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 32)),
              child: const Text('Edit Profile'),
            ),
          ),
          const Divider(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemCount: 15,
              itemBuilder: (context, index) {
                final colors = [Colors.purple, Colors.blue, Colors.teal, Colors.orange, Colors.pink];
                return Container(
                  color: colors[index % colors.length],
                  child: Center(child: Icon(Icons.image, size: 40, color: Colors.white.withOpacity(0.7))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
