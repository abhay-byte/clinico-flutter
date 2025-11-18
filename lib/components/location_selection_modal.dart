import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blur/blur.dart';
import '../constants/colors.dart';

class LocationSelectionModal extends StatefulWidget {
  final VoidCallback? onLocationSelected;
  final VoidCallback? onDismiss;

  const LocationSelectionModal({
    super.key,
    this.onLocationSelected,
    this.onDismiss,
  });

  @override
  State<LocationSelectionModal> createState() => _LocationSelectionModalState();
}

class _LocationSelectionModalState extends State<LocationSelectionModal> {
  final TextEditingController _searchController = TextEditingController();
  final String currentAddress = "123, Block A, Sector 14, Dwarka, New Delhi - 110078";
  bool _isModalDismissed = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background that will be blurred
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Blur effect on the background
          Blur(
            blur: 4,
            blurColor: Colors.black,
            colorOpacity: 0.3,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          // The modal content (not blurred)
          GestureDetector(
            onTap: () {
              // Close modal when tapping outside
              if (!_isModalDismissed) {
                _isModalDismissed = true;
                if (widget.onDismiss != null) {
                  widget.onDismiss!();
                }
                Navigator.of(context).pop();
              }
            },
            child: Center(
              child: GestureDetector(
                onTap: () {}, // Prevent gesture propagation
                child: DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.4,
                  maxChildSize: 0.8,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Grab handle
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.ge3,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Content
                          Expanded(
                            child: ListView(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              children: [
                                // Search Bar with shadow
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.bg1,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Image.asset(
                                          'assets/home/search.png',
                                          width: 20,
                                          height: 20,
                                          color: AppColors.ge2,
                                        ),
                                      ),
                                      hintText: 'Select Your Location',
                                      hintStyle: const TextStyle(
                                        color: AppColors.ge2,
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                
                                // Use my current location
                                GestureDetector(
                                  onTap: () {
                                    if (!_isModalDismissed) {
                                      _isModalDismissed = true;
                                      if (widget.onLocationSelected != null) {
                                        widget.onLocationSelected!();
                                      }
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.ge3,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/home/location/current_location.png',
                                          width: 20,
                                          height: 20,
                                          color: AppColors.ge1,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            'Use my current location',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.ge1,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.chevron_right,
                                          color: AppColors.ge2,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                
                                // Current Address Section
                                Text(
                                  'Current Address',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.ge1,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () {
                                    if (!_isModalDismissed) {
                                      _isModalDismissed = true;
                                      if (widget.onLocationSelected != null) {
                                        widget.onLocationSelected!();
                                      }
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.bg1,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/home/location/location_block.png',
                                          width: 20,
                                          height: 20,
                                          color: AppColors.ge1,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                currentAddress.split(', ').take(3).join(', '),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.ge2,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                              if (currentAddress.split(', ').length > 3) ...[
                                                const SizedBox(height: 4),
                                                Text(
                                                  currentAddress.split(', ').sublist(3).join(', '),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.ge2,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.chevron_right,
                                          color: AppColors.ge2,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 100), // Extra padding at bottom
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}