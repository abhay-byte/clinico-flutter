# Incoming Video Call Screen Todo

## Task Description
Create an incoming video call screen with a permission modal that sits on top of the existing "Active Call" screen with a blurred background.

## Requirements
1. Create a video permission modal that overlays the active call screen
2. The modal should have:
   - White rounded rectangle container (radius: 20, width: 300, padding: 20)
   - Video camera icon (dark blue #0E2C66, size: 60x60)
   - Title "Start to Video Call?" (bold, dark blue #0E2C66)
   - Subtitle "Give Permission for camera and start video call." (gray, centered)
   - Blue "Continue" button (fill: #2F80ED, height: 50)
3. Add blur effect (radius: 10) to background when modal is visible
4. Add temporary debug button to test modal
5. Add state variable `showVideoPermission` to control modal visibility

## Implementation Steps
1. Create incoming_video_call_screen.dart file
2. Implement the video permission modal as specified
3. Add state variable for video permission modal
4. Implement overlay logic with blur effect
5. Design the permission modal with icon, title, subtitle and button
6. Add temporary test button for debugging
7. Test the implementation
8. Get user approval before committing