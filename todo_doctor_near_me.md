# Doctor Near Me Screen - TODO

## Task Overview
Implement the "Doctor Near Me" screen for the Clinico Flutter app. This page provides an interactive, location-based view of dermatologists near the user with map visualization using OpenStreetMap API. The page includes a search bar, interactive map with location markers, and a floating doctor detail card.

## Requirements
- Strictly follow SRS, SDD, and feature documentation
- Match Figma design exactly (use Figma MCP for reference)
- Integrate OpenStreetMap API (using flutter_map or similar package)
- Request and handle location permissions (iOS & Android)
- Implement geolocalization to get user's current location
- Use correct assets from `/assets/ai_chat/` and `/assets/`
- Follow Clean Architecture and state management best practices
- Wait for user review and green light before commit

## Key Features

### 1. Header and Search Component
- Search bar displaying "Dermatologist Near me"
- Left: Magnifying glass icon (search_icon.png)
- Right: Filter/Sort icon (filter_icon.png) with red notification badge showing '1'
- Badge indicates one active filter is currently applied
- Tapping filter icon opens filter/sort modal

### 2. Map Visualization
- Interactive map powered by OpenStreetMap API
- Display street names and landmarks (e.g., "Budella", "AIIMS CGHS")
- User location marker: Bright blue pulsating circle (your_location.png / image_fbbb09.png)
- Doctor location pins: Green teardrop pins with medical icon (doctor_location.png / image_fbbb26.png)
- Map supports pan, zoom, and interactive interactions
- Markers are clickable and trigger the doctor detail card

### 3. Doctor Detail Card (Floating Bottom Card)
- Professional doctor icon/image (image_fbbaeb.png)
- Doctor Name: "Dr. Lorem Ipsum"
- Specialty: "Physician"
- Qualifications: "MBBS, MD"
- Hospital: "ABC Hospital"
- Distance: "1.6 Km Away" (calculated from user location)
- Location pin icon (image_fbbacd.png)
- Rating: "4.7" with star icon
- Blue "View" button to navigate to Doctor Profile Page

### 4. Location Permissions
- Request location permission on app startup
- Handle permission states: granted, denied, restricted
- Display appropriate messages if permission is denied
- Use geolocalization to fetch user's current location (latitude, longitude)

### 5. OpenStreetMap Integration
- Use flutter_map package (or Leaflet.js alternative)
- Fetch map tiles from OpenStreetMap
- Geocoding: Convert doctor addresses to coordinates
- Reverse Geocoding: Convert coordinates to readable addresses
- Handle network requests gracefully
- Cache map data for offline access

## Screen Structure

```
┌─────────────────────────────────────┐
│ 9:41          Signal WiFi Battery   │ (System Status Bar)
├─────────────────────────────────────┤
│ ┌─────────────────────────────────┐ │
│ │ 🔍 Dermatologist Near me    ⚙️1│ │ (Search Bar + Filter)
│ └─────────────────────────────────┘ │
├─────────────────────────────────────┤
│                                     │
│                                     │
│          📍 MAP VIEW                │
│    (OpenStreetMap with Markers)     │
│                                     │
│     🔵 (User Location)              │
│     🟢 (Doctor Pins)                │
│                                     │
├─────────────────────────────────────┤
│ ┌─────────────────────────────────┐ │
│ │👨‍⚕️ Dr. Lorem Ipsum             │ │ (Doctor Detail Card)
│ │   Physician | MBBS, MD          │ │
│ │   ABC Hospital                  │ │
│ │ 📍 1.6 Km Away  ⭐ 4.7  [View]   │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

## Acceptance Criteria
- ✅ Map displays correctly using OpenStreetMap API
- ✅ User location is retrieved and displayed with blue pulsating marker
- ✅ Doctor pins are displayed at correct locations on the map
- ✅ Search bar shows "Dermatologist Near me" with functioning search
- ✅ Filter icon displays red badge with '1' showing active filter
- ✅ Tapping doctor pins displays/updates doctor detail card
- ✅ Doctor detail card shows all information (name, specialty, qualifications, hospital, distance, rating)
- ✅ "View" button navigates to doctor profile page (placeholder is ok)
- ✅ Distance calculations are accurate based on user location
- ✅ Location permissions are properly requested and handled
- ✅ All assets used correctly from designated folders
- ✅ UI matches Figma design exactly
- ✅ Follows Clean Architecture and state management best practices
- ✅ No hardcoded values; all data/models from documentation
- ✅ Build with no errors or warnings
- ✅ Wait for user review and green light before commit

## Technical Implementation Details

### 1. Dependencies to Add
```yaml
# Map and Location
flutter_map: ^6.1.0
latlong2: ^0.9.0
geolocator: ^10.0.0
geocoding: ^2.1.0
permission_handler: ^11.0.0

# State Management (if using BLoC)
flutter_bloc: ^8.1.0
equatable: ^2.0.0
```

### 2. Location Permissions (iOS & Android)
- **Android**: Request permissions in AndroidManifest.xml
  - `android.permission.ACCESS_FINE_LOCATION`
  - `android.permission.ACCESS_COARSE_LOCATION`
- **iOS**: Request permissions in Info.plist
  - `NSLocationWhenInUseUsageDescription`
  - `NSLocationAlwaysAndWhenInUseUsageDescription`

### 3. OpenStreetMap API Integration
- Use `flutter_map` package with OpenStreetMap tile provider
- Fetch tile layers: `https://tile.openstreetmap.org/{z}/{x}/{y}.png`
- Implement marker system for user location and doctor pins
- Handle map interactions (tap, pan, zoom)

### 4. Data Models Required
```dart
class DoctorLocation {
  final int id;
  final String name;
  final String specialty;
  final String qualifications;
  final String hospital;
  final double latitude;
  final double longitude;
  final double rating;
  final String profileImageUrl;
}

class UserLocation {
  final double latitude;
  final double longitude;
}
```

### 5. UI Components
- `_SearchBar` - Search and filter
- `_MapView` - OpenStreetMap with markers
- `_DoctorDetailCard` - Floating card with doctor info
- `_DoctorMarker` - Custom map marker for doctors
- `_UserLocationMarker` - Pulsating user location marker

## File Structure
```
lib/screens/
  └── doctor_near_me_screen.dart        (Main screen)
lib/models/
  └── doctor_location_model.dart        (Data models)
lib/services/
  └── location_service.dart             (Geolocalization service)
  └── doctor_location_service.dart      (Fetch doctor locations)
lib/components/
  └── map_view.dart                     (Reusable map component)
  └── doctor_detail_card.dart           (Reusable detail card)
```

## References
- **SRS**: `/documentation/SRS.md`
- **SDD**: `/documentation/SDD/SDD.md`
- **Features**: `/documentation/features/features.md`
- **Figma**: Use provided link via MCP
- **Assets**: `/assets/ai_chat/`, `/assets/`
- **OpenStreetMap**: https://www.openstreetmap.org/
- **flutter_map**: https://pub.dev/packages/flutter_map
- **geolocator**: https://pub.dev/packages/geolocator
- **Geocoding**: https://pub.dev/packages/geocoding

## Development Steps

1. ✅ Create todo.md (this file)
2. ⏳ Add required dependencies to pubspec.yaml
3. ⏳ Set up location permissions (Android & iOS)
4. ⏳ Create data models for doctor locations and user location
5. ⏳ Implement location service to fetch user's current location
6. ⏳ Implement doctor location service (mock data or API integration)
7. ⏳ Design and implement UI components
8. ⏳ Integrate OpenStreetMap with flutter_map
9. ⏳ Add user location marker (pulsating blue circle)
10. ⏳ Add doctor location markers (green pins)
11. ⏳ Implement marker tap interactions
12. ⏳ Implement doctor detail card with dynamic data
13. ⏳ Calculate and display distance (km)
14. ⏳ Implement search/filter functionality
15. ⏳ Implement "View" button navigation to doctor profile
16. ⏳ Test on both Android and iOS
17. ⏳ Test location permissions (granted, denied, restricted)
18. ⏳ Verify Figma design match
19. ⏳ Code review and cleanup
20. ⏳ Commit and push with green light

## Notes
- Location permission must be requested before map is displayed
- Handle cases where location permission is denied
- Ensure distance calculations use correct formula (Haversine formula for latitude/longitude)
- Test with real device for GPS accuracy
- Consider caching doctor data to reduce API calls
- Add loading indicator while fetching location and doctor data
- Handle network errors gracefully

---

**Status**: Not Started  
**Priority**: High  
**Assigned To**: Development Team  
**Created**: 18 November 2025
