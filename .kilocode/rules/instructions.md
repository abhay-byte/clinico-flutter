# Copilot Instructions for Clinico Mobile App (Flutter Frontend)

## Project Overview
This is the frontend Flutter mobile application for the Clinico project, a comprehensive healthcare management system. The app is located at `/frontend/clinico_mobile_app` and follows a structured, phase-based development approach.

## Documentation Structure
All project documentation is centralized and must be strictly followed:

### Core Documentation
- **Complete Documentation Root**: `/documentation`
- **SRS (Software Requirements Specification)**: `/documentation/SRS.md`
- **SDD (Software Design Document)**: `/documentation/SDD/SDD.md`
- **Features Specification**: `/documentation/features/features.md`
- **Database Schema**: `/documentation/database/readme.md`

### Diagrams & Architecture
- **Complete Diagrams**: `/documentation/diagrams`
- **ER Diagram**: `/documentation/diagrams/err/readme.md`
- **DFD (Data Flow Diagram)**: `/documentation/diagrams/dfd/readme.md`
- **Flow Charts**: `/documentation/diagrams/flow-charts/readme.md`
- **Low-Level Design**: `/documentation/diagrams/low-level-design/readme.md`

## Critical Rules

### 1. Documentation Compliance
- **ALWAYS** refer to the documentation before implementing any feature
- **NEVER** deviate from the specifications in SRS, SDD, and feature documentation
- **VERIFY** data models against the database schema and ER diagrams
- **CROSS-REFERENCE** flow charts and DFD diagrams to understand data flow

### 2. One Development Cycle Workflow

#### Development Process:

**1. Receive Instructions**
- User provides ONE page/screen to build
- Complete instructions on components, functionality, and structure
- Assets provided in `/assets/[screen_name]` folder (e.g., `/assets/home` for home page)
- Figma link provided for design reference

**2. Build Phase**
- Access Figma design using Figma MCP
- Implement the screen following instructions exactly
- Use assets from the designated folder
- Match Figma design precisely
- Build all components as specified

**3. Review Phase**
- User checks the built screen
- User verifies UI matches design
- User checks for errors or issues
- User provides feedback

**4. Green Light**
- Only after user approves everything
- Only after all corrections are done
- Only after user confirms "all things are correct"

**5. Commit Phase** (Only after Green Light)
- `git add .`
- `git commit -m "feat(screen-name): implement [screen name]"`
- `git push origin [branch-name]`

**6. Move to Next Screen**
- Cycle repeats for next page

#### Assets Organization
- Each screen has its own assets folder
- Path format: `/assets/[screen_name]/`
- Example: Home screen assets → `/assets/home/`
- All images, icons, and resources for a screen are in its folder

#### Figma Design Integration
- Figma link will be provided for each screen
- Access design using Figma MCP
- **STRICTLY** follow the designs
- Match colors, spacing, typography exactly

## Git Commit Convention

```
<type>(<scope>): <subject>
```

### Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code formatting
- `refactor`: Code refactoring
- `test`: Tests
- `chore`: Maintenance

### Examples:
```
feat(home): implement home screen
feat(profile): add profile page with avatar upload
fix(login): resolve validation error
```


## Build Requirements

### Before Building:
1. Read all provided instructions carefully
2. Review Figma design via MCP
3. Verify assets are in correct folder
4. Understand all component requirements

### During Implementation:
1. Follow Clean Architecture (domain → data → presentation)
2. Use proper state management (BLoC/Provider)
3. Match Figma designs exactly
4. Use assets from designated folder only
5. Handle loading and error states
6. Build all specified components

### After Implementation:
1. build the project
2. run the project
3. will verify if ui is made correctly
4. Wait for user review and approval
5. Make corrections if needed
6. Only commit after GREEN LIGHT from user

## Important Rules

### DO:
✅ Follow instructions exactly  
✅ Use Figma MCP for design reference  
✅ Use assets from designated folder  
✅ Wait for user approval before committing  
✅ Match Figma designs precisely  
✅ Handle errors properly  

### DON'T:
❌ Skip any instructions  
❌ Commit without user's GREEN LIGHT  
❌ Use assets from wrong folders  
❌ Deviate from Figma design  
❌ Push code with errors  
❌ Hardcode values  
❌ Move to next screen without approval  

### CRITICAL COMMIT RULES:
- ❌ **NEVER** commit without user's green light
- ❌ **NEVER** commit if errors exist
- ❌ **NEVER** commit if UI doesn't match
- ✅ **ONLY** commit after user approval
- ✅ **ONLY** commit after all corrections are done

## Useful Commands

```bash
# Run app
flutter run

# Format code
flutter format lib/

# Analyze code
flutter analyze

# Run tests
flutter test

# Clean build
flutter clean && flutter pub get

# Update dependencies
flutter pub upgrade
```


---

**Remember**: 
1. Build ONE screen at a time
2. Follow instructions and Figma design exactly
3. Use correct assets folder
4. Wait for user's GREEN LIGHT
5. Only then commit and move to next screen