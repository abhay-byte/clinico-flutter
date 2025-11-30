import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class MedicalDocumentUploadPage extends StatefulWidget {
  const MedicalDocumentUploadPage({Key? key}) : super(key: key);

  @override
  State<MedicalDocumentUploadPage> createState() => _MedicalDocumentUploadPageState();
}

class _MedicalDocumentUploadPageState extends State<MedicalDocumentUploadPage> {
  // Form key for validation
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Controllers for text fields
 final TextEditingController _documentNameController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
 final TextEditingController _commentsController = TextEditingController();

  // Form values
  String? _selectedDocumentType;
  String? _selectedAppointment;
  String? _selectedPrescription;
  DateTime? _selectedDate;
  String? _selectedFilePath;

  // List of document types
  final List<String> _documentTypes = [
    "Lab Report",
    "Prescription",
    "Imaging",
    "Discharge Summary",
    "Vaccination Record",
    "Other"
  ];

  // Mock data for appointments and prescriptions (to be replaced with actual data)
  final List<String> _appointments = ["Appointment 1", "Appointment 2", "Appointment 3"];
  final List<String> _prescriptions = ["Prescription 1", "Prescription 2", "Prescription 3"];

  // Function to pick file
 Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedFilePath = result.files.single.path;
      });
    }
  }

  // Function to show date picker
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to validate and upload document
  void _uploadDocument() {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text("Uploading document..."),
              ],
            ),
          );
        },
      );

      // Simulate upload process
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Close loading dialog
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Document uploaded successfully"),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate back to Medical Vault
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF1FA),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header Section with curved bottom
                Container(
                  width: double.infinity,
                  height: 120, // Fixed height for the header to match settings page
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF1E4A7E), // Header gradient start
                        const Color(0xFF2563B4), // Header gradient end
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
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          // Check if form has data before navigating back
                          if (_documentNameController.text.isNotEmpty ||
                              _selectedDocumentType != null ||
                              _selectedFilePath != null ||
                              _selectedDate != null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Unsaved Changes"),
                                  content: const Text("You have unsaved changes. Are you sure you want to leave?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Leave"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      SizedBox(width: 8),
                      // Title and Subtitle
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Upload Medical Document",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Add to your medical vault",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 100), // Increased padding to avoid FAB overlap
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        
                        // Document Card
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                offset: const Offset(0, 2),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.description, size: 20, color: const Color(0xFF174880)),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Document 1",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF101828),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Divider(
                                height: 1,
                                color: Color(0xFFE1FFBF),
                              ),
                              const SizedBox(height: 16),
                              
                              // Form Fields
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Select Document Type
                                    const Text(
                                      "Select Document Type *",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        border: Border.all(color: const Color(0xFFE1FFBF)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text(
                                            "Choose document type",
                                            style: TextStyle(color: Color(0xFF9CA3AF)),
                                          ),
                                          value: _selectedDocumentType,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedDocumentType = newValue;
                                            });
                                          },
                                          items: _documentTypes.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          icon: const Icon(Icons.expand_more, color: Color(0xFF9CA3AF)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    
                                    // Document Name
                                    const Text(
                                      "Document Name *",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _documentNameController,
                                      decoration: InputDecoration(
                                        hintText: "e.g., CBC Report – Nov 2025",
                                        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                                        filled: true,
                                        fillColor: const Color(0xFFF9FAFB),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFE1FFBF)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFE1FFBF)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFF174880), width: 2),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a document name";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    
                                    // Upload File
                                    const Text(
                                      "Upload File *",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: _pickFile,
                                      child: Container(
                                        height: 48,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEBF1FA),
                                          border: Border.all(
                                            color: const Color(0xFF174880),
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.attach_file, color: Color(0xFF174880)),
                                            const SizedBox(width: 8),
                                            const Text(
                                              "Upload PDF/Image",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF174880),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      "Supported formats: PDF, JPG, PNG (Max 10MB)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    
                                    // Date of Report
                                    const Text(
                                      "Date of Report *",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: _selectDate,
                                      child: AbsorbPointer(
                                        child: Container(
                                          height: 48,
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF9FAFB),
                                            border: Border.all(color: const Color(0xFFE1FFBF)),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _selectedDate != null
                                                    ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                                                    : "Select date",
                                                style: TextStyle(
                                                  color: _selectedDate != null
                                                      ? const Color(0xFF101828)
                                                      : const Color(0xFF9CA3AF),
                                                ),
                                              ),
                                              Icon(
                                                Icons.calendar_today,
                                                size: 18,
                                                color: const Color(0xFF6B7280),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    
                                    // Doctor / Lab Name
                                    const Text(
                                      "Doctor / Lab Name",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _doctorNameController,
                                      decoration: InputDecoration(
                                        hintText: "e.g., Dr. R. Kumar / Fortis Diagnostics",
                                        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                                        filled: true,
                                        fillColor: const Color(0xFFF9FAFB),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFE1FFBF)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFE1FFBF)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFF174880), width: 2),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    
                                    // Add Comments
                                    const Text(
                                      "Add Comments",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _commentsController,
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        hintText: "e.g., Routine check – all normal",
                                        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                                        filled: true,
                                        fillColor: const Color(0xFFF9FAFB),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFE1FFBF)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFE1FFBF)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFF174880), width: 2),
                                        ),
                                      ),
                                      textAlignVertical: TextAlignVertical.top,
                                    ),
                                    const SizedBox(height: 20),
                                    
                                    // Link to Appointment
                                    const Text(
                                      "Link to Appointment (Optional)",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        border: Border.all(color: const Color(0xFFE1FFBF)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text(
                                            "Select an appointment",
                                            style: TextStyle(color: Color(0xFF9CA3AF)),
                                          ),
                                          value: _selectedAppointment,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedAppointment = newValue;
                                            });
                                          },
                                          items: _appointments.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          icon: const Icon(Icons.expand_more, color: Color(0xFF9CA3AF)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    
                                    // Link to Prescription
                                    const Text(
                                      "Link to Prescription (Optional)",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        border: Border.all(color: const Color(0xFFE1FFBF)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text(
                                            "Select a prescription",
                                            style: TextStyle(color: Color(0xFF9CA3AF)),
                                          ),
                                          value: _selectedPrescription,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedPrescription = newValue;
                                            });
                                          },
                                          items: _prescriptions.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          icon: const Icon(Icons.expand_more, color: Color(0xFF9CA3AF)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 80), // Increased spacing to account for the positioned upload button
                        
                        // Quick Tip Section
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBF1FA),
                            border: Border.all(
                              color: const Color(0xFF174880).withValues(alpha: 0.2),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                size: 24,
                                color: const Color(0xFF174880),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Quick Tip",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF174880),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "You can upload multiple documents at once. Use \"Add More Documents\" button below to add additional files.",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF374151),
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Add More Documents Button
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: OutlinedButton(
                            onPressed: () {
                              // TODO: Implement adding more document cards
                              // For now, just show a snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Multiple document upload coming soon"),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: Color(0xFF174880),
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Color(0xFF174880),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Add More Documents",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF174880),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Upload Document Button (Positioned at bottom)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF174880).withValues(alpha: 0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _uploadDocument,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF174880),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Upload Document",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
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

  @override
  void dispose() {
    _documentNameController.dispose();
    _doctorNameController.dispose();
    _commentsController.dispose();
    super.dispose();
  }
}