# Ongoing Audio Call Screen - Todo List

## Task: Create Ongoing Audio Call Screen

### Description
I need to implement an ongoing audio call screen with the following features:
1. Visual fixes for layout and style
2. State management for call status (incoming, active, ended)
3. Slide-to-answer functionality with drag gestures
4. Navigation logic between incoming call and active call screens
5. Proper UI components for both incoming and ongoing call states

### Requirements

#### 1. Visual Fixes (Layout & Style):
- [ ] Fix top logo: Remove shadow behind circular logo, ensure frame is exactly width: 120, height: 120
- [ ] Implement floating call button layout using proper Flutter layout widgets
- [ ] Create blue container with height 80 containing 'Decline' (left) and 'Accept' (right) text
- [ ] Position white circular call button (frame 100x100) above the blue container with floating effect
- [ ] Ensure the white button is not clipped by the blue bar

#### 2. Interaction & Navigation Logic:
- [ ] Create state management for call status (incoming, active, ended)
- [ ] Implement drag gesture functionality on the white button
- [ ] Dragging right should transition to 'In Call' screen
- [ ] Dragging left should decline the call
- [ ] Implement 'In Call' view with doctor profile, 'Voice Call' text and timer
- [ ] Add bottom controls with Speaker, Mute, and Leave buttons for active call

#### 3. Implementation Tasks:
- [ ] Create the incoming call screen widget
- [ ] Create the ongoing call screen widget
- [ ] Implement state management using appropriate Flutter state management
- [ ] Add drag gesture detection for slide-to-answer functionality
- [ ] Add proper UI components matching the design requirements
- [ ] Ensure proper navigation between states
- [ ] Add timer functionality for ongoing call
- [ ] Add proper icons for Speaker, Mute, and Leave buttons
- [ ] Test UI elements for proper sizing and positioning
- [ ] Add proper error handling and edge cases
- [ ] Verify UI matches design specifications
- [ ] Test on different screen sizes
- [ ] Add accessibility features if needed
- [ ] Add proper documentation and comments
- [ ] Final testing and debugging
- [ ] Commit the changes after user approval