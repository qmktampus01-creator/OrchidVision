import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orchid_vision/app/router/app_routes.dart';
import 'package:orchid_vision/app/theme/app_colors.dart';
import 'package:orchid_vision/core/services/firebase/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;
  String? _errorMessage;
  String? _debugMessage;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your email and password.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

  try {
  print("STEP 1");

  final credential = await GetIt.instance<AuthService>()
      .signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  print("STEP 2");
  print(credential.user?.uid);

  if (!mounted) return;

  print("STEP 3");

  Navigator.pushReplacementNamed(context, AppRoutes.home);

  print("STEP 4");
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'No user found with that email address.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Incorrect password. Please try again.';
        } else if (e.code == 'user-disabled') {
          _errorMessage = 'This user account has been disabled.';
        } else if (e.code == 'invalid-email') {
          _errorMessage = 'Please enter a valid email address.';
        } else if (e.code == 'operation-not-allowed') {
          _errorMessage = 'Email/password sign-in is not enabled for this project.';
        } else {
          _errorMessage = e.message ?? 'Failed to sign in. Please try again.';
        }
        _debugMessage = e.toString();
      });
    } catch (e) {
      setState(() {
        _debugMessage = e.toString();
        _errorMessage = 'An unexpected error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _goToSignup() {
    Navigator.pushReplacementNamed(context, AppRoutes.signup);
  }

  void _goToForgotPassword() {
    Navigator.pushNamed(context, AppRoutes.forgotPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Sign in to continue your orchid care journey.',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_errorMessage != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      if (_debugMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            _debugMessage!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                    ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Sign In'),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _goToForgotPassword,
                          child: const Text('Forgot password?'),
                        ),
                        TextButton(
                          onPressed: _goToSignup,
                          child: const Text('Create account'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
