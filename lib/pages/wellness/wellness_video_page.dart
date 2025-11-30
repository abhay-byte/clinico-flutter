import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:clinico/pages/wellness/wellness_article_page.dart';

class WellnessVideoPage extends StatefulWidget {
  final String contentId;
 final String title;
  final String category;
  final int durationMinutes;
  final String thumbnailUrl;
 final String youtubeUrl;
 final List<String> tags;

  const WellnessVideoPage({
    super.key,
    required this.contentId,
    required this.title,
    required this.category,
    required this.durationMinutes,
    required this.thumbnailUrl,
    required this.youtubeUrl,
    required this.tags,
  });

  @override
 State<WellnessVideoPage> createState() => _WellnessVideoPageState();
}

class _WellnessVideoPageState extends State<WellnessVideoPage> {
  bool _isBookmarked = false;
   bool _isLiked = false;
   bool _showDescription = false;
   bool _dontShowDialog = false;
   final String _description = "In this comprehensive guide, we'll explore simple yet effective mindfulness techniques you can practice anywhere, anytime. Learn breathing exercises, body scan meditation, and grounding techniques that help reduce anxiety and increase present-moment awareness. Perfect for beginners and experienced practitioners alike.";

  void _shareContent() {
    final String shareText = "Check out this video: ${widget.title}\n\n${widget.category}\n\nvia Clinico App";
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
                        // Video Thumbnail Section
                        Stack(
                          children: [
                            Container(
                              height: 240,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.zero, // Full bleed
                                color: Colors.black, // Black background if image loading
                                image: widget.thumbnailUrl.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(widget.thumbnailUrl),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                            ),
                            
                            // Play Button Overlay (Center)
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Center(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.3),
                                        offset: Offset(0, 4),
                                        blurRadius: 16,
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.play_arrow,
                                      size: 48,
                                      color: Color(0xFFFF0000), // YouTube red
                                    ),
                                    onPressed: () {
                                      _showExitDialog(context, widget.youtubeUrl);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            
                            // YouTube Logo Badge (Top-right)
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF0000), // YouTube red
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "YouTube",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Duration Badge (Bottom-right)
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "${(widget.durationMinutes ~/ 60)}:${(widget.durationMinutes % 60).toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Video Info Section
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.zero,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category Badge
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: _getCategoryColor(widget.category)),
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
                              SizedBox(height: 12),
                              
                              // Title
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 22,
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
                                        "${widget.durationMinutes} min",
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
                        
                        // Video Description
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _showDescription 
                                  ? _description 
                                  : _description.length > 150 
                                      ? "${_description.substring(0, 150)}..." 
                                      : _description,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF4B5563),
                                  height: 1.6,
                                ),
                              ),
                              if (_description.length > 150) ...[
                                SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _showDescription = !_showDescription;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(0, 0),
                                  ),
                                  child: Text(
                                    _showDescription ? "Show less" : "Read more",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF174880),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 24),
                        
                        // Watch Video Button (Primary CTA)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showExitDialog(context, widget.youtubeUrl);
                            },
                            icon: Icon(
                              Icons.play_circle_filled,
                              size: 24,
                              color: Colors.white,
                            ),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Watch on YouTube",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.open_in_new,
                                  size: 18,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF0000), // YouTube red
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              shadowColor: Color(0xFFFF0000).withValues(alpha: 0.3),
                              elevation: 4,
                              minimumSize: Size(double.infinity, 52),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Tags Section
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                            ],
                          ),
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
  
   Widget _buildRelatedContent() {
     // Sample related content - in a real app this would come from a data source
     List<Map<String, dynamic>> relatedContent = [
       {
         'title': '5-Minute Mindfulness Meditation',
         'duration': '5:30',
         'thumbnail': 'assets/wellness_and_awareness/lady_yoga.png',
         'contentType': 'video',
         'id': '4',
         'category': 'Mindfulness',
         'tags': ['#Meditation', '#Mindfulness'],
       },
       {
         'title': '10-Minute Yoga for Stress Relief',
         'duration': '10:15',
         'thumbnail': 'assets/wellness_and_awareness/hands.png',
         'contentType': 'video',
         'id': '5',
         'category': 'Exercise',
         'tags': ['#Yoga', '#StressRelief'],
       },
       {
         'title': 'Breathing Techniques for Anxiety',
         'duration': '8:42',
         'thumbnail': 'assets/wellness_and_awareness/person_back.png',
         'contentType': 'video',
         'id': '6',
         'category': 'Mental Wellness',
         'tags': ['#Breathing', '#Anxiety'],
       },
     ];
     
     return SizedBox(
       height: 250, // Increased height of cards
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
                       readTimeMinutes: int.tryParse(content['duration'].split(':')[0]) ?? 5,
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
                       durationMinutes: int.tryParse(content['duration'].split(':')[0]) ?? 5,
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
  
  void _showExitDialog(BuildContext context, String youtubeUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
          constraints: BoxConstraints(maxWidth: 340), // Max 340px
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFFFEBEE).withValues(alpha: 1.0), // light red
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.open_in_new,
                  size: 48,
                  color: Color(0xFFFF0000), // YouTube red
                ),
              ),
              SizedBox(height: 20),
              
              // Title
              Text(
                "Leave Clinico?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              
              // Description
              Text(
                "This video will open in YouTube. You'll be redirected to the YouTube app or website.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              
              // Checkbox Option
              Row(
                children: [
                  Checkbox(
                    value: _dontShowDialog,
                    activeColor: Color(0xFFD32F2F),
                    onChanged: (bool? value) {
                      setState(() {
                        _dontShowDialog = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Don't show this again",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Action Buttons
              Column(
                children: [
                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        _launchYouTube(youtubeUrl); // Launch YouTube
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF0000), // YouTube red
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Open YouTube",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  
                  // Cancel Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFFE0E0E0)),
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF374151),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Stay in App",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _launchYouTube(String url) async {
    final Uri youtubeUri = Uri.parse(url);
    
    try {
      // Try to launch in YouTube app first
      final bool launched = await launchUrl(
        youtubeUri,
        mode: LaunchMode.externalApplication,
      );
      
      if (!launched) {
        // Fallback to browser if YouTube app not installed
        await launchUrl(
          youtubeUri,
          mode: LaunchMode.externalNonBrowserApplication,
        );
      }
    } catch (e) {
      // Show error snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open video. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}