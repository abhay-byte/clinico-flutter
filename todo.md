# TODO List

## Navigation Implementation from Home Screen to Doctor List

### Task: Make doctors type on home page navigable to doctor list

#### Description:
I need to implement navigation from my Home Screen categories to the Doctor List screen.

Current State:
- I have a HomeScreen with a grid of categories (Psychiatrist, Dentist, Cardiologist, etc.).
- I have a DoctorListScreen that currently lists all doctors (Dr. Lorem Ipsum).

Requirement: When a user taps on a specific category icon in the HomeScreen (e.g., 'Dentist'), the app should navigate to the DoctorListScreen.

#### Key Functionality Required:
1. Update the DoctorListScreen to accept a categoryName parameter (String) in its constructor.
2. Use this categoryName to filter the list of doctors shown or update the page title (e.g., 'Dentist Near Me').
3. On the HomeScreen, add an onTap or InkWell to each category item. When tapped, push the DoctorListScreen and pass the corresponding category name (e.g., if I click 'Dental', pass 'Dental' or 'Dentist').
4. Generate the code for the updated DoctorListScreen and the navigation logic for the HomeScreen category widgets.

#### Files to Modify:
- lib/screens/doctor_list_screen.dart
- lib/screens/home_screen.dart

#### Acceptance Criteria:
- [ ] DoctorListScreen accepts categoryName parameter
- [ ] DoctorListScreen filters doctors based on category
- [ ] HomeScreen category items are tappable
- [ ] Navigation works from HomeScreen to DoctorListScreen with category parameter
- [ ] Category-specific doctor lists display correctly
- [ ] UI matches design requirements