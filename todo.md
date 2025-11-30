# Appointment Booking Screen Update

## Objective
Refactor the "Book Appointment" screen to strictly match the design in the appointment.png reference, implementing the "Clean & Modern" version with proper styling, shadows, and layout.

## Tasks

### 1. Global Styling & Layout
- [ ] Update background color to #F6F8FB (light cool-grey/blue tint)
- [ ] Add horizontal padding (20px) to main content
- [ ] Implement soft, diffused drop-shadow for all white cards/pills
- [ ] Ensure consistent spacing throughout the screen

### 2. Header Implementation
- [ ] Add back arrow icon on the left (dark grey)
- [ ] Center "Book Appointment" text (dark blue, bold, 18-20px)
- [ ] Ensure proper alignment of header components

### 3. Doctor Profile Card
- [ ] Create row layout for doctor profile
- [ ] Add circular doctor avatar with thin light-grey border
- [ ] Implement details column with:
  - [ ] Doctor name "Dr. Lorem Ipsum" (black/dark blue, semi-bold, 16px)
  - [ ] Specialization "Dermatologist | MBBS, MD | AB..." (grey, 12px)
  - [ ] Languages "Languages - Hindi, English" (grey, 12px)
- [ ] Add "Volunteer" badge (blue background #2F80ED, white text, 10px, capsule shape)

### 4. Time Slot Section
- [ ] Add header row with "Time Slot" (black, bold, 16px) on left and "View all" (grey, 12px) on right
- [ ] Implement horizontal scroll list of pill-shaped buttons
- [ ] Create selected style: solid blue background (#2F80ED) with white text
- [ ] Create unselected style: white background, dark grey text, soft shadow
- [ ] Implement logic to hide past time slots for "Today"
- [ ] Show example slots "10:00 AM" (selected) and "4:30 PM" (unselected)

### 5. Date Section
- [ ] Add header row with "Date" (black, bold, 16px) on left and "View all" (grey, 12px) on right
- [ ] Implement horizontal scroll list of pill-shaped date buttons
- [ ] Create selected style: solid blue background (#2F80ED) with white text
- [ ] Create unselected style: white background, dark grey text, soft shadow
- [ ] Implement dynamic date labels: "Tomorrow", "17th Nov", "18th Nov"
- [ ] Start dates from Today/Tomorrow dynamically

### 6. Footer Section
- [ ] Add note text: "Note:- You will get a call from the doctor in app, on your appointment date and specified time." (grey, centered, 12px)
- [ ] Add 20px padding above the confirm button
- [ ] Create "Confirm Appointment" button (full width, solid blue #2F80ED, white bold text, 12px radius, 50px height)

### 7. Functional Logic
- [ ] Implement selection state for time and date pills (clicking updates to selected/deselected)
- [ ] Add navigation to detailed SelectDateAndTime screen when "View all" is clicked
- [ ] Implement validation to prevent selecting past dates/times

### 8. Testing & Validation
- [ ] Verify UI matches appointment.png reference exactly
- [ ] Test all interactive elements
- [ ] Verify responsive design on different screen sizes
- [ ] Check proper handling of current time/date logic