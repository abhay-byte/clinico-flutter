import 'package:flutter/material.dart';

class DocumentViewPage extends StatefulWidget {
  final String documentTitle;
 final String documentType;
  final String fileName;
  final String uploadDate;
  final String uploadTime;
  final String uploadedBy;
  final String comments;
  final String doctor;
  final String linkedTo;
  final String fileType; // 'pdf', 'image', or other
  final bool enableZoom;

  const DocumentViewPage({
    super.key,
    required this.documentTitle,
    required this.documentType,
    required this.fileName,
    required this.uploadDate,
    required this.uploadTime,
    required this.uploadedBy,
    this.comments = '',
    this.doctor = '',
    this.linkedTo = '',
    this.fileType = 'pdf',
    this.enableZoom = true,
  });

  @override
  State<DocumentViewPage> createState() => _DocumentViewPageState();
}

class _DocumentViewPageState extends State<DocumentViewPage> {
  double _zoomLevel = 1.0;
  final double _minZoom = 0.5;
  final double _maxZoom = 3.0;

  void _zoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + 0.2).clamp(_minZoom, _maxZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - 0.2).clamp(_minZoom, _maxZoom);
    });
  }

  IconData _getFileIcon() {
    switch (widget.fileType.toLowerCase()) {
      case 'pdf':
        return Icons.description;
      case 'image':
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'doc':
      case 'docx':
        return Icons.insert_drive_file;
      case 'doctor_note':
        return Icons.note_alt;
      case 'discharge':
        return Icons.description;
      default:
        return Icons.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // AppBar Section
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF174880), // b1
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Back Button
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    // Title and Subtitle
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.documentTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600, // SemiBold
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.documentType,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFFE1FBFF), // g3
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Overflow Menu Icon
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: IconButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () {
                          _showDocumentOptions();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              // Preview Section (White Container Overlapping AppBar)
              Container(
                margin: const EdgeInsets.only(top: 0),
                transform: Matrix4.translationValues(0, -20, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    // Header Row with Preview and Zoom Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Preview",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600, // SemiBold
                            color: Color(0xFF101828), // text.primary
                          ),
                        ),
                        // Zoom Controls
                        if (widget.enableZoom)
                          Row(
                            children: [
                              // Zoom Out Button
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE1FBFF), // g3
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.zoom_out,
                                    size: 18,
                                    color: Color(0xFF174880), // b1
                                  ),
                                  onPressed: _zoomOut,
                                ),
                              ),
                              // Zoom Percentage
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  "${(_zoomLevel * 100).round()}%",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF101828), // text.primary
                                  ),
                                ),
                              ),
                              // Zoom In Button
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE1FBFF), // g3
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.zoom_in,
                                    size: 18,
                                    color: Color(0xFF174880), // b1
                                  ),
                                  onPressed: _zoomIn,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    
                    // Preview Card (Large Center Box)
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6), // ge3
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 40,
                      ),
                      child: Column(
                        children: [
                          // File Icon
                          Icon(
                            _getFileIcon(),
                            size: 42,
                            color: const Color(0xFF248BEB), // b4
                          ),
                          
                          // "Document Preview" Title
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              "Document Preview",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600, // SemiBold
                                color: Color(0xFF101828), // text.primary
                              ),
                            ),
                          ),
                          
                          // File Name
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.fileName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6A7282), // text.secondary
                              ),
                            ),
                          ),
                          
                          // Tag (PDF Document)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE1FBFF), // g3
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.fileType.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF174880), // b1
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Preview Instructions
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        "Tap and drag to pan • Pinch to zoom",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6A7282), // text.secondary
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Document Details Section
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 16,
                  right: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title Row
                    Row(
                      children: [
                        Icon(
                          Icons.description,
                          size: 20,
                          color: const Color(0xFF174880), // b1
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Document Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600, // SemiBold
                              color: Color(0xFF101828), // text.primary
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Individual Detail Blocks
                    // File Name
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "File Name",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6A7282), // text.secondary
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.fileName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500, // Medium
                                color: Color(0xFF101828), // text.primary
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Uploaded Date
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Color(0xFF6A7282), // text.secondary
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Uploaded Date",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6A7282), // text.secondary
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.uploadDate,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500, // Medium
                                color: Color(0xFF101828), // text.primary
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Uploaded Time
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 16,
                                color: Color(0xFF6A7282), // text.secondary
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Uploaded Time",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6A7282), // text.secondary
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.uploadTime,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500, // Medium
                                color: Color(0xFF101828), // text.primary
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Uploaded By
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 16,
                                color: Color(0xFF6A7282), // text.secondary
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Uploaded By",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6A7282), // text.secondary
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.uploadedBy,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500, // Medium
                                color: Color(0xFF101828), // text.primary
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Report Type
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Report Type",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6A7282), // text.secondary
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE1FBFF), // g3
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.documentType,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF174880), // b1
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Comments
                    if (widget.comments.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.comment,
                                  size: 16,
                                  color: Color(0xFF6A7282), // text.secondary
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "Comments",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF6A7282), // text.secondary
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                widget.comments,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500, // Medium
                                  color: Color(0xFF101828), // text.primary
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    // Doctor
                    if (widget.doctor.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.medical_services,
                                  size: 16,
                                  color: Color(0xFF6A7282), // text.secondary
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "Doctor",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF6A7282), // text.secondary
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                widget.doctor,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500, // Medium
                                  color: Color(0xFF101828), // text.primary
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    // Linked To
                    if (widget.linkedTo.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.link,
                                  size: 16,
                                  color: Color(0xFF6A7282), // text.secondary
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "Linked To",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF6A7282), // text.secondary
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                widget.linkedTo,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500, // Medium
                                  color: Color(0xFF101828), // text.primary
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Action Buttons (Bottom Section)
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 32,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Button 1 — View Linked Appointment
                    if (widget.linkedTo.isNotEmpty)
                      Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF248BEB), // b4
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF248BEB).withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to linked appointment
                            // This would be implemented based on the app's navigation
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF248BEB), // b4
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.link,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "View Linked Appointment",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    
                    // Button 2 — Download Document
                    Container(
                      height: 48,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF248BEB), // b4
                          width: 1.8,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Download document functionality
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download,
                              color: const Color(0xFF174880), // b1
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Download Document",
                              style: TextStyle(
                                fontSize: 16,
                                color: const Color(0xFF174880), // b1
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Button 3 — Delete Document
                    Container(
                      height: 48,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFD92D20), // red
                          width: 1.8,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Delete document functionality with confirmation dialog
                          _showDeleteConfirmationDialog();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Color(0xFFD92D20), // red
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Delete Document",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFD92D20), // red
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
        ),
      ),
    );
  }

  void _showDocumentOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.download, color: Color(0xFF101828)),
                title: Text('Download'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle download
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: Color(0xFF101828)),
                title: Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle share
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Color(0xFFD32F2F)),
                title: Text('Delete', style: TextStyle(color: Color(0xFFD32F2F))),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmationDialog();
                },
              ),
            ],
          ),
        );
      },
    );
 }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Document"),
          content: const Text("Are you sure you want to delete this document? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Perform delete action
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to previous screen
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFD92D20), // red
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}