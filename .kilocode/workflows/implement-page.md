# Flutter Page Implementation Workflow

## Usage
`/implement-page [page-name]`

---

## Phase 1: Asset Analysis & Location
**Objective**: Identify and verify all required assets for the page

1. Check `/assets/[page-name]` folder for available assets
2. List all images, icons, and resources found
3. Confirm asset paths and naming conventions
4. Await user's detailed page description and navigation requirements

---

## Phase 2: Implementation
**Objective**: Build the Flutter page according to specifications

1. Create new page file in appropriate directory
2. Implement UI structure based on provided description
3. Integrate located assets from Phase 1
4. Set up navigation routes as specified
5. Link buttons/actions to target pages
6. Apply styling and responsive design

---

## Phase 3: Error Resolution
**Objective**: Fix any build or runtime errors

1. Run Flutter analyzer
2. Resolve compilation errors
3. Fix asset loading issues
4. Test navigation flows
5. Ensure no warnings or critical issues

---

## Phase 4: Verification & Testing
**Objective**: Deploy and validate implementation

1. Build and deploy app via ADB
2. User performs manual testing
3. User provides feedback:
   - ✅ **Greenlit** → Proceed to Phase 5
   - ❌ **Issues Found** → Return to Phase 2 with fix instructions

---

## Phase 5: Commit & Push
**Objective**: Save changes to version control

1. Stage all modified files
2. Commit with descriptive message: `feat: implement [page-name] page`
3. Push changes to GitHub
4. Confirm successful push

---

## Workflow Complete ✓

**Notes**:
- Loop between Phase 2 and Phase 4 until greenlit
- Always verify asset paths before implementation
- Test navigation thoroughly before user verification