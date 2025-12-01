import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:clinico/pages/wellness/wellness_video_page.dart';

class WellnessArticlePage extends StatefulWidget {
  final String contentId;
  final String title;
  final String category;
  final int readTimeMinutes;
  final String thumbnailUrl;
  final List<String> tags;

  const WellnessArticlePage({
    super.key,
    required this.contentId,
    required this.title,
    required this.category,
    required this.readTimeMinutes,
    required this.thumbnailUrl,
    required this.tags,
  });

  @override
  State<WellnessArticlePage> createState() => _WellnessArticlePageState();
}

class _WellnessArticlePageState extends State<WellnessArticlePage> {
  bool _isBookmarked = false;
 bool _isLiked = false;

  void _shareContent() {
    final String shareText = "Check out this article: ${widget.title}\n\n${widget.category}\n\nvia Clinico App";
    final String shareSubject = widget.title;
    
    Share.share(
      shareText,
      subject: shareSubject,
    );
  }

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA), // Background color matching settings page
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header Section with curved bottom (matching settings page)
                Container(
                  width: double.infinity,
                  height: 120, // Fixed height for the header
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1E4A7E), // Header gradient start
                        Color(0xFF2563B4), // Header gradient end
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 20, // Slightly smaller than settings for content
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.category,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action Buttons
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              setState(() {
                                _isBookmarked = !_isBookmarked;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              _shareContent();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 80), // Add bottom padding to account for bottom action bar
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Image
                        Container(
                          height: 280,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.zero, // Full bleed
                            image: DecorationImage(
                              image: widget.thumbnailUrl.startsWith('http')
                                  ? NetworkImage(widget.thumbnailUrl) as ImageProvider
                                  : AssetImage(widget.thumbnailUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Category Badge
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    widget.category,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: _getCategoryColor(widget.category),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Article Metadata
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF101828),
                                ),
                              ),
                              SizedBox(height: 12),
                              
                              // Meta Info Row
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: Color(0xFF6B7280),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${widget.readTimeMinutes} min read",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF6B7280),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "•",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFFCBD5E1),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Nov 28, 2025", // This would be dynamic in real app
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              
                              // Divider
                              Container(
                                height: 1,
                                color: Color(0xFFE5E7EB),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Article Content
                        _buildArticleContent(),
                        
                        SizedBox(height: 24),
                        
                        // Tags Section
                        Text(
                          "Related Topics",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.tags.map((tag) => 
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: Color(0xFFF3F4F6),
                                border: Border.all(color: Color(0xFFE5E7EB)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                        
                        SizedBox(height: 32),
                        
                        // Related Content Section
                        Container(
                          color: Color(0xFFF9FAFB),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You May Also Like",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF101828),
                                ),
                              ),
                              SizedBox(height: 16),
                              _buildRelatedContent(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Bottom Action Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      offset: Offset(0, -2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Like Button
                    IconButton(
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? Color(0xFFFF4B4B) : Color(0xFF6B7280),
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                    ),
                    
                    SizedBox(width: 8),
                    
                    // Bookmark Button
                    IconButton(
                      icon: Icon(
                        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: Color(0xFF174880),
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          _isBookmarked = !_isBookmarked;
                        });
                      },
                    ),
                    
                    Spacer(),
                    
                    // Share Button
                    ElevatedButton.icon(
                      onPressed: () {
                        _shareContent();
                      },
                      icon: Icon(
                        Icons.share,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Share",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF174880),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
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
  
  Widget _buildArticleContent() {
    // Sample article content for "Understanding Depression: Signs & Support"
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Understanding Depression: Signs & Support",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF101828),
          ),
        ),
        SizedBox(height: 16),
        
        Text(
          "Depression is more than just feeling sad—it's a serious mental health condition that affects millions of people worldwide. Recognizing the signs early and knowing where to find support can make a significant difference in recovery.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF374151),
            height: 1.75,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 20),
        
        Text(
          "What is Depression?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF101828),
          ),
        ),
        SizedBox(height: 12),
        
        Text(
          "Depression, also known as major depressive disorder, is a mood disorder that causes persistent feelings of sadness and loss of interest. It affects how you feel, think, and handle daily activities.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF374151),
            height: 1.75,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 20),
        
        Text(
          "Common Symptoms",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF101828),
          ),
        ),
        SizedBox(height: 12),
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Persistent sad, anxious, or \"empty\" mood",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Loss of interest in activities once enjoyed",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Changes in appetite or weight",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Difficulty sleeping or oversleeping",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Loss of energy or increased fatigue",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Difficulty concentrating or making decisions",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        
        Text(
          "When to Seek Help",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF101828),
          ),
        ),
        SizedBox(height: 12),
        
        Text(
          "If you experience several of these symptoms for more than two weeks, it's important to reach out to a healthcare professional. Depression is treatable, and early intervention leads to better outcomes.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF374151),
            height: 1.75,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 20),
        
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF9FAFB),
            border: Border(
              left: BorderSide(
                color: Color(0xFF5A7D2C),
                width: 4,
              ),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Remember: Depression is not a sign of weakness. Seeking help is a sign of strength.",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF4B5563),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 20),
        
        Text(
          "Available Support",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF101828),
          ),
        ),
        SizedBox(height: 12),
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Professional Therapy: Cognitive behavioral therapy (CBT) and other evidence-based treatments",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2. ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Medication: Antidepressants prescribed by a psychiatrist",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "3. ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Support Groups: Connecting with others who understand your experience",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "4. ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Crisis Hotlines: Immediate help available 24/7",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        
        Text(
          "Self-Care Strategies",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF101828),
          ),
        ),
        SizedBox(height: 12),
        
        Text(
          "While professional help is crucial, these strategies can support your recovery:",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF374151),
            height: 1.75,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 12),
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Maintain a regular sleep schedule",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2. ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Engage in physical activity, even light exercise",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "3. ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Stay connected with supportive friends and family",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "4. ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Practice mindfulness and relaxation techniques",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "5. ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174880),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Limit alcohol and avoid drugs",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      height: 1.75,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        
        Text(
          "Resources:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF101828),
          ),
        ),
        SizedBox(height: 8),
        
        Text(
          "• National Suicide Prevention Lifeline: 988\n• Mental Health Helpline: [Your local helpline]\n• Online Therapy Platforms: [Recommendations]",
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF374151),
            height: 1.6,
          ),
        ),
      ],
    );
  }
  
  Widget _buildRelatedContent() {
    // Sample related content - in a real app this would come from a data source
    List<Map<String, dynamic>> relatedContent = [
      {
        'title': 'Managing Anxiety: Practical Techniques',
        'duration': '8 min read',
        'thumbnail': 'assets/wellness_and_awareness/lady_yoga.png',
        'contentType': 'article',
        'id': '1',
        'category': 'Mental Wellness',
        'tags': ['#MentalHealth', '#Anxiety'],
      },
      {
        'title': 'Mindfulness for Beginners: A Complete Guide',
        'duration': '10 min read',
        'thumbnail': 'assets/wellness_and_awareness/hands.png',
        'contentType': 'article',
        'id': '2',
        'category': 'Mindfulness',
        'tags': ['#Mindfulness', '#Meditation'],
      },
      {
        'title': 'Sleep Better Tonight – 10 Simple Tips',
        'duration': '6 min read',
        'thumbnail': 'assets/wellness_and_awareness/person_back.png',
        'contentType': 'article',
        'id': '3',
        'category': 'Sleep',
        'tags': ['#Sleep', '#Health'],
      },
    ];
    
    return SizedBox(
      height: 270, // Increased height of cards further
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: relatedContent.length,
        itemBuilder: (context, index) {
          var content = relatedContent[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the corresponding content page
              if (content['contentType'] == 'article') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WellnessArticlePage(
                      contentId: content['id'],
                      title: content['title'],
                      category: content['category'],
                      readTimeMinutes: int.tryParse(content['duration'].split(' ')[0]) ?? 5,
                      thumbnailUrl: content['thumbnail'],
                      tags: content['tags'],
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WellnessVideoPage(
                      contentId: content['id'],
                      title: content['title'],
                      category: content['category'],
                      durationMinutes: int.tryParse(content['duration'].split(' ')[0]) ?? 5,
                      thumbnailUrl: content['thumbnail'],
                      youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', // Default placeholder
                      tags: content['tags'],
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: 280,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Add this to prevent overflow
                children: [
                  Container(
                    height: 180, // Increased height from 140 to 180
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      image: DecorationImage(
                        image: AssetImage(content['thumbnail']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start, // Add this to align content to top
                        children: [
                          Text(
                            content['title'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101828),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 12,
                                color: Color(0xFF6B7280),
                              ),
                              SizedBox(width: 4),
                              Text(
                                content['duration'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
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
            ),
          );
        },
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    // Return different colors based on category
    switch (category.toLowerCase()) {
      case 'mindfulness':
        return Color(0xFF2E7D32);
      case 'nutrition':
        return Color(0xFF5A7D2C);
      case 'exercise':
        return Color(0xFF1976D2);
      case 'mental wellness':
        return Color(0xFFD32F2F);
      case 'sleep':
        return Color(0xFF7B1FA2);
      case 'heart health':
        return Color(0xFFC62828);
      case 'chronic conditions':
        return Color(0xFF3949AB);
      default:
        return Color(0xFF174880);
    }
  }
}