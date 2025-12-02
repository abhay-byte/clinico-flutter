import 'package:flutter/material.dart';
import 'package:clinico/screens/home_screen.dart';
import 'package:clinico/screens/main_app_screen.dart';
import '../constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginTab = true;
  bool rememberMe = false;
  bool showPassword = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header & Branding Section with gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.bg1, AppColors.bg2],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo and Mascot row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // White background of exact logo size
                        ),
                        child: Image.asset(
                          'assets/authentication/logo.png',
                          width: 45,
                          height: 45,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Image.asset(
                        'assets/authentication/elphie.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Title and subtitle
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ge1,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Log in to access your secure health hub.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.ge2,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Main Form Card
            Container(
              margin: const EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tab Toggle (Log In / Sign Up)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.bg1,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          // Log In Tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLoginTab = true;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: isLoginTab
                                      ? AppColors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isLoginTab
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isLoginTab
                                          ? AppColors.b1
                                          : AppColors.ge2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Sign Up Tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLoginTab = false;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: !isLoginTab
                                      ? AppColors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: !isLoginTab
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: !isLoginTab
                                          ? AppColors.b1
                                          : AppColors.ge2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Email/Phone Input
                    const Text(
                      'Email or Phone Number',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ge1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: const TextStyle(
                          color: AppColors.ge2,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: AppColors.ge2,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.ge3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.ge3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.b4),
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Password Input
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ge1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: const TextStyle(
                          color: AppColors.ge2,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.ge3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.ge3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.b4),
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: Icon(
                            showPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.ge2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Remember me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                                activeColor: AppColors.b4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.ge2,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle forgot password
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.b4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Log In Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to MainAppScreen (which includes bottom navigation)
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MainAppScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.b4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Separator with "Or"
                    Row(
                      children: [
                        Expanded(
                          child: Container(height: 1, color: AppColors.ge3),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Or',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.ge2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(height: 1, color: AppColors.ge3),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Login with Google
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle Google login
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.ge3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/authentication/google.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Login with Google',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ge1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Login with Apple
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle Apple login
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.ge3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/authentication/apple.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Login with Apple',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ge1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
