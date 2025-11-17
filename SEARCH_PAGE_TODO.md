# Search Page Implementation

## Task Overview
Create a comprehensive search page that displays when the search component is tapped from the home page. The page should feature a search bar with filter capabilities and display a scrollable list of doctor cards with ratings and distance information.

## Design Requirements

### 1. Search and Filter Bar
Located at the very top of the screen with three main components:

#### Components:
- **Search Icon (Left)**: Standard magnifying glass icon indicating search field
- **Query Text (Center)**: Display user's active search query (e.g., "Dermatologist Near Me")
- **Filter Icon (Right)**: Filter/slider icon that opens the Advanced Filtering System
  - Asset: `assets/app/home/filter.png`
  - Functionality: Opens filter modal (already implemented)

#### Visual Design:
- White background with rounded corners
- Search bar should remain visible and active at the top
- Styled as primary input element

### 2. Search Results List
Displays results below the search bar with a dark translucent overlay separating results from keyboard.

#### Result Card Structure (Three Columns):

**Column A - Doctor Avatar (Left)**
- Visual identifier for the doctor
- Uses placeholder icons based on provider gender:
  - Male Doctor: `assets/app/home/doctor_male.png` (used in results 1 & 4)
  - Female Doctor: `assets/app/home/doctor_female.png` (used in results 2 & 3)

**Column B - Doctor Information (Center)**
- Line 1: Doctor Name (e.g., "Dr. Lorem Ipsum")
- Line 2: Professional Details (e.g., "Dermatologist | MBBS, MD | ABC Hos...")
  - Includes: Specialty | Credentials | Hospital (truncated with ellipsis)

**Column C - Quick Metrics (Right)**
- Rating: Star icon + numerical rating (e.g., 4.7)
  - Data from Quality Management System (FR-7.2)
- Distance: Location pin icon + distance from user (e.g., 1.6 km)
  - Key function of Hyperlocal feature

#### Sample Results:
1. Male Doctor | Dr. Lorem Ipsum | Dermatologist... ABC Hos... | ⭐ 4.7 | 📍 1.6 km
2. Female Doctor | Dr. Lorem Ipsum | Dermatologist... XYZ Hos... | ⭐ 4.2 | 📍 2.2 km
3. Female Doctor | Dr. Lorem Ipsum | Dermatologist... LMN Hos... | ⭐ 3.9 | 📍 5.6 km
4. Male Doctor | Dr. Lorem Ipsum | Dermatologist... PQR Hos... | ⭐ 3.8 | 📍 7.1 km

### 3. System Keyboard
- Standard light-theme iOS keyboard at bottom of screen
- Indicates search bar is active/focused element
- User can immediately type to modify search query
- All standard keys visible (QWERTY, space, return, emoji, voice dictation)

## Implementation Progress

### Not Started
- [ ] Create search_screen.dart component file
- [ ] Implement search bar UI with icon and filter button
- [ ] Create doctor card component for displaying results
- [ ] Implement search results list with sample data
- [ ] Set up keyboard interaction and search input
- [ ] Add proper spacing and visual hierarchy
- [ ] Connect filter button to existing filter modal
- [ ] Test UI rendering and layout
- [ ] Verify asset paths and icons display correctly
- [ ] Test on different screen sizes

## Implementation Steps

1. **Create Search Screen File**
   - Create `lib/screens/search_screen.dart`
   - Set up basic StatefulWidget structure

2. **Design Search Bar**
   - Implement white rounded search bar container
   - Add search icon (left)
   - Add text input field (center)
   - Add filter icon button (right) with onTap navigation to filter modal

3. **Create Doctor Card Component**
   - Create `lib/components/doctor_card.dart`
   - Implement three-column layout (avatar, info, metrics)
   - Handle both male and female doctor icons
   - Display name, specialty, credentials, hospital
   - Show rating with star icon
   - Show distance with location pin icon

4. **Implement Results List**
   - Create ListView or CustomScrollView for results
   - Add 4 sample doctor results with provided data
   - Apply dark translucent overlay effect
   - Ensure scrollability

5. **Handle Keyboard Integration**
   - Ensure search bar is focused and keyboard appears
   - Handle text input and search query updates
   - Provide visual feedback for active search

6. **Connect to Home Screen**
   - Ensure search page opens when search component is tapped
   - Pass search query if available from home screen

7. **Styling & Polish**
   - Apply proper colors from AppColors
   - Match Figma design precisely
   - Ensure consistent spacing and typography
   - Test with keyboard visible/hidden

8. **Testing**
   - Build and run the app
   - Verify UI matches Figma design
   - Test search bar functionality
   - Test filter button navigation
   - Check card rendering with sample data
   - Verify keyboard behavior

## Assets to Use
- `assets/app/home/filter.png` - Filter icon in search bar
- `assets/app/home/doctor_male.png` - Male doctor placeholder
- `assets/app/home/doctor_female.png` - Female doctor placeholder
- `assets/app/home/star.png` - Star icon for ratings
- `assets/app/home/location/` - Location pin icon for distance

## Color Scheme (from AppColors)
- Background: White (#FFFFFF)
- Search Bar: White (#FFFFFF) with shadow
- Text Primary: Dark Grey (#1F1F1F)
- Text Secondary: Medium Grey (#717171)
- Accent: Bright Blue (#248BEB)
- Overlay: Dark translucent (for keyboard area)

## Notes
- The search page should maintain consistency with existing design system
- Doctor card component can be reused in other parts of the app
- Keyboard should automatically appear when search screen loads
- Search bar should remain visible when scrolling results
- Filter modal already exists and should be triggered by filter icon
