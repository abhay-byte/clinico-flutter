# Search Page Implementation

## Task Overview
Create the search page that appears when tapping on "see all" or "view all doctors" button on the home page. This page will contain a search bar and a list of doctors with their details.

## UI Requirements
1. General Layout & Background
   - Background Color: Light off-white or light gray (#F5F6F8)
   - Padding: Horizontal padding of 16px-20px

2. Search Bar (Top Header)
   - Style: Floating, pill-shaped search field
   - Appearance: Pure white background with soft drop shadow
   - Shape: Fully rounded corners (stadium border)
   - Content:
     - Left: Search icon (assets/home/search.png) in grey
     - Center: Placeholder text "Dermatologist Near Me" in dark grey
     - Right: Filter settings icon (assets/home/filter.png) in grey

3. Doctor List Container
   - Structure: Large continuous white card
   - Shape: Rounded corners at top (rounded-2xl), likely at bottom too
   - Separators: Thin light grey horizontal dividers between items (not full width)

4. Individual Doctor List Item (Row)
   - Layout: Three sections (Avatar, Info, Stats)
   
   A. Left Section (Avatar):
      - Doctor's photo from assets/doctor_profile/ or assets/home/doctor_icon.png
      - Circular or squircle mask with light background color
   
   B. Middle Section (Info):
      - Name: "Dr. Lorem Ipsum" - Black text, Semi-Bold, 14px-16px
      - Subtitle: "Dermatologist | MBBS, MD | [Hospital Name]..." - 12px, grey
   
   C. Right Section (Stats):
      - Top: Rating with star icon (assets/home/star.png) and rating text (e.g., "4.7")
      - Bottom: Distance with location pin (assets/home/location.png) and distance text (e.g., "1.6 km")

## Implementation Steps
1. Create the search page UI with the specified layout
2. Implement the floating search bar with proper styling
3. Create the doctor list container with rounded corners
4. Design the individual doctor list item with three sections
5. Implement dummy data for 5-6 doctors with varying ratings and distances
6. Add search functionality to filter the doctor list
7. Ensure proper spacing and alignment of all elements
8. Test the page for proper functionality and UI compliance

## Assets to Use
- Search Icon: assets/home/search.png
- Filter Icon: assets/home/filter.png
- Star Icon: assets/home/star.png
- Location Pin: assets/home/location.png
- Doctor Placeholder: assets/home/doctor_icon.png or from assets/doctor_profile/

## Data Model
- Generate dummy list of 5-6 doctors
- Vary ratings (4.7, 4.2, 3.9) and distances (1.6 km, 2.2 km)
- Names can be "Dr. Lorem Ipsum" but vary Hospital names (ABC Hospital, XYZ Hospital)