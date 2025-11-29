# Flutter Build & Run Workflow

## Usage
`/build-and-run`

---

## Phase 1: Dependency Management
**Objective**: Ensure all dependencies are up to date

1. Run `flutter pub get` to fetch dependencies
2. Verify pubspec.yaml for any conflicts
3. Confirm successful dependency resolution

---

## Phase 2: Clean Build
**Objective**: Clear previous build artifacts

1. Run `flutter clean` to remove build cache
2. Confirm clean completion
3. Ready for fresh build

---

## Phase 3: Build Application
**Objective**: Compile Flutter app for Android

1. Run `flutter build apk` or `flutter build appbundle`
2. Monitor build process for errors
3. Verify successful build completion
4. Note build output location

---

## Phase 4: ADB Device Check
**Objective**: Verify connected Android device

1. Run `adb devices` to list connected devices
2. Confirm device is authorized and online
3. If no device found:
   - Check USB connection
   - Enable USB debugging on device
   - Retry device check

---

## Phase 5: Deploy & Run
**Objective**: Install and launch app on device

1. Run `flutter install` or `adb install [apk-path]`
2. Launch app via ADB or manually on device
3. Monitor console for runtime logs
4. Confirm app is running successfully

---

## Phase 6: Verification
**Objective**: Ready for user testing

1. App is deployed and running
2. Await user feedback or testing results
3. Monitor for crashes or errors in logs

---

## Workflow Complete ✓

**Quick Commands**:
- `flutter pub get` - Get dependencies
- `flutter clean` - Clean build
- `flutter run` - Build and run directly
- `adb devices` - Check connected devices
- `flutter doctor` - Check Flutter setup