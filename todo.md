# Incoming Call Page Todo

## Description
Create an incoming call page with the following components:
- Clean, light-colored background (#F8F9FD)
- Vertically centered content
- Caller information in the middle
- Action buttons at the bottom

## Components (Top to Bottom)
1. App Brand Logo
   - Widget: Image.asset
   - Asset Path: assets/incoming_call/clinico_logo.png
   - Placement: Top center of SafeArea
   - Size: 40-50 pixels height
   - Padding: Moderate top padding

2. Doctor's Profile Image
   - Widget: CircleAvatar or circular Container with image
   - Asset Path: assets/incoming_call/doctor_logo.png
   - Placement: Centered horizontally, below brand logo
   - Size: Radius 80-100 pixels
   - Shape: Perfect circle
   - Effect: Subtle shadow or border

3. Doctor's Name
   - Widget: Text
   - Content: "Dr. Lorem Ipsum"
   - Placement: Centered below profile image
   - Font Size: 24-28 sp
   - Font Weight: Bold
   - Color: #1E293B
   - Padding: Top padding to separate from image

4. Call Status Subtitle
   - Widget: Text
   - Content: "Incoming Video Call..." or "Incoming Audio Call..."
   - Placement: Centered below doctor's name
   - Font Size: 16-18 sp
   - Font Weight: Normal
   - Color: #64748B
   - Padding: Small top padding

5. Call Action Buttons (Bottom Section)
   - Widget: Row with two buttons
   - A. Decline Button:
     * Widget: FloatingActionButton or custom circular button
     * Icon: Icons.call_end
     * Color: #EF4444 (red) with white icon
     * Size: 64x64 pixels
     * Placement: Left side of row
   - B. Accept Button:
     * Widget: FloatingActionButton or custom circular button
     * Icon: Icons.call or Icons.videocam
     * Color: #22C55E (green) with white icon
     * Size: 64x64 pixels
     * Placement: Right side of row
   - Optional: Pulsing or ripple animation on accept button

## Additional Notes
- Match Figma design precisely
- Use assets from designated folder only
- Handle loading and error states
- Follow Clean Architecture principles
- Use proper state management