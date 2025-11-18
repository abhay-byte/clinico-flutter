# Book Appointment Screen Todo

## Description
Implement the complete functionality and UI for the Appointment Booking Confirmation Screen, using the provided image assets from the 'assets/book_appointment/' folder.

## Requirements

### 1. UI Structure and Asset Integration:
- [ ] Use the image 'assets/book_appointment/back.png' for the back navigation icon
- [ ] Use 'assets/book_appointment/doctor_logo.png' for the circular profile image in the summary header
- [ ] Implement the Time Slot and Date chips as shown in the image, ensuring the selected chips use blue styling

### 2. Time Slot Selection Logic (State Management):
- [ ] Define a state variable (e.g., `selectedTime`) to hold the user's selected time slot
- [ ] Create the Time Slot chip widgets (e.g., "10:00 AM", "4:30 PM")
- [ ] When a chip is tapped, update the state and apply the blue selected style

### 3. Date Selection Logic (State Management):
- [ ] Define a state variable (e.g., `selectedDate`) to hold the user's selected appointment date
- [ ] Create the Date chip widgets (e.g., "Tomorrow", "17th Nov", "18th Nov")
- [ ] When a chip is tapped, update the state and apply the blue selected style

### 4. Note Text Block:
- [ ] Include the informational note exactly as shown: "Note:- You will get a call from the doctor in app, on your appointment date and specified time."

### 5. Confirm Appointment Button Logic:
- [ ] The button should be a large, full-width blue button
- [ ] Implement the `onPressed` handler:
  - [ ] Check if both a `selectedTime` and a `selectedDate` have been chosen
  - [ ] If data is missing, show a user-friendly error (e.g., Snackbar)
  - [ ] If both are selected, simulate a booking API call and then navigate the user to the "Appointment Confirmed" screen (e.g., a simple push to a new screen named 'AppointmentConfirmationScreen')

### 6. Additional Implementation:
- [ ] Create the complete, self-contained Flutter code for this StatefulWidget
- [ ] Include all required imports, state variables, chip selection logic, and the final button action
- [ ] Use the specified asset paths
- [ ] Ensure the screen is accessible from the doctor profile screen when "Book Appointment" is clicked