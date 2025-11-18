import 'package:flutter/material.dart';

class AiFirstChatScreen extends StatefulWidget {
  const AiFirstChatScreen({Key? key}) : super(key: key);

  @override
  State<AiFirstChatScreen> createState() => _AiFirstChatScreenState();
}

class _AiFirstChatScreenState extends State<AiFirstChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _userMessage;
  List<Widget> _attachments = [
    // Example image and document preview
    ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'assets/ai_firstchat.png',
        width: 64,
        height: 64,
        fit: BoxFit.cover,
      ),
    ),
    Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/ai_chat/upload_document.png',
            width: 28,
            height: 28,
          ),
          const SizedBox(height: 4),
          const Text(
            'Rash_something...',
            style: TextStyle(fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _userMessage = _controller.text.trim();
      _isLoading = true;
    });
    // Simulate AI response delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF3F6FAFF),
      body: SafeArea(
        child: Column(
          children: [
            // Status bar is handled by the OS
            // Top bar with back arrow (chevron)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.grey,
                      size: 36,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Conversation area
            if (_userMessage != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: _attachments,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 260),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          _userMessage!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
            if (_isLoading) ...[
              const SizedBox(height: 24),
              Image.asset('assets/ai_chat/loading.png', width: 64, height: 64),
              const SizedBox(height: 16),
              const Text(
                'Generating response...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
            const Spacer(),
            // Input bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/ai_chat/plus.png',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {}, // TODO: Add upload menu
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Ask any medical query...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 8,
                          ),
                        ),
                        style: const TextStyle(fontSize: 15),
                        minLines: 1,
                        maxLines: 3,
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/ai_chat/send.png',
                        width: 28,
                        height: 28,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
