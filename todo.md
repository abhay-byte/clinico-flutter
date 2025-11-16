# Search Filter Modal Implementation

## Task Overview
Create a bottom sheet modal that slides up from the bottom when the filter.png icon in the Home screen's search bar is tapped. The modal should blur and dim the UI elements behind it.

## Design Requirements

### Visual Elements
- Tall white card (#FFFFFF) with rounded top corners
- Grey grab handle (#E5E5E5) at top-center
- Blurred and dimmed background UI

### Components to Implement

#### 1. Header Bar
- "Apply" link (left) - Bright Blue (#248BEB)
- "Filters" title (center) - Dark Grey (#1F1F1F) bold
- "Clear all" link (right) - Bright Blue (#248BEB)

#### 2. Sort by Dropdown
- Label: "Sort by" - Dark Grey (#1F1F1F) bold
- Collapsed: White pill-shaped button with shadow, showing "Distance" and dropdown arrow
- Expanded: Options with selected option (#D7F1FF background, #1F1F1F text) and unselected options (#248BEB background, #FFFFFF text)

#### 3. Specialisation Dropdown
- Label: "Specialisation" - Dark Grey (#1F1F1F) bold
- Same as Sort by dropdown but showing "Physician" as default

#### 4. Rating Toggle Group
- Label: "Rating" - Dark Grey (#1F1F1F) bold
- Three pill-shaped buttons: "Any Rating", "> 4 ★", "> 3 ★"
- Selected: Light Grey (#E5E5E5) background, Dark Grey (#1F1F1F) text
- Unselected: White background, Medium Grey (#717171) text, Light Grey (#E5E5E5) border
- Use star.png asset for star icons

#### 5. Show Only Volunteers Toggle
- Label: "Show Only Volunteers" - Dark Grey (#1F1F1F)
- Toggle switch:
  - Off: Light Grey (#E5E5E5) track, handle on left
  - On: Bright Blue (#248BEB) track, handle on right

#### 6. Availability Toggle Group
- Label: "Availability" - Dark Grey (#1F1F1F) bold
- Five pill-shaped buttons: "Today", "Tomorrow", "This Week", "Weekdays", "Weekends"
- Selected: Light Grey (#E5E5E5) background, Dark Grey (#1F1F1F) text
- Unselected: White background, Medium Grey (#717171) text, Light Grey (#E5E5E5) border

## Implementation Progress

### Completed Tasks
1. Created search filter modal component with blur effect
2. Implemented header bar with Apply, Filters title, and Clear all functionality
3. Created Sort by dropdown with proper states
4. Created Specialisation dropdown with proper states
5. Implemented Rating toggle group with proper states
6. Implemented Show Only Volunteers toggle switch
7. Created Availability toggle group with proper states
8. Connected modal to filter button in Home screen
9. Updated colors for active states to b1 (#174B80) as requested

### Problems Faced
1. Initial implementation had issues with the rating toggle group where there was duplication in the code
2. Had to ensure proper color scheme implementation according to the color palette
3. Needed to properly handle state management for multiple filter options

### New Changes to Implement
1. Add dropdown animation using Flutter's default dropdown component
2. Add small number indicator showing how many filters are applied
3. Update active toggle colors to b1 (#174B80) as per user request
4. Ensure "Today" and other selected components also turn to b1 color

## Implementation Steps
1. Create new component file for the filter modal
2. Implement the blurred background effect (similar to location modal)
3. Create the header bar with Apply, Filters title, and Clear all
4. Implement dropdown functionality for Sort by and Specialisation
5. Create toggle group for Rating
6. Implement toggle switch for Volunteers
7. Create multi-select toggle group for Availability
8. Connect to filter button in Home screen
9. Add proper state management for all filter options
10. Test UI with all states and interactions
11. Add dropdown animations using Flutter's default dropdown
12. Add filter count indicator

## Assets to Use
- assets/home/star.png (for rating stars)
- assets/home/filter.png (for the filter button in search bar)
- Use colors from AppColors palette as specified