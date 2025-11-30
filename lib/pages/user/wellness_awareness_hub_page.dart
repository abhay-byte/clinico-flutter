import 'package:flutter/material.dart';

class WellnessContent {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String contentType; // "video" or "article"
  final int durationMinutes;
  final String category; // "Mindfulness", "Exercise", etc.
  final String tab; // "mental_wellness" or "health_awareness"
  final List<String> hashtags;
  final String contentUrl;

  WellnessContent({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.contentType,
    required this.durationMinutes,
    required this.category,
    required this.tab,
    required this.hashtags,
    required this.contentUrl,
  });
}

class WellnessAwarenessHubPage extends StatefulWidget {
  final int initialTab; // 0 = Mental Wellness, 1 = Health Awareness

  const WellnessAwarenessHubPage({
    super.key,
    required this.initialTab,
  });

  @override
  _WellnessAwarenessHubPageState createState() => _WellnessAwarenessHubPageState();
}

class _WellnessAwarenessHubPageState extends State<WellnessAwarenessHubPage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  String _selectedCategory = 'All';
  String _searchQuery = '';
  List<WellnessContent> _allContent = [];
  List<WellnessContent> _filteredContent = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
    _initializeContent();
    _filterContent();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _initializeContent() {
    _allContent = [
      // Mental Wellness Content
      WellnessContent(
        id: '1',
        title: 'Mindfulness in 5 Minutes – Daily Routine',
        description: 'Learn quick breathing and grounding exercises to manage anxiety.',
        thumbnailUrl: 'assets/wellness_and_awareness/lady_yoga.png',
        contentType: 'video',
        durationMinutes: 5,
        category: 'Mindfulness',
        tab: 'mental_wellness',
        hashtags: ['#MentalHealth', '#Mindfulness'],
        contentUrl: 'https://example.com/mindfulness-video',
      ),
      WellnessContent(
        id: '2',
        title: 'Yoga for Stress Relief – Beginner Friendly',
        description: 'Gentle yoga poses to release tension and calm your mind.',
        thumbnailUrl: 'assets/wellness_and_awareness/lady_yoga.png',
        contentType: 'video',
        durationMinutes: 15,
        category: 'Exercise',
        tab: 'mental_wellness',
        hashtags: ['#Yoga', '#StressRelief'],
        contentUrl: 'https://example.com/yoga-video',
      ),
      WellnessContent(
        id: '3',
        title: 'Understanding Depression: Signs & Support',
        description: 'Recognize the symptoms of depression and learn where to find help.',
        thumbnailUrl: 'assets/wellness_and_awareness/lady_yoga.png',
        contentType: 'article',
        durationMinutes: 6,
        category: 'Therapy',
        tab: 'mental_wellness',
        hashtags: ['#MentalHealth', '#Depression'],
        contentUrl: 'https://example.com/depression-article',
      ),
      WellnessContent(
        id: '4',
        title: 'Sleep Better Tonight – 10 Simple Tips',
        description: 'Proven techniques to improve your sleep quality and wake up refreshed.',
        thumbnailUrl: 'assets/wellness_and_awareness/lady_yoga.png',
        contentType: 'article',
        durationMinutes: 5,
        category: 'Sleep',
        tab: 'mental_wellness',
        hashtags: ['#Sleep', '#SelfCare'],
        contentUrl: 'https://example.com/sleep-article',
      ),
      // Health Awareness Content
      WellnessContent(
        id: '5',
        title: 'Balanced Diet Basics: What You Need to Know',
        description: 'Essential nutrients and how to incorporate them into your daily meals.',
        thumbnailUrl: 'assets/wellness_and_awareness/lady_yoga.png',
        contentType: 'article',
        durationMinutes: 7,
        category: 'Nutrition',
        tab: 'health_awareness',
        hashtags: ['#Nutrition', '#HealthyEating'],
        contentUrl: 'https://example.com/diet-article',
      ),
      WellnessContent(
        id: '6',
        title: '10-Minute Morning Workout Routine',
        description: 'A quick and effective workout to energize your day.',
        thumbnailUrl: 'assets/wellness_and_awareness/lady_yoga.png',
        contentType: 'video',
        durationMinutes: 10,
        category: 'Exercise',
        tab: 'health_awareness',
        hashtags: ['#Exercise', '#Workout'],
        contentUrl: 'https://example.com/workout-video',
      ),
      WellnessContent(
        id: '7',
        title: 'Understanding Heart Disease Prevention',
        description: 'Key factors and lifestyle changes to reduce heart disease risk.',
        thumbnailUrl: 'assets/wellness_and_awareness/lady_yoga.png',
        contentType: 'article',
        durationMinutes: 8,
        category: 'Heart Health',
        tab: 'health_awareness',
        hashtags: ['#HeartHealth', '#Prevention'],
        contentUrl: 'https://example.com/heart-article',
      ),
      WellnessContent(
        id: '8',
        title: 'Managing Blood Sugar: Practical Tips',
        description: 'Effective strategies for maintaining healthy blood sugar levels.',
        thumbnailUrl: 'assets/wellness_and_awareness/lady_yoga.png',
        contentType: 'video',
        durationMinutes: 6,
        category: 'Chronic Conditions',
        tab: 'health_awareness',
        hashtags: ['#Diabetes', '#BloodSugar'],
        contentUrl: 'https://example.com/blood-sugar-video',
      ),
    ];
  }

  void _filterContent() {
    List<WellnessContent> contentToShow = _allContent
        .where((content) => content.tab == (widget.initialTab == 0 ? 'mental_wellness' : 'health_awareness'))
        .toList();

    if (_searchQuery.isNotEmpty) {
      contentToShow = contentToShow.where((content) {
        return content.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            content.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            content.hashtags.any((tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase())) ||
            content.category.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_selectedCategory != 'All') {
      contentToShow = contentToShow.where((content) => content.category == _selectedCategory).toList();
    }

    setState(() {
      _filteredContent = contentToShow;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _filterContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1FA), // Background color
      body: SafeArea(
        child: Column(
          children: [
            // App Bar with the same design as Medical Vault
            Container(
              width: double.infinity,
              height: 156, // 156px height as specified
              decoration: BoxDecoration(
                color: Color(0xFF174880), // Primary blue
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: EdgeInsets.only(
                top: 44, // 44px top padding for status bar
                left: 16,
                right: 16,
                bottom: 20, // 20px bottom padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button and Title Row
                  Row(
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
                            "Wellness & Awareness Hub",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600, // Semi-bold
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Your health education center",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Search Bar
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), // 20% opacity
                      borderRadius: BorderRadius.circular(20), // Fully rounded
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    margin: EdgeInsets.only(top: 12), // 12px margin from subtitle
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white.withOpacity(0.8), // 80% opacity
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search health topics, videos, or articles...',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.6), // 60% opacity
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.only(top: 10, bottom: 10), // 8px padding from icon
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            cursorColor: Colors.white,
                            onChanged: _onSearchChanged,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Tab Bar
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // 5% opacity
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Color(0xFFC8E6A0), // Light green
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: Color(0xFF2F4F1F), // Dark green
                unselectedLabelColor: Color(0xFF6B7280), // Gray
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600, // Semi-bold
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500, // Medium
                ),
                tabs: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10), // 10px padding
                    child: Tab(
                      text: 'Mental Wellness',
                      icon: Icon(
                        Icons.psychology,
                        size: 18,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10), // 10px padding
                    child: Tab(
                      text: 'Health Awareness',
                      icon: Icon(
                        Icons.health_and_safety,
                        size: 18,
                      ),
                    ),
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _selectedCategory = 'All';
                  });
                  _filterContent();
                },
              ),
            ),
            
            // Content Area
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _filterContent();
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Categories Section
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 12),
                        child: Text(
                          "Categories:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ),
                      
                      // Category Chips
                      Container(
                        height: 36,
                        padding: EdgeInsets.symmetric(horizontal: 16), // 16px horizontal padding
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildCategoryChip('All', Colors.white, Color(0xFF6B7280), Color(0xFFE5E7EB)),
                            _buildCategoryChip('Mindfulness', Color(0xFFE8F5E9), Color(0xFF2E7D32), Color(0xFF2E7D32)),
                            _buildCategoryChip('Exercise', Color(0xFFFFF9C4), Color(0xFFF57F17), Color(0xFFF57F17)),
                            _buildCategoryChip('Sleep', Color(0xFFE3F2FD), Color(0xFF1565C0), Color(0xFF1565C0)),
                            _buildCategoryChip('Therapy', Color(0xFFFCE4EC), Color(0xFFC2185B), Color(0xFFC2185B)),
                            _buildCategoryChip('Nutrition', Color(0xFFFFE0B2), Color(0xFFFF6F00), Color(0xFFFF6F00)),
                            _buildCategoryChip('Stress Management', Color(0xFFE1BEE7), Color(0xFF7B1FA2), Color(0xFF7B1FA2)),
                            _buildCategoryChip('Relationships', Color(0xFFB2DFDB), Color(0xFF00695C), Color(0xFF00695C)),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Content Cards
                      if (_filteredContent.isEmpty)
                        _buildEmptyState()
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _filteredContent.length,
                          itemBuilder: (context, index) {
                            return _buildContentCard(_filteredContent[index]);
                          },
                        ),
                      
                      SizedBox(height: 20), // Add bottom padding
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category, Color bgColor, Color textColor, Color borderColor) {
    bool isSelected = _selectedCategory == category;
    
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          category,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? textColor : Color(0xFF6B7280),
          ),
        ),
        selected: isSelected,
        selectedColor: bgColor,
        backgroundColor: isSelected ? bgColor : Colors.white,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? textColor : Color(0xFF6B7280),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? borderColor : Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        onSelected: (bool selected) {
          setState(() {
            _selectedCategory = selected ? category : 'All';
          });
          _filterContent();
        },
      ),
    );
  }

  Widget _buildContentCard(WellnessContent content) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // 5% opacity
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail with badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  content.thumbnailUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Badge overlay
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        content.contentType == 'video' 
                            ? Icons.play_circle_outline 
                            : Icons.article_outlined,
                        size: 16,
                        color: content.contentType == 'video' 
                            ? Color(0xFF5A7D2C) // Dark green
                            : Color(0xFF174880), // Primary blue
                      ),
                      SizedBox(width: 4),
                      Text(
                        content.contentType == 'video' ? 'Video' : 'Article',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: content.contentType == 'video' 
                              ? Color(0xFF5A7D2C) // Dark green
                              : Color(0xFF174880), // Primary blue
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Card content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  content.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF101828),
                    height: 1.4, // Line height 1.4
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: 8),
                
                // Duration/read time
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    SizedBox(width: 4), // 4px margin left of icon
                    Text(
                      content.contentType == 'video'
                          ? '${content.durationMinutes} min'
                          : '${content.durationMinutes} min read',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 12),
                
                // Description
                Text(
                  content.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: 12),
                
                // Hashtags
                if (content.hashtags.isNotEmpty)
                  Wrap(
                    spacing: 8, // 8px spacing between tags
                    children: content.hashtags.map((tag) =>
                      Text(
                        tag,
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ).toList(),
                  ),
                
                SizedBox(height: 16),
                
                // Action Button
                Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF5A7D2C), // Dark green
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigate to content page
                      print('Navigate to: ${content.contentUrl}');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          content.contentType == 'video'
                              ? Icons.play_arrow
                              : Icons.menu_book,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6), // 6px margin left of text
                        Text(
                          content.contentType == 'video' ? 'Watch Video' : 'Read Article',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
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
  }

  Widget _buildEmptyState() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Color(0xFFCBD5E1),
          ),
          SizedBox(height: 16),
          Text(
            "No content found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Try adjusting your search or category filter",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}