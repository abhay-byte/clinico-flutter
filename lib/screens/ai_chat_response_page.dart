import 'package:flutter/material.dart';

class AiChatResponsePage extends StatelessWidget {
  const AiChatResponsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // 1. Medical Disclaimer and Professional Advice
            _MedicalDisclaimer(),
            const SizedBox(height: 24),
            // 2. Action Block (Call-to-Action)
            _ActionBlock(),
            const Spacer(),
            // 3. Input Composer and Keyboard
            _InputComposer(),
          ],
        ),
      ),
    );
  }
}

class _MedicalDisclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Important Disclaimer: This is not a diagnosis.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2A3A4D),
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Rashes can be complex and require a professional evaluation to determine the exact cause. I strongly recommend consulting a dermatologist for an accurate diagnosis and appropriate treatment plan.',
            style: TextStyle(fontSize: 15, color: Color(0xFF2A3A4D)),
          ),
        ],
      ),
    );
  }
}

class _ActionBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF2563EB).withOpacity(0.08),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Would you like me to help you find a dermatologist or book an appointment?',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Book Appointment'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('More Information'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InputComposer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: const Color(0xFFF7FAFF),
      child: Row(
        children: [
          Image.asset('assets/ai_chat/plus.png', width: 28, height: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ask any medical query...',
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Image.asset('assets/ai_chat/send.png', width: 28, height: 28),
        ],
      ),
    );
  }
}
