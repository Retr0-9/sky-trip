import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import '../services/country_service.dart';
import '../models/country_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl  = TextEditingController();
  final _emailCtrl     = TextEditingController();
  final _passwordCtrl  = TextEditingController();
  final _confirmCtrl   = TextEditingController();
  final _phoneCtrl     = TextEditingController();

  bool _obscurePwd = true;
  bool _obscureCfm = true;
  bool _isLoading  = false;

  String _gender  = 'Male';
  String _docType = 'Passport';

  DateTime? _birthDate;
  DateTime? _expiryDate;
  CountryModel? _nationality;
  CountryModel? _issueCountry;

  List<CountryModel> _countries = [];
  bool _loadingCountries = false;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadCountries() async {
    setState(() => _loadingCountries = true);
    final list = await CountryService.getAllPublic();
    if (mounted) setState(() { _countries = list; _loadingCountries = false; });
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: AppColors.error,
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<void> _pickDate(bool isBirth) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isBirth
          ? DateTime(now.year - 25, now.month, now.day)
          : DateTime(now.year + 5, now.month, now.day),
      firstDate: isBirth ? DateTime(1920) : now,
      lastDate: isBirth ? DateTime(now.year - 10) : DateTime(now.year + 50),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(ctx).colorScheme.copyWith(primary: AppColors.cyan),
        ),
        child: child!,
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isBirth) { _birthDate = picked; } else { _expiryDate = picked; }
      });
    }
  }

  Future<void> _pickCountry(bool isNationality) async {
    if (_countries.isEmpty) {
      _showError('Countries are still loading. Please wait.');
      return;
    }
    final result = await showModalBottomSheet<CountryModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CountryPickerSheet(countries: _countries),
    );
    if (result != null && mounted) {
      setState(() {
        if (isNationality) { _nationality = result; } else { _issueCountry = result; }
      });
    }
  }

  Future<void> _submit() async {
    final firstName = _firstNameCtrl.text.trim();
    final lastName  = _lastNameCtrl.text.trim();
    final email     = _emailCtrl.text.trim();
    final password  = _passwordCtrl.text;
    final phone     = _phoneCtrl.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) { _showError('Enter your first and last name.'); return; }
    if (email.isEmpty || !email.contains('@')) { _showError('Enter a valid email address.'); return; }
    if (password.length < 6) { _showError('Password must be at least 6 characters.'); return; }
    if (password != _confirmCtrl.text) { _showError('Passwords do not match.'); return; }
    if (phone.isEmpty) { _showError('Enter your phone number.'); return; }
    if (_birthDate == null) { _showError('Select your date of birth.'); return; }
    if (_nationality == null) { _showError('Select your nationality.'); return; }
    if (_issueCountry == null) { _showError('Select the document issuing country.'); return; }
    if (_expiryDate == null) { _showError('Select your document expiration date.'); return; }

    setState(() => _isLoading = true);
    try {
      await AuthService.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        gender: _gender,
        countryId: _nationality!.countryId,
        birthDate: _birthDate!,
        documentationType: _docType,
        issueCountryId: _issueCountry!.countryId,
        expirationDate: _expiryDate!,
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(
          context, '/verify-email', arguments: email);
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ─────────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Create Account',
              style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Account Info ──────────────────────────
              _sectionLabel('Account Info'),
              Row(children: [
                Expanded(child: _textField(_firstNameCtrl, 'First Name', Icons.person_outline)),
                const SizedBox(width: 12),
                Expanded(child: _textField(_lastNameCtrl, 'Last Name', Icons.person_outline)),
              ]),
              const SizedBox(height: 12),
              _textField(_emailCtrl, 'Email', Icons.email_outlined,
                  keyboard: TextInputType.emailAddress),
              const SizedBox(height: 12),
              _passwordBox(_passwordCtrl, 'Password', _obscurePwd,
                  () => setState(() => _obscurePwd = !_obscurePwd)),
              const SizedBox(height: 12),
              _passwordBox(_confirmCtrl, 'Confirm Password', _obscureCfm,
                  () => setState(() => _obscureCfm = !_obscureCfm)),

              const SizedBox(height: 24),

              // ── Personal Info ─────────────────────────
              _sectionLabel('Personal Info'),
              _textField(_phoneCtrl, 'Phone Number', Icons.phone_outlined,
                  keyboard: TextInputType.phone),
              const SizedBox(height: 12),
              _choiceRow(
                options: const ['Male', 'Female'],
                selected: _gender,
                icons: const [Icons.male, Icons.female],
                onSelect: (v) => setState(() => _gender = v),
              ),
              const SizedBox(height: 12),
              _dateTile('Date of Birth', _birthDate, () => _pickDate(true)),
              const SizedBox(height: 12),
              _countryTile('Nationality', _nationality, () => _pickCountry(true)),

              const SizedBox(height: 24),

              // ── Travel Document ───────────────────────
              _sectionLabel('Travel Document'),
              _choiceRow(
                options: const ['Passport', 'NationalID'],
                labels: const ['Passport', 'National ID'],
                selected: _docType,
                icons: const [Icons.book_outlined, Icons.credit_card_outlined],
                onSelect: (v) => setState(() => _docType = v),
              ),
              const SizedBox(height: 12),
              _countryTile('Issuing Country', _issueCountry, () => _pickCountry(false)),
              const SizedBox(height: 12),
              _dateTile('Expiration Date', _expiryDate, () => _pickDate(false)),

              const SizedBox(height: 32),

              // ── Submit ────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(height: 20, width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : const Text('Create Account',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),

              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text('Already have an account? Sign In',
                      style: TextStyle(
                          color: AppColors.cyan, fontSize: 13, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  HELPER WIDGETS
  // ─────────────────────────────────────────────

  Widget _sectionLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(label,
            style: AppTextStyles.titleSmall
                .copyWith(color: AppColors.cyan, letterSpacing: 0.5)),
      );

  Widget _inputBox({required Widget child}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,
        borderRadius: AppRadius.md,
        border: Border.all(color: theme.dividerColor),
      ),
      child: child,
    );
  }

  Widget _textField(TextEditingController ctrl, String hint, IconData icon,
      {TextInputType? keyboard}) {
    final theme = Theme.of(context);
    return _inputBox(
      child: Row(children: [
        const SizedBox(width: 14),
        Icon(icon, color: theme.colorScheme.onSurface.withValues(alpha: 0.5), size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: ctrl,
            keyboardType: keyboard,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(width: 4),
      ]),
    );
  }

  Widget _passwordBox(TextEditingController ctrl, String hint, bool obscure,
      VoidCallback toggle) {
    final theme = Theme.of(context);
    return _inputBox(
      child: Row(children: [
        const SizedBox(width: 14),
        Icon(Icons.lock_outline, color: theme.colorScheme.onSurface.withValues(alpha: 0.5), size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: ctrl,
            obscureText: obscure,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        IconButton(
          icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              size: 20, color: AppColors.textHint),
          onPressed: toggle,
        ),
      ]),
    );
  }

  Widget _choiceRow({
    required List<String> options,
    List<String>? labels,
    required String selected,
    required List<IconData> icons,
    required ValueChanged<String> onSelect,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: List.generate(options.length, (i) {
        final val = options[i];
        final lbl = labels != null ? labels[i] : val;
        final isSelected = selected == val;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(val),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: EdgeInsets.only(right: i < options.length - 1 ? 10 : 0),
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.cyan : theme.colorScheme.surface,
                borderRadius: AppRadius.md,
                border: Border.all(
                    color: isSelected ? AppColors.cyan : theme.dividerColor),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(icons[i],
                    size: 17,
                    color: isSelected ? Colors.white : theme.hintColor),
                const SizedBox(width: 6),
                Text(lbl,
                    style: TextStyle(
                      color: isSelected ? Colors.white : theme.hintColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    )),
              ]),
            ),
          ),
        );
      }),
    );
  }

  Widget _dateTile(String label, DateTime? date, VoidCallback onTap) {
    final theme = Theme.of(context);
    final hasValue = date != null;
    final display = hasValue
        ? '${date.day.toString().padLeft(2, '0')} / ${date.month.toString().padLeft(2, '0')} / ${date.year}'
        : label;
    return GestureDetector(
      onTap: onTap,
      child: _inputBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(children: [
            Icon(Icons.calendar_today_outlined,
                color: hasValue ? AppColors.cyan : theme.hintColor, size: 20),
            const SizedBox(width: 10),
            Text(display,
                style: TextStyle(
                  color: hasValue
                      ? theme.textTheme.bodyMedium?.color
                      : theme.hintColor,
                  fontSize: 14,
                )),
            const Spacer(),
            Icon(Icons.chevron_right, color: theme.hintColor, size: 20),
          ]),
        ),
      ),
    );
  }

  Widget _countryTile(String label, CountryModel? country, VoidCallback onTap) {
    final theme = Theme.of(context);
    final hasValue = country != null;
    return GestureDetector(
      onTap: _loadingCountries ? null : onTap,
      child: _inputBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(children: [
            Icon(Icons.flag_outlined,
                color: hasValue ? AppColors.cyan : theme.hintColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _loadingCountries ? 'Loading countries…' : country?.countryName ?? label,
                style: TextStyle(
                  color: hasValue ? theme.textTheme.bodyMedium?.color : theme.hintColor,
                  fontSize: 14,
                ),
              ),
            ),
            if (_loadingCountries)
              const SizedBox(width: 16, height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.cyan))
            else
              Icon(Icons.chevron_right, color: theme.hintColor, size: 20),
          ]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Country picker bottom sheet
// ─────────────────────────────────────────────

class _CountryPickerSheet extends StatefulWidget {
  final List<CountryModel> countries;
  const _CountryPickerSheet({required this.countries});

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final _searchCtrl = TextEditingController();
  late List<CountryModel> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = widget.countries;
    _searchCtrl.addListener(_onSearch);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? widget.countries
          : widget.countries
              .where((c) => c.countryName.toLowerCase().contains(q))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (ctx, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(children: [
          const SizedBox(height: 12),
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: AppRadius.full,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchCtrl,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search country…',
                prefixIcon: const Icon(Icons.search, size: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: AppRadius.md,
                  borderSide: BorderSide(color: theme.dividerColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.md,
                  borderSide: const BorderSide(color: AppColors.cyan),
                ),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: scrollCtrl,
              itemCount: _filtered.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(_filtered[i].countryName,
                    style: theme.textTheme.bodyMedium),
                onTap: () => Navigator.pop(context, _filtered[i]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
