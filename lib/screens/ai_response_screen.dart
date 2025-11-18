import 'package:flutter/material.dart';
import 'appointment_search_page.dart';

class AiResponseScreen extends StatefulWidget {
  const AiResponseScreen({super.key});

  @override
  State<AiResponseScreen> createState() => _AiResponseScreenState();
}

class _AiResponseScreenState extends State<AiResponseScreen> {
  final bool _isLoading = false; // Simulate loading state
  final bool _responseLoaded =
      true; // Set to true to show response and action block

  void _navigateToAppointmentSearch() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AppointmentSearchPage()),
    );
  }

  void _showMoreInfo() {
    // TODO: Implement more info navigation or dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('More information coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: Column(
          children: [
            _StatusBarAndHeader(),
            _UserQueryWithAttachments(),
            const SizedBox(height: 12),
            if (_isLoading)
              Column(
                children: const [
                  SizedBox(height: 32),
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Generating response...'),
                ],
              )
            else ...[
              _AiResponseBubble(),
              if (_responseLoaded)
                AiActionBlock(
                  onBookAppointment: _navigateToAppointmentSearch,
                  onMoreInfo: _showMoreInfo,
                ),
            ],
            const Spacer(),
            _InputComposer(),
          ],
        ),
      ),
    );
  }
}

class _StatusBarAndHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Image.asset('assets/ai_chat/back_button.png', width: 24, height: 24),
          const SizedBox(width: 8),
          const Text(
            '9:41',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          // Simulated status bar icons (signal, wifi, battery)
          Icon(Icons.signal_cellular_alt, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Icon(Icons.wifi, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Icon(Icons.battery_full, size: 18, color: Colors.grey[600]),
        ],
      ),
    );
  }
}

class _UserQueryWithAttachments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What are this rash on my hand?',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/ai_chat/upload_image.png',
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/ai_chat/upload_document.png',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Rash_something...',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiResponseBubble extends StatelessWidget {
  const _AiResponseBubble();

  void _copyResponse(BuildContext context) {
    // TODO: Implement copy to clipboard
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Response copied!')));
  }

  void _shareResponse(BuildContext context) {
    // TODO: Implement share dialog
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Share dialog opened!')));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mascot
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22,
              backgroundImage: AssetImage('assets/ai_chat/aichat_mascot.png'),
            ),
          ),
          const SizedBox(width: 10),
          // AI Message Bubble
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF2FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      const Text(
                        'Based on the visual information and your query, several conditions can cause a rash on the hand. Here are a few possibilities:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2A3A4D),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _StructuredDiagnosisList(),
                      const SizedBox(height: 12),
                      _DisclaimerText(),
                    ],
                  ),
                ),
                // Action Icons (top right)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _copyResponse(context),
                        child: Image.asset(
                          'assets/ai_chat/copy_icon.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _shareResponse(context),
                        child: Image.asset(
                          'assets/ai_chat/share_icon.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StructuredDiagnosisList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DiagnosisItem(
          number: 1,
          text:
              'Contact Dermatitis: This is a common cause, triggered by contact with an irritant or allergen. It often appears as a red, itchy rash with bumps or blisters.',
        ),
        SizedBox(height: 6),
        _DiagnosisItem(
          number: 2,
          text:
              'Eczema (Atopic Dermatitis): This condition can cause dry, itchy, and inflamed skin. It may appear as patches of red or brownish-gray skin, sometimes with small, raised bumps that can leak fluid when scratched.',
        ),
        SizedBox(height: 6),
        _DiagnosisItem(
          number: 3,
          text:
              'Psoriasis: This is an autoimmune condition that can cause red, scaly patches on the skin. The scales are often silvery-white.',
        ),
      ],
    );
  }
}

class _DiagnosisItem extends StatelessWidget {
  final int number;
  final String text;
  const _DiagnosisItem({required this.number, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF2A3A4D),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Color(0xFF2A3A4D)),
          ),
        ),
      ],
    );
  }
}

class _DisclaimerText extends StatelessWidget {
  const _DisclaimerText();
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Important Disclaimer: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2A3A4D),
              fontSize: 13,
            ),
          ),
          TextSpan(
            text:
                'This is not a diagnosis. Rashes can be complex and require a professional evaluation to determine the exact cause. I strongly recommend consulting a dermatologist for an accurate diagnosis and appropriate treatment plan.',
            style: TextStyle(fontSize: 13, color: Color(0xFF2A3A4D)),
          ),
        ],
      ),
    );
  }
}

class AiActionBlock extends StatelessWidget {
  final VoidCallback onBookAppointment;
  final VoidCallback onMoreInfo;
  const AiActionBlock({
    super.key,
    required this.onBookAppointment,
    required this.onMoreInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF2563EB).withOpacity(0.08),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Would you like me to help you find a dermatologist or book an appointment?',
              textAlign: TextAlign.center,
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
                    onPressed: onBookAppointment,
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
                    onPressed: onMoreInfo,
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
