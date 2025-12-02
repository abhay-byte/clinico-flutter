import 'package:flutter/material.dart';

class MedicineReminder {
  final String name;
  final String dosage;
  final String dosageType;
  final List<MedicineTiming> timings;
  final String howToTake;
  final String duration;
  final String doctorNote;
  final String prescriptionId;

  MedicineReminder({
    required this.name,
    required this.dosage,
    required this.dosageType,
    required this.timings,
    required this.howToTake,
    required this.duration,
    required this.doctorNote,
    required this.prescriptionId,
  });
}

class MedicineTiming {
  final String period;
  final String time;

  MedicineTiming({
    required this.period,
    required this.time,
  });
}

class MedicineRemindersPage extends StatefulWidget {
  const MedicineRemindersPage({Key? key}) : super(key: key);

  @override
  State<MedicineRemindersPage> createState() => _MedicineRemindersPageState();
}

class _MedicineRemindersPageState extends State<MedicineRemindersPage> {
  @override
  Widget build(BuildContext context) {
    // Sample data for medicine reminders
    final List<MedicineReminder> medicineReminders = [
      MedicineReminder(
        name: "Paracetamol 500mg",
        dosage: "1 tablet",
        dosageType: "tablet",
        timings: [
          MedicineTiming(period: "Morning", time: "8:00 AM"),
          MedicineTiming(period: "Afternoon", time: "2:00 PM"),
          MedicineTiming(period: "Night", time: "8:00 PM"),
        ],
        howToTake: "After food",
        duration: "5 days (Nov 10 – Nov 15)",
        doctorNote: "Take with plenty of water",
        prescriptionId: "#DRX-2034",
      ),
      MedicineReminder(
        name: "Amoxicillin 250mg",
        dosage: "1 capsule",
        dosageType: "capsule",
        timings: [
          MedicineTiming(period: "Morning", time: "9:00 AM"),
          MedicineTiming(period: "Night", time: "9:00 PM"),
        ],
        howToTake: "Before food",
        duration: "7 days (Nov 10 – Nov 17)",
        doctorNote: "Complete the full course even if you feel better",
        prescriptionId: "#DRX-2034",
      ),
      MedicineReminder(
        name: "Vitamin D3 60000 IU",
        dosage: "1 capsule",
        dosageType: "capsule",
        timings: [
          MedicineTiming(period: "Morning", time: "10:00 AM"),
        ],
        howToTake: "After breakfast",
        duration: "Once weekly (Nov 10 – Nov 10)",
        doctorNote: "Take once every week for 8 weeks",
        prescriptionId: "#DRX-2021",
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Bar with rounded bottom edges
            Container(
              height: 110,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF174880), // b1 - Dark blue
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 12),
                  // Title and Subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Medicine Reminders",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Never miss your medication",
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
            
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Today's Reminder Summary Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEBF1FA), // bg1 - Light blue
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.notifications_active,
                                  color: Color(0xFF174880), // b1 - Dark blue
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Today's Reminder Summary",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF101828), // Dark text
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Color(0xFF248BEB), // b4 - Blue
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "3 medicines scheduled",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF101828), // Dark text
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.medication,
                                color: Color(0xFF248BEB), // b4 - Blue
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Next dose: ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF101828), // Dark text
                                ),
                              ),
                              const Text(
                                "Paracetamol",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF101828), // Dark text
                                ),
                              ),
                              const Text(
                                " – 2:00 PM",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF101828), // Dark text
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Medicine Reminder Cards
                    ...medicineReminders.map((medicine) => _buildMedicineCard(medicine)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineCard(MedicineReminder medicine) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Medicine Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  medicine.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF101828), // Dark text
                  ),
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF1FA), // bg1 - Light blue
                  borderRadius: BorderRadius.circular(18),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Color(0xFF174880), // b1 - Dark blue
                    size: 20,
                  ),
                  onPressed: () {
                    _showEditDialog(medicine);
                  },
                ),
              ),
            ],
          ),
          
          // Dosage Info
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              medicine.dosage,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF248BEB), // b4 - Blue
              ),
            ),
          ),
          
          // Timing Section
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color(0xFF6A7282), // ge3 - Grey
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Timing",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6A7282), // ge3 - Grey
                  ),
                ),
              ],
            ),
          ),
          
          // Timing Pills Container
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFEBF1FA), // bg1 - Light grey-blue
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    children: medicine.timings.map((timing) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Text(
                                timing.period,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6A7282), // ge3 - Grey
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                timing.time,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF101828), // Dark text
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          
          // How to Take Section
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.restaurant,
                  color: Color(0xFF248BEB), // b4 - Blue
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  "How to take:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6A7282), // ge3 - Grey
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  medicine.howToTake,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF101828), // Dark text
                  ),
                ),
              ],
            ),
          ),
          
          // Duration Section
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.event,
                  color: Color(0xFF248BEB), // b4 - Blue
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Duration:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6A7282), // ge3 - Grey
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  medicine.duration,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF101828), // Dark text
                  ),
                ),
              ],
            ),
          ),
          
          // Doctor's Note Section (if note exists)
          if (medicine.doctorNote.isNotEmpty) _buildDoctorNoteSection(medicine.doctorNote),
          
          // Prescription Link & Delete Section
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Prescription Link
                Row(
                  children: [
                    const Icon(
                      Icons.description,
                      color: Color(0xFF248BEB), // b4 - Blue
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "View Prescription ${medicine.prescriptionId}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF248BEB), // b4 - Blue
                      ),
                    ),
                  ],
                ),
                
                // Delete Button
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFFF6E6E), // r1 - Red
                    size: 22,
                  ),
                  onPressed: () {
                    _showDeleteDialog(medicine);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorNoteSection(String note) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E5), // Light yellow background
        border: Border.all(color: const Color(0xFFFFE5CC)), // Light orange border
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Color(0xFFFFA726), // Amber orange
                size: 18,
              ),
              const SizedBox(width: 6),
              const Text(
                "Doctor's Note",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFF57C00), // Dark orange
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              note,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF101828), // Dark text
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(MedicineReminder medicine) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Medicine"),
          content: Text("Edit functionality for ${medicine.name} would be implemented here."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(MedicineReminder medicine) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Reminder"),
          content: Text("Are you sure you want to delete this medicine reminder for ${medicine.name}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}