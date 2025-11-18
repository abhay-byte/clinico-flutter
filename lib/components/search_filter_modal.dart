import 'package:flutter/material.dart';
import 'package:blur/blur.dart';
import '../constants/colors.dart';

class SearchFilterModal extends StatefulWidget {
  final VoidCallback? onApply;
  final VoidCallback? onClearAll;
  final VoidCallback? onDismiss;

  const SearchFilterModal({
    super.key,
    this.onApply,
    this.onClearAll,
    this.onDismiss,
  });

  @override
  State<SearchFilterModal> createState() => _SearchFilterModalState();
}

class _SearchFilterModalState extends State<SearchFilterModal> {
  // Filter states
  String _sortBy = 'Distance';
  String _specialisation = 'Physician';
  String _rating = 'Any Rating';
  bool _showVolunteers = false;
  List<String> _availability = []; // Start with empty list, default options are shown but not counted as active

  // Count of active filters
  int get _activeFilterCount {
    int count = 0;
    if (_sortBy != 'Distance') count++;
    if (_specialisation != 'Physician') count++;
    if (_rating != 'Any Rating') count++;
    if (_showVolunteers) count++;
    if (_availability.isNotEmpty) count += _availability.length;
    return count;
  }

  // Options for dropdowns
  final List<String> _sortByOptions = [
    'Distance',
    'Recommendation',
    'Price (Low to High)',
    'Price (High to Low)',
    'Rating'
  ];

  final List<String> _specialisationOptions = [
    'Physician',
    'Cardiologist',
    'Dermatologist',
    'Psychiatrist',
    'Dentist',
    'Gastroenterologist',
    'Hepatologist',
    'Nephrologist',
    'Pulmonologist'
  ];

  final List<String> _ratingOptions = [
    'Any Rating',
    '> 4 ★',
    '> 3 ★'
  ];

  final List<String> _availabilityOptions = [
    'Today',
    'Tomorrow',
    'This Week',
    'Weekdays',
    'Weekends'
  ];

  // Toggle states
  // Removed since we're using Flutter's default dropdowns now

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
              if (widget.onDismiss != null) {
                widget.onDismiss!();
              }
              Navigator.of(context).pop();
            },
            child: Center(
              child: GestureDetector(
                onTap: () {}, // Prevent gesture propagation
                child: DraggableScrollableSheet(
                  initialChildSize: 0.85,
                  minChildSize: 0.6,
                  maxChildSize: 0.95,
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
                          const SizedBox(height: 16),
                          
                          // Header Bar
                          _buildHeaderBar(),
                          
                          const SizedBox(height: 24),
                          
                          // Scrollable content
                          Expanded(
                            child: ListView(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              children: [
                                // Sort by dropdown
                                _buildLabel('Sort by'),
                                const SizedBox(height: 12),
                                _buildSortByDropdown(),
                                const SizedBox(height: 25),
                                Divider(height: 1, thickness: 1, color: AppColors.ge3),
                                const SizedBox(height: 25),
                                
                                // Specialisation dropdown
                                _buildLabel('Specialisation'),
                                const SizedBox(height: 12),
                                _buildSpecialisationDropdown(),
                                const SizedBox(height: 25),
                                Divider(height: 1, thickness: 1, color: AppColors.ge3),
                                const SizedBox(height: 25),
                                
                                // Rating toggle group
                                _buildLabel('Rating'),
                                const SizedBox(height: 12),
                                _buildRatingToggleGroup(),
                                const SizedBox(height: 25),
                                Divider(height: 1, thickness: 1, color: AppColors.ge3),
                                const SizedBox(height: 25),
                                
                                // Show Only Volunteers toggle
                                _buildShowVolunteersToggle(),
                                const SizedBox(height: 25),
                                Divider(height: 1, thickness: 1, color: AppColors.ge3),
                                const SizedBox(height: 25),
                                
                                // Availability toggle group
                                _buildLabel('Availability'),
                                const SizedBox(height: 12),
                                _buildAvailabilityToggleGroup(),
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

  Widget _buildHeaderBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Apply link with filter count
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Apply',
                style: TextStyle(
                  color: AppColors.b4,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_activeFilterCount > 0) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.b4,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$_activeFilterCount',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          
          // Filters title
          Text(
            'Filters',
            style: TextStyle(
              color: AppColors.ge1,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          // Clear all link
          GestureDetector(
            onTap: () {
              if (widget.onClearAll != null) {
                widget.onClearAll!();
              }
              // Reset all filters to default
              setState(() {
                _sortBy = 'Distance';
                _specialisation = 'Physician';
                _rating = 'Any Rating';
                _showVolunteers = false;
                _availability = [];
              });
            },
            child: Text(
              'Clear all',
              style: TextStyle(
                color: AppColors.b4,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.ge1,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
 }

  Widget _buildSortByDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.ge2,
          ),
          style: TextStyle(
            color: AppColors.ge1,
            fontSize: 14,
          ),
          items: _sortByOptions.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _sortBy = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSpecialisationDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _specialisation,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.ge2,
          ),
          style: TextStyle(
            color: AppColors.ge1,
            fontSize: 14,
          ),
          items: _specialisationOptions.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _specialisation = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRatingToggleGroup() {
    return Row(
      children: _ratingOptions.map((rating) {
        bool isSelected = rating == _rating;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _rating = rating;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.b1 : AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? AppColors.b1 : AppColors.ge3,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (rating.contains('★')) ...[
                      Image.asset(
                        'assets/home/star.png',
                        width: 16,
                        height: 16,
                        color: isSelected ? AppColors.white : AppColors.ge2,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      rating,
                      style: TextStyle(
                        color: isSelected ? AppColors.white : AppColors.ge2,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildShowVolunteersToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Show Only Volunteers',
          style: TextStyle(
            color: AppColors.ge1,
            fontSize: 16,
          ),
        ),
        Switch(
          value: _showVolunteers,
          onChanged: (value) {
            setState(() {
              _showVolunteers = value;
            });
          },
          activeThumbColor: AppColors.b4,
          activeTrackColor: AppColors.ge3,
        ),
      ],
    );
  }

  Widget _buildAvailabilityToggleGroup() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _availabilityOptions.map((option) {
        bool isSelected = _availability.contains(option);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _availability.remove(option);
              } else {
                _availability.add(option);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.b1 : AppColors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected ? AppColors.b1 : AppColors.ge3,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.ge2,
                fontSize: 12,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}