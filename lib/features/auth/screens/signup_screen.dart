import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/toast.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../providers/auth_providers.dart';
import 'auth_gate.dart';
import 'login_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dobController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _gender = 'Female';
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = picked.toIso8601String().split('T').first;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_termsAccepted) {
      showToast('Please accept the terms and conditions');
      return;
    }

    final controller = ref.read(authControllerProvider.notifier);
    final success = await controller.signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      dob: _dobController.text.trim(),
      gender: _gender,
    );
    if (!mounted) return;
    if (success) {
      // Pop back to the root so the AuthGate (which has now rebuilt to
      // MainNavigationScreen) is actually visible - both LoginScreen and
      // this pushed SignUpScreen were sitting on top of it.
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      final error = ref.read(authControllerProvider);
      showToast(error.error?.toString() ?? 'Sign up failed. Please try again.');
    }
  }
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const CustomText('Create Account', variant: CustomTextVariant.h2)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomText('Fit Peak', variant: CustomTextVariant.h1, align: TextAlign.center),
                const SizedBox(height: 6),
                const CustomText("Let's build your fitness profile",
                    variant: CustomTextVariant.bodyMuted, align: TextAlign.center),
                const SizedBox(height: 28),
                CustomTextField(
                  hint: 'Full name',
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.isEmpty) ? 'Name can\'t be empty' : null,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hint: 'Email',
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email can\'t be empty';
                    if (!value.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hint: 'Password',
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffix: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textMuted, size: 20),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter a password';
                    if (value.length < 8) return 'At least 8 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hint: 'Confirm password',
                  controller: _confirmPasswordController,
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  suffix: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textMuted, size: 20),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm your password';
                    if (value != _passwordController.text) return 'Passwords don\'t match';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hint: 'Date of birth',
                  controller: _dobController,
                  prefixIcon: Icons.calendar_month_outlined,
                  readOnly: true,
                  onTap: _pickDob,
                  validator: (v) => (v == null || v.isEmpty) ? 'Select your date of birth' : null,
                ),
                const SizedBox(height: 16),
                const CustomText('Gender', variant: CustomTextVariant.label),
                Row(
                  children: [
                    _genderOption('Female'),
                    const SizedBox(width: 16),
                    _genderOption('Male'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _termsAccepted = v ?? false),
                    ),
                    const Expanded(
                      child: CustomText('I accept the terms and conditions',
                          variant: CustomTextVariant.bodyMuted),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomButton(
                  label: 'Sign Up',
                  loading: isLoading,
                  onPressed: isLoading ? null : _submit,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText('Already have an account?', variant: CustomTextVariant.bodyMuted),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
                      child: const CustomText('Log in',
                          variant: CustomTextVariant.body, color: AppColors.primary, weight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _genderOption(String value) {
    final selected = _gender == value;
    return GestureDetector(
      onTap: () => setState(() => _gender = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.15) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.primary : AppColors.divider),
        ),
        child: CustomText(
          value,
          variant: CustomTextVariant.body,
          color: selected ? AppColors.primary : AppColors.textPrimary,
          weight: FontWeight.w600,
        ),
      ),
    );
  }
}
