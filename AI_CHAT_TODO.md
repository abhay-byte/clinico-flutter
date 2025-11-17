# AI Chat Screen Implementation

## Task Overview
Create the AI chat screen that allows users to interact with Elphie, the AI mascot. Users navigate to this screen by tapping the "Chat with Elphie" button on the home screen. The screen should feature a welcoming interface with the AI mascot, personalized greeting, and a message input area.

## Design Requirements

### 1. Status Bar
- Standard iOS status bar at the very top
- Shows time, cellular signal, Wi-Fi status, and battery level
- Automatically handled by Flutter on iOS

### 2. Navigation Icons (Top-Left)
Located in the top-left corner with two navigation buttons:

#### Chat Icon
- Indicates the user is in the chat section
- Asset: `assets/home/messages.png`
- Purpose: Visual indicator (may be for consistency)

#### Home Icon
- Outline of a house for navigation back to home screen
- Asset: `assets/ai_chat/home_outline.png`
- Functionality: Tap to navigate back to HomeScreen
- Navigation: `Navigator.pop(context)` or navigate to HomeScreen

### 3. Main Content Area
Central welcoming section with three key elements:

#### AI Mascot "Elphie"
- Friendly blue elephant robot mascot
- Asset: `assets/home/mascot.png`
- Size: Prominently displayed in center-upper portion
- Styling: Should appear friendly and engaging
- Positioning: Above greeting text

#### Greeting Text
- Dynamic personalized greeting: "Hello there {user_name}"
- Typography: Large, bold, dark color (#1F1F1F)
- Font: Roboto, weight 600-700
- Data Source: Should pull user's full_name from users table (for now, use placeholder "Lorem Ipsum")
- Height: Multiple lines with proper line spacing (line-height: 1.3)

#### Instructional Text
- Smaller paragraph text guiding user on interaction
- Text: "Navigate your wellness journey with confidence. Ask Elphie for support, answers, or to book an appointment."
- Typography: Medium size, medium grey color (#717171)
- Font: Roboto, weight 400
- Line spacing: 1.4 for readability

### 4. Query Input Bar (Bottom of Screen)
Text input section for user to send medical queries:

#### Input Field
- White background with rounded corners (border-radius: 8-12px)
- Placeholder text: "Ask any medical query..."
- Padding: Comfortable spacing inside the field
- Active state: Shows keyboard when tapped
- Shadow: Subtle shadow for depth

#### Attach Icon (Plus) - Left Side
- Plus icon for attaching files/images
- Asset: `assets/ai_chat/plus.png`
- Functionality: Would allow users to attach medical records, images, PDFs
- Note: For MVP, can be placeholder (no functionality) or show toast
- Size: 20-24px

#### Send Icon - Right Side
- Paper-airplane style send button
- Asset: `assets/ai_chat/send.png`
- Functionality: Tap to submit user's query to AI service
- Size: 20-24px
- Color: Blue (#248BEB) when active, grey when input is empty
- State: Should be disabled/greyed out when input field is empty

## Implementation Progress

### Not Started
- [ ] Create ai_chat_screen.dart file
- [ ] Build top navigation bar with chat and home icons
- [ ] Implement greeting text with user name placeholder
- [ ] Add Elphie mascot image
- [ ] Create instructional text section
- [ ] Design query input bar with icons
- [ ] Implement send button functionality
- [ ] Add attach icon placeholder
- [ ] Connect home icon navigation
- [ ] Set up keyboard behavior
- [ ] Test UI rendering and layout
- [ ] Verify all assets load correctly

## Implementation Steps

1. **Create AI Chat Screen File**
   - Create `lib/screens/ai_chat_screen.dart`
   - Set up StatefulWidget structure
   - Add TextEditingController for message input

2. **Build Top Navigation Bar**
   - Add SafeArea for proper spacing
   - Create row with chat icon and home icon
   - Chat icon: decorative (indicates current section)
   - Home icon: functional (navigates back)

3. **Design Main Welcome Section**
   - Add Elphie mascot image (centered, prominent size)
   - Create greeting text "Hello there Lorem Ipsum"
   - Add instructional text below greeting
   - Use proper typography and spacing

4. **Implement Query Input Bar**
   - Create white rounded text input field
   - Add plus icon on left (attach files)
   - Add send icon on right (submit query)
   - Make send icon state-dependent (enabled/disabled based on input)

5. **Add Navigation**
   - Home icon navigates back to HomeScreen
   - Handle pop navigation with Navigator.pop()

6. **Connect to Home Screen**
   - Update "Chat with Elphie" button in home screen to navigate to this screen
   - Button should navigate with: `Navigator.push(context, MaterialPageRoute(builder: (context) => const AiChatScreen()))`

7. **Handle Keyboard Behavior**
   - Ensure input field focuses properly
   - Input bar should be above keyboard
   - Use SingleChildScrollView or Column with appropriate layout

8. **Styling & Polish**
   - Apply proper colors from AppColors
   - Match Figma design precisely
   - Ensure consistent spacing and typography
   - Test on different screen sizes

9. **Testing**
   - Build and run the app
   - Navigate from home screen to AI chat screen
   - Verify UI matches Figma design
   - Test home icon navigation
   - Check keyboard behavior
   - Verify send button state changes with input
   - Check all images load correctly

## Assets to Use
- `assets/home/mascot.png` - Elphie AI mascot
- `assets/home/messages.png` - Chat icon (decorative)
- `assets/ai_chat/home_outline.png` - Home navigation icon
- `assets/ai_chat/plus.png` - Attach/file upload icon
- `assets/ai_chat/send.png` - Send message icon

## Color Scheme (from AppColors)
- Background: Light Grey-Blue (#EBF1FA) - bg1
- Input Field Background: White (#FFFFFF)
- Text Primary: Dark Grey (#1F1F1F) - ge1
- Text Secondary: Medium Grey (#717171) - ge2
- Icons Color: Medium Grey (#717171) - ge2
- Send Icon (Active): Bright Blue (#248BEB) - b4
- Send Icon (Inactive): Light Grey (#E5E5E5) - ge3

## Data Flow & Future Integration
- User name: Currently use placeholder "Lorem Ipsum", later fetch from users table
- Message storage: Messages sent would be stored in ai_chat_logs table
- Attach functionality: Files would be stored as medical_records
- AI service: Integration with AI_Agent_Service for query processing

## Database References (for future implementation)
- Users table: `full_name` column for personalized greeting
- AI Chat Logs: Store all messages exchanged with Elphie
- Medical Records: Store attached files/images

## Navigation Hierarchy
```
HomeScreen
    ↓ (Chat with Elphie button)
AiChatScreen
    ↓ (Home icon)
HomeScreen
```

## Notes
- The screen should feel welcoming and encourage user engagement
- Elphie is the central personality of the chat interface
- The input bar should always be visible at the bottom
- Consider using a ListView or CustomScrollView for future message history
- For now, focus on the welcome screen layout without chat history
- Send button should validate input before sending
- Consider empty state handling for when no messages have been sent
