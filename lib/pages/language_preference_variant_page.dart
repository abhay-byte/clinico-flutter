import 'package:flutter/material.dart';

class LanguagePreferenceVariantPage extends StatefulWidget {
  @override
 _LanguagePreferenceVariantPageState createState() => _LanguagePreferenceVariantPageState();
}

class _LanguagePreferenceVariantPageState extends State<LanguagePreferenceVariantPage> {
  String selectedLanguage = 'English';
  TextEditingController searchController = TextEditingController();
  List<String> languages = [
    'English',
    'Hindi (हिन्दी)',
    'Punjabi (ਪੰਜਾਬੀ)',
    'Urdu (اُرْدُو)',
    'Haryanvi (हरियाणवी)',
    'Bhojpuri (भोजपुरी)',
  ];

  List<String> filteredLanguages = [];

  @override
 void initState() {
    super.initState();
    filteredLanguages = languages;
    searchController.addListener(_filterLanguages);
  }

  void _filterLanguages() {
    setState(() {
      if (searchController.text.isEmpty) {
        filteredLanguages = languages;
      } else {
        filteredLanguages = languages
            .where((lang) =>
                lang.toLowerCase().contains(searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1FA), // bg1
      body: SafeArea(
        child: Column(
          children: [
            // Header Section with curved bottom - Full width
            Container(
              width: double.infinity,
              height: 100, // Fixed height for the header
              decoration: BoxDecoration(
                color: Color(0xFF174880), // b1 - Dark blue
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 8),
                  // Title and Subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Language Preference",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600, // Semi-bold
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Choose your preferred language",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.7), // 70% opacity
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Scrollable Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'Choose the language',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF101828), // ge1
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Select your preferred language below\nThis helps us serve you better.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6A7282), // ge2
                        fontFamily: 'Roboto',
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // You Selected Display Box
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFF248BEB), // b4
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'You Selected',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6A7282), // ge2
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                selectedLanguage,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF101828), // ge1
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF248BEB), // b4
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // All Languages Card
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Title
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'All Languages',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF101828), // ge1
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),
                            // Search Bar
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEBF1FA), // bg1
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFFC0C0C0),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/language/search.png',
                                        width: 20,
                                        height: 20,
                                        color: Color(0xFF6A7282), // ge2
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Language List
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: filteredLanguages.length,
                                itemBuilder: (context, index) {
                                  String language = filteredLanguages[index];
                                  bool isSelected = language == selectedLanguage;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedLanguage = language;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Color(0xFF248BEB).withOpacity(0.1) // b3 equivalent
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            language,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                              color: isSelected
                                                  ? Color(0xFF248BEB) // b4
                                                  : Color(0xFF101828), // ge1
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                          if (isSelected)
                                            Container(
                                              width: 24,
                                              height: 24,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF248BEB), // b4
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                            )
                                          else
                                            Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xFF99A1AF), // ge3
                                                  width: 2,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Save the language preference and navigate back
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Language preference saved!"),
                              backgroundColor: Color(0xFF248BEB),
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF248BEB), // b4
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save Language',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
