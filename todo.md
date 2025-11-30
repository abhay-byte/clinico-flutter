# Date and Time Selection Screen Todo

## Overview
Build the "Select Date And Time" screen that opens when the user clicks the "View All" link on the Book Appointment screen.

## Design Requirements
- Background: Light cool-grey/blue tint (#F6F8FB)
- Padding: 20px horizontal padding for main content
- Follow visual design in Select Date And Time.png

## Components to Implement

### 1. Header
- Back Arrow icon (<) for navigation back to Book Appointment screen
- Title: "Select Date And Time" (Dark Blue, Bold, approx 20px)
- Centered or Left-aligned text

### 2. Custom Calendar View
- Do NOT use native date picker
- Build custom grid view to match design

#### Month/Year Header
- Row at top of calendar
- Left Text: "Nov" (Black, Medium)
- Center/Right Text: "2025" (Blue #2F80ED, Bold)
- Functionality: Swipe or click to change months

#### Days of Week
- Row: M T W T F S S
- Style: Black, Bold, evenly spaced

#### Date Grid
- 7-column grid layout
- Visual States:
  - Previous Month Dates: Grey/Muted text
  - Available Dates: Black text
  - Selected Date: Solid Blue Circle (#2F80ED) with White Text
- Logic:
  - Users can select only one date at a time
  - Disable interaction for past dates
  - If "Today" is 16th, days 1-15 non-clickable

### 3. Available Time Slot Section
- Heading: "Available Time Slot" (Black, Bold, 16px)
- Display time slots in wrapped row or horizontal list
- Selected Style: Solid Blue Background (#2F80ED), White Text
- Unselected Style: White Background, Grey Text, Soft Drop Shadow, Rounded Corners
- Logic: Update dynamically based on selected date
  - If user selects "Today", hide passed time slots

### 4. Footer Action
- Button: "Set Appointment"
- Style: Full-width, Solid Blue (#2F80ED) background, White Bold text, rounded corners
- Action: Save selectedDate and selectedTime, navigate to Confirmation Screen

## Functional Requirements
- State Management:
  - selectedDate: Defaults to Current Date
  - selectedTime: Defaults to null or first available slot
- Navigation Animation: Push animation (slide in from right) when opening

## Implementation Steps
1. Create custom calendar widget
2. Implement month navigation functionality
3. Create time slot selection
4. Add date/time state management
5. Connect navigation from Book Appointment screen
6. Style according to design reference
7. Test functionality
8. Verify with design mockup