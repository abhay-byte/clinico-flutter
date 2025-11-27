import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class AiChatDrawer extends StatelessWidget {
  final List<String> recentConversations;
  final VoidCallback? onHomeTap;

  const AiChatDrawer({
    super.key,
    required this.recentConversations,
    this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Home Icon Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: onHomeTap ?? () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                child: Image.asset(
                  'assets/ai_chat/home_outline.png',
                  width: 32,
                  height: 32,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(height: 1),
            // Section Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  'Your Conversations',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            // Conversation List
            Expanded(
              child: ListView.builder(
                itemCount: recentConversations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(
                      'assets/ai_chat/message_outline.png',
                      width: 28,
                      height: 28,
                      color: Colors.black,
                    ),
                    title: Text(
                      recentConversations[index],
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      // TODO: Navigate to the specific chat session
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
