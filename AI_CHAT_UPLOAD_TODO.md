# AI Chat Upload Image and Document

## Task Overview
Create a pop-up menu that appears when the plus icon is tapped on the AI chat input bar. The menu should provide options to upload documents (PDFs) and images, with proper visual feedback and navigation integration.

## Design Requirements

### 1. Background (Faded)
- The AI chat input bar becomes faded/blurred when the pop-up menu is active
- Indicates that the pop-up menu is the active/focused element
- Plus icon and send icon remain visible on the underlying blurred bar
- Background blur effect to dim the underlying content

### 2. Pop-up Menu Container
A white, rounded-rectangle container that displays upload options:

#### Container Properties:
- Background: White (#FFFFFF)
- Border Radius: Rounded corners (8-12px)
- Shadow: Subtle shadow for depth (elevation effect)
- Position: Originates from/appears above the plus icon
- Origin: Common UI pattern - pop-up appears from the icon that triggered it

#### Menu Layout:
- Vertical stack of options
- Proper padding and spacing between items
- Each option is a tappable row with icon and text

### 3. "Upload Document" Option
Top menu item for file/document uploads:

#### Components:
- **Icon (Left)**: PDF document icon
  - Asset: `assets/ai_chat/upload_document.png`
  - Size: 24x24 px
  - Color: Medium Grey (#717171)
  - Represents document/file upload capability

- **Text (Right)**: "Upload Document"
  - Typography: Roboto, 14px
  - Color: Dark Grey (#1F1F1F)
  - Font Weight: 500
  - Proper padding from icon

#### Functionality:
- Tap to open device's file picker
- Allow selection of document files (primarily PDFs)
- Intended for medical records, lab reports, prescriptions, etc.
- Selected file should be displayed or confirmed in the chat interface

#### Action Flow:
1. User taps "Upload Document"
2. File picker opens (iOS Files app or similar)
3. User selects a document
4. File is processed and may be displayed in chat

### 4. "Upload Image" Option
Second menu item for image/photo uploads:

#### Components:
- **Icon (Left)**: Image icon (sun and mountains)
  - Asset: `assets/ai_chat/upload_image.png`
  - Size: 24x24 px
  - Color: Medium Grey (#717171)
  - Represents photo/image upload capability

- **Text (Right)**: "Upload Image"
  - Typography: Roboto, 14px
  - Color: Dark Grey (#1F1F1F)
  - Font Weight: 500
  - Proper padding from icon

#### Functionality:
- Tap to open camera or photo gallery
- Allow selection of images from device
- Intended for medical images (rashes, injuries, etc.)
- Selected image should be displayed in chat

#### Action Flow:
1. User taps "Upload Image"
2. Image picker opens (Camera or Gallery)
3. User takes photo or selects from gallery
4. Image is processed and displayed in chat

## Implementation Progress

### Not Started
- [ ] Create upload menu component/widget
- [ ] Implement pop-up menu with proper positioning
- [ ] Add background blur/fade effect
- [ ] Create "Upload Document" menu item
- [ ] Create "Upload Image" menu item
- [ ] Implement file picker integration
- [ ] Implement image picker integration
- [ ] Add menu animation (slide up/fade in)
- [ ] Handle menu dismissal
- [ ] Add file/image display logic
- [ ] Connect plus icon to show menu
- [ ] Test menu interactions
- [ ] Test file/image selection
- [ ] Verify asset loading

## Implementation Steps

1. **Create Upload Menu Component**
   - Create `lib/components/ai_chat_upload_menu.dart`
   - Implement as a StatelessWidget or reusable component
   - Build menu container with rounded corners and shadow
   - Create menu items list

2. **Implement Menu Items**
   - "Upload Document" option with PDF icon
   - "Upload Image" option with image icon
   - Each item is a GestureDetector for tap detection
   - Proper spacing and padding between items

3. **Add Background Blur/Fade Effect**
   - Implement overlay/backdrop that fades the background
   - Use barrierColor or similar overlay mechanism
   - Keep plus and send icons visible behind the blur

4. **Integrate with AI Chat Screen**
   - Update `ai_chat_screen.dart` to show menu on plus icon tap
   - Show menu as a pop-up/overlay
   - Position menu above the plus icon
   - Handle menu dismissal (tap outside, select option)

5. **Add File Picker Integration**
   - Use `file_picker` package or native file selection
   - Handle "Upload Document" tap
   - Open file picker for document selection
   - Filter to show document types (PDF, etc.)

6. **Add Image Picker Integration**
   - Use `image_picker` package or native image selection
   - Handle "Upload Image" tap
   - Open image picker (camera or gallery)
   - Process selected image

7. **Add Menu Animation**
   - Slide up animation when menu appears
   - Fade in effect for smooth appearance
   - Optional: Slide down/fade out when dismissed

8. **Implement Menu Dismissal**
   - Tap outside menu to close
   - Menu closes on option selection
   - Proper state management

9. **Handle File/Image Processing**
   - Display selected file/image in chat interface
   - Show file name or image preview
   - Add to message history/ai_chat_logs
   - Store in medical_records table

10. **Update Plus Icon Behavior**
    - Plus icon tap shows upload menu
    - Plus icon has visual feedback (highlight, color change)
    - Menu position calculated from icon position

11. **Testing**
    - Build and run the app
    - Navigate to AI chat screen
    - Tap plus icon and verify menu appears
    - Test "Upload Document" option
    - Test "Upload Image" option
    - Test menu dismissal
    - Verify file/image selection works
    - Check visual appearance matches design
    - Test on different screen sizes

## Assets to Use
- `assets/ai_chat/upload_document.png` - PDF document icon
- `assets/ai_chat/upload_image.png` - Image/photo icon
- Plus icon already exists: `assets/ai_chat/plus.png`
- Send icon already exists: `assets/ai_chat/send.png`

## Color Scheme (from AppColors)
- Menu Background: White (#FFFFFF)
- Icon Color: Medium Grey (#717171) - ge2
- Text Color: Dark Grey (#1F1F1F) - ge1
- Menu Divider: Light Grey (#E5E5E5) - ge3
- Background Overlay: Black with opacity (0.3-0.4)
- Shadow: Black with opacity (0.05-0.1)

## Packages Required
- `file_picker: ^version` - For document selection (may need to add to pubspec.yaml)
- `image_picker: ^version` - For image/camera selection (may need to add to pubspec.yaml)

## State Management Considerations
- Menu visibility state (show/hide)
- Selected file/image state
- Menu animation state
- Loading state for file/image processing

## Navigation & Integration
- Plus icon in `ai_chat_screen.dart` triggers menu
- Menu overlays the chat input bar
- Menu items navigate to file/image pickers
- Selected file/image data flows back to chat interface

## Database Integration (Future)
- ai_chat_logs: Store message with attached file/image reference
- medical_records: Store file/image data with metadata
- Store file type, size, timestamp
- Link to user and chat session

## UI/UX Considerations
- Menu should appear near the plus icon
- Proper spacing from edges of screen
- Large enough tap targets (minimum 44px)
- Smooth animations for professional feel
- Clear icons and text for easy understanding
- Dismiss menu on selection or tap outside
- Visual feedback on menu item tap (highlight, etc.)

## Notes
- Menu is a temporary overlay, not a permanent screen
- Should handle both file picker and image picker permissions
- Consider showing file name or image preview after selection
- Could display attachment preview in chat message
- Future: Support multiple file types, drag-drop, etc.
- Consider file size limits and validation
