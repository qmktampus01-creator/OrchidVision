import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orchid_vision/app/router/app_routes.dart';
import 'package:orchid_vision/app/theme/app_colors.dart';
import 'package:orchid_vision/core/services/firebase/auth_service.dart';
import 'package:orchid_vision/core/services/firebase/firestore_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _confirmVisible = false;
  String? _errorMessage;
  String? _errorCode;
  String? _debugMessage;

  Future<void> _signup() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill all required fields.';
      });
      return;
    }

    if (password != confirm) {
      setState(() {
        _errorMessage = 'Passwords do not match.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final credential = await GetIt.instance<AuthService>().createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user?.uid;
      if (uid != null) {
        await GetIt.instance<FirestoreService>().setUser(uid, {
          'name': name,
          'email': email,
          'createdAt': DateTime.now().toIso8601String(),
        });
      }
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Failed to create account. Please try again.';
        _errorCode = e.code;
        _debugMessage = e.toString();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred. Please try again.';
        _debugMessage = e.toString();
        _errorCode = null;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
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
                'Create Account',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Start managing your orchid care with AI-assisted guidance.',
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Full name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                      ),
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    TextField(
                      controller: _confirmController,
                      obscureText: !_confirmVisible,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmVisible ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmVisible = !_confirmVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_errorMessage != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      if (_debugMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            _debugMessage!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      if (_errorCode == 'email-already-in-use')
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                                },
                                child: const Text('Sign In'),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.forgotPassword);
                                },
                                child: const Text('Reset password'),
                              ),
                            ],
                          ),
                        ),
                    ],
                    ElevatedButton(
                      onPressed: _isLoading ? null : _signup,
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
                          : const Text('Sign Up'),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: _goToLogin,
                          child: const Text('Sign In'),
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
