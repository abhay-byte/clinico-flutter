# Doctor List Screen Development Task

## Overview
Create a doctor list screen that appears as a popup on the "doc_near_me" screen. This screen should provide an immediate, location-based view of requested medical services.

## Requirements

### 1. Header and Search Component
- Create a search bar at the top
- Search query should show "Dermatologist Near me" (or relevant specialty)
- Include search icon on the left
- Add filter/sort icon on the right with red notification badge showing '1'
- Badge indicates one active filter/sorting criterion

### 2. Map Visualization
- Implement interactive map as central content
- Display street names and location markers
- Show user's current location with blue pulsating circle
- Add directional indicator showing device orientation
- Place green teardrop-shaped pins for doctor locations
- Pins should have white silhouette of person with stethoscope

### 3. Interactive Doctor Detail Card
- Create floating card at bottom of screen
- Display when doctor pin is selected
- Include doctor image/icon
- Show doctor name ("Dr. Lorem Ipsum")
- Display specialty ("Physician") and qualifications ("MBBS, MD")
- Show hospital affiliation ("ABC Hospital")
- Include location pin icon with distance ("1.6 Km Away")
- Add star rating ("4.7")
- Create blue "View" action button

### 4. Technical Implementation
- Implement location permission request
- Integrate OpenStreetMap API for map functionality
- Create geolocation/reverse geocoding for distance calculation
- Handle map tile fetching and rendering
- Implement interactive markers management
- Design responsive layout for all screen sizes

### 5. Assets Required
- Location icons for user position
- Doctor pin icons
- Map-related assets
- Rating star icons
- Search/filter icons

### 6. Navigation
- Connect "View" button to detailed doctor profile page
- Enable appointment booking functionality
- Ensure smooth transitions between screens