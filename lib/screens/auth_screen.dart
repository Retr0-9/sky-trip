import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/user_provider.dart';
import '../services/auth_service.dart';

enum _AuthMode { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  _AuthMode _mode = _AuthMode.signIn;
  bool _obscurePassword  = true;
  bool _obscureConfirm   = true;
  bool _isLoading        = false;
  bool _isStaffMode      = false;

  final _emailCtrl     = TextEditingController();
  final _passwordCtrl  = TextEditingController();
  final _confirmCtrl   = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl  = TextEditingController();
  final _staffIdCtrl   = TextEditingController();

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim  = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _staffIdCtrl.dispose();
    super.dispose();
  }

  void _switchMode(_AuthMode mode) {
    setState(() {
      _mode = mode;
      _isStaffMode = false;
    });
    _animCtrl.reset();
    _animCtrl.forward();
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _submit() async {
    // ── Basic validation ──────────────────────────────────
    final email    = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    if (_isStaffMode) {
      if (email.isEmpty || password.isEmpty) {
        _showError('Enter your email and password.');
        return;
      }
    } else if (_mode == _AuthMode.signIn) {
      if (email.isEmpty || !email.contains('@')) {
        _showError('Enter a valid email address.');
        return;
      }
      if (password.length < 6) {
        _showError('Password must be at least 6 characters.');
        return;
      }
    } else {
      // Sign-up — register not wired yet
      _showError('Registration coming soon. Please sign in.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await AuthService.login(email, password);

      if (!mounted) return;

      // Derive a display name from the email (e.g. "ali@gmail.com" → "Ali")
      final namePart  = result.email.split('@').first;
      final firstName = namePart.isNotEmpty
          ? namePart[0].toUpperCase() + namePart.substring(1)
          : 'User';

      final user = context.read<UserProvider>();
      user.login(
        firstName: firstName,
        lastName:  '',
        email:     result.email,
        token:     result.token,
        userId:    result.userId,
        personId:  result.personId,
        clientId:  result.clientId,
        role:      result.role,
      );

      // Fire-and-forget: fetch full profile in the background
      user.loadProfile();

      Navigator.pushReplacementNamed(context, '/home');
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: _buildCard(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.xl,
        boxShadow: [
          BoxShadow(
            color: AppColors.cyanDark.withOpacity(0.12),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Logo ──────────────────────────────────────
          _buildLogo(),
          const SizedBox(height: 24),

          // ── Title ─────────────────────────────────────
          Text(
            _isStaffMode
                ? 'Staff Login'
                : _mode == _AuthMode.signIn
                    ? 'Welcome Back'
                    : 'Create Account',
            style: AppTextStyles.displayMedium.copyWith(
              fontSize: 24,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _isStaffMode
                ? 'Sign in with your staff credentials'
                : _mode == _AuthMode.signIn
                    ? 'Sign in to continue your journey'
                    : 'Join SkyTrip today',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // ── Form Fields ───────────────────────────────
          if (_mode == _AuthMode.signUp && !_isStaffMode) ...[
            _buildNameRow(),
            const SizedBox(height: 14),
          ],
          _buildEmailField(),
          const SizedBox(height: 14),

          if (_isStaffMode) ...[
            _buildStaffIdField(),
            const SizedBox(height: 14),
          ],

          _buildPasswordField(),
          const SizedBox(height: 14),

          if (_mode == _AuthMode.signUp && !_isStaffMode) ...[
            _buildConfirmPasswordField(),
            const SizedBox(height: 14),
          ],

          // ── Primary button ────────────────────────────
          const SizedBox(height: 6),
          _buildSubmitButton(),

          // ── Divider ───────────────────────────────────
          if (!_isStaffMode) ...[
            const SizedBox(height: 18),
            _buildDivider(),
            const SizedBox(height: 18),
            _buildGoogleButton(),
          ],

          // ── Toggle sign in / sign up ──────────────────
          const SizedBox(height: 20),
          if (!_isStaffMode) _buildToggleRow(),

          // ── Staff login link ──────────────────────────
          if (!_isStaffMode) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
          ],
          _buildStaffLink(),
        ],
      ),
    );
  }

  // ── Logo ─────────────────────────────────────────────────
  Widget _buildLogo() {
    return Container(
      width: 72, height: 72,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.cyan, AppColors.cyanDark],
        ),
        borderRadius: AppRadius.lg,
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withOpacity(0.35),
            blurRadius: 16, offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Icon(Icons.flight, color: Colors.white, size: 36),
    );
  }

  // ── Name row ─────────────────────────────────────────────
  Widget _buildNameRow() {
    return Row(children: [
      Expanded(
        child: _AuthField(
          controller: _firstNameCtrl,
          icon: Icons.person_outline,
          hint: 'First name',
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: _AuthField(
          controller: _lastNameCtrl,
          icon: Icons.person_outline,
          hint: 'Last name',
        ),
      ),
    ]);
  }

  // ── Fields ───────────────────────────────────────────────
  Widget _buildEmailField() {
    return _AuthField(
      controller: _emailCtrl,
      icon: Icons.email_outlined,
      hint: 'you@example.com',
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildStaffIdField() {
    return _AuthField(
      controller: _staffIdCtrl,
      icon: Icons.badge_outlined,
      hint: 'Staff ID',
    );
  }

  Widget _buildPasswordField() {
    return _AuthField(
      controller: _passwordCtrl,
      icon: Icons.lock_outline,
      hint: '••••••••',
      obscureText: _obscurePassword,
      suffix: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.textHint, size: 20,
        ),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return _AuthField(
      controller: _confirmCtrl,
      icon: Icons.lock_outline,
      hint: 'Confirm password',
      obscureText: _obscureConfirm,
      suffix: IconButton(
        icon: Icon(
          _obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.textHint, size: 20,
        ),
        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
      ),
    );
  }

  // ── Submit Button ─────────────────────────────────────────
  Widget _buildSubmitButton() {
    final label = _isStaffMode
        ? 'Login as Staff'
        : _mode == _AuthMode.signIn
            ? 'Sign In'
            : 'Create Account';

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submit,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
          backgroundColor: AppColors.cyan,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20, width: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2.5))
            : Text(label,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }

  // ── Divider ───────────────────────────────────────────────
  Widget _buildDivider() {
    return Row(children: [
      const Expanded(child: Divider(height: 1)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text('or', style: AppTextStyles.bodySmall),
      ),
      const Expanded(child: Divider(height: 1)),
    ]);
  }

  // ── Google Button ─────────────────────────────────────────
  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google Sign-In: Coming in Phase 6'),
            behavior: SnackBarBehavior.floating,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: AppColors.border),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google icon (using a circle 'G' approximation since no asset)
            Container(
              width: 20, height: 20,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Icon(Icons.language, size: 20,
                  color: AppColors.textSecondary),
            ),
            const SizedBox(width: 10),
            const Text('Continue with Google',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 15)),
          ],
        ),
      ),
    );
  }

  // ── Toggle Row ────────────────────────────────────────────
  Widget _buildToggleRow() {
    final question = _mode == _AuthMode.signIn
        ? "Don't have an account?"
        : 'Already have an account?';
    final action = _mode == _AuthMode.signIn ? 'Sign Up' : 'Sign In';
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(question, style: AppTextStyles.bodySmall),
      const SizedBox(width: 4),
      GestureDetector(
        onTap: () => _switchMode(
            _mode == _AuthMode.signIn ? _AuthMode.signUp : _AuthMode.signIn),
        child: Text(action,
            style: const TextStyle(
                color: AppColors.cyan,
                fontWeight: FontWeight.w600,
                fontSize: 12)),
      ),
    ]);
  }

  // ── Staff Link ────────────────────────────────────────────
  Widget _buildStaffLink() {
    if (_isStaffMode) {
      return GestureDetector(
        onTap: () {
          setState(() => _isStaffMode = false);
          _animCtrl.reset();
          _animCtrl.forward();
        },
        child: const Text('← Back to regular login',
            style: TextStyle(
                color: AppColors.cyan,
                fontWeight: FontWeight.w500,
                fontSize: 13)),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() => _isStaffMode = true);
        _animCtrl.reset();
        _animCtrl.forward();
      },
      child: const Text('Login as Staff',
          style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 13)),
    );
  }
}

// ── Shared input field ────────────────────────────────────────────────────────
class _AuthField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const _AuthField({
    required this.controller,
    required this.icon,
    required this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: AppRadius.md,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(icon, color: AppColors.textHint, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(
                  fontSize: 15, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                    color: AppColors.textHint, fontSize: 14),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          if (suffix != null) suffix!,
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
