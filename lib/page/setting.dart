import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basess/app_settings.dart';
import 'package:flutter_basess/page/edit_profile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late bool _darkMode;
  bool _pushNotifications = false;
  ProfileData _profile = const ProfileData(
    name: 'Mona Student',
    email: 'mona@student.com',
  );

  @override
  void initState() {
    super.initState();
    _darkMode = AppSettings.darkMode.value;
    AppSettings.darkMode.addListener(_syncDarkMode);
  }

  @override
  void dispose() {
    AppSettings.darkMode.removeListener(_syncDarkMode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _SettingColors.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: colors.topBar,
        statusBarIconBrightness: _darkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: _darkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: colors.page,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colors.topBar,
          elevation: 0,
          toolbarHeight: 82,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: IconButton(
              tooltip: 'Back to menu',
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: colors.title,
                size: 20,
              ),
              onPressed: _backToMenu,
            ),
          ),
          titleSpacing: 4,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Settings',
              style: TextStyle(
                color: colors.title,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
          children: [
            _ProfileSummary(profile: _profile),
            const SizedBox(height: 18),
            _SettingsGroup(
              title: 'General Settings',
              children: [
                _SwitchSettingRow(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Use a darker interface across the app',
                  value: _darkMode,
                  onChanged: _setDarkMode,
                ),
                Divider(height: 1, color: colors.divider),
                _SwitchSettingRow(
                  icon: Icons.notifications_none_rounded,
                  title: 'Push Notifications',
                  subtitle: 'Receive alerts and reminders',
                  value: _pushNotifications,
                  onChanged: (value) =>
                      setState(() => _pushNotifications = value),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _SettingsGroup(
              title: 'Account Actions',
              children: [
                _ActionSettingRow(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profile',
                  subtitle: 'Update your name and email',
                  onTap: _openEditProfile,
                ),
                Divider(height: 1, color: colors.divider),
                const _ActionSettingRow(
                  icon: Icons.lock_outline_rounded,
                  title: 'Security & Password',
                  subtitle: 'Manage sign-in protection',
                ),
                Divider(height: 1, color: colors.divider),
                const _ActionSettingRow(
                  icon: Icons.shield_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'Review app privacy details',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _syncDarkMode() {
    if (!mounted) {
      return;
    }

    setState(() {
      _darkMode = AppSettings.darkMode.value;
    });
  }

  void _setDarkMode(bool value) {
    AppSettings.setDarkMode(value);
  }

  void _backToMenu() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> _openEditProfile() async {
    final updatedProfile = await Navigator.push<ProfileData>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(profile: _profile),
      ),
    );

    if (updatedProfile == null || !mounted) {
      return;
    }

    setState(() {
      _profile = updatedProfile;
    });
  }
}

class _SettingColors {
  const _SettingColors({
    required this.topBar,
    required this.page,
    required this.text,
    required this.muted,
    required this.title,
    required this.card,
    required this.iconBackground,
    required this.divider,
    required this.switchOnTrack,
    required this.switchOffTrack,
    required this.switchOffBorder,
    required this.switchOffThumb,
    required this.chevron,
  });

  final Color topBar;
  final Color page;
  final Color text;
  final Color muted;
  final Color title;
  final Color card;
  final Color iconBackground;
  final Color divider;
  final Color switchOnTrack;
  final Color switchOffTrack;
  final Color switchOffBorder;
  final Color switchOffThumb;
  final Color chevron;

  static const _SettingColors light = _SettingColors(
    topBar: Color(0xFF6F8D99),
    page: Color(0xFFFFF7FF),
    text: Color(0xFF5F5865),
    muted: Color(0xFF77909B),
    title: Color(0xFF26333B),
    card: Color(0xFFFFFFFF),
    iconBackground: Color(0xFFE7F0F3),
    divider: Color(0xFFE7E1E8),
    switchOnTrack: Color(0xFFBCD0D8),
    switchOffTrack: Color(0xFFEAE8ED),
    switchOffBorder: Color(0xFF8D8891),
    switchOffThumb: Color(0xFF7A7580),
    chevron: Color(0xFF8B8490),
  );

  static const _SettingColors dark = _SettingColors(
    topBar: Color(0xFF26333B),
    page: Color(0xFF12151A),
    text: Color(0xFFE9E5EC),
    muted: Color(0xFF9FB4BF),
    title: Color(0xFFF4F8FA),
    card: Color(0xFF1A1F25),
    iconBackground: Color(0xFF26333B),
    divider: Color(0xFF2A3038),
    switchOnTrack: Color(0xFF6F8D99),
    switchOffTrack: Color(0xFF2A3038),
    switchOffBorder: Color(0xFF78737D),
    switchOffThumb: Color(0xFF9A96A0),
    chevron: Color(0xFFB7B1BE),
  );

  static _SettingColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({required this.profile});

  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
    final colors = _SettingColors.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: colors.topBar,
            child: Text(
              profile.initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Summary',
                  style: TextStyle(
                    color: colors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  profile.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.verified_user_outlined, color: colors.muted, size: 22),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = _SettingColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              color: colors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.divider),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SwitchSettingRow extends StatelessWidget {
  const _SwitchSettingRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = _SettingColors.of(context);

    return InkWell(
      onTap: () => onChanged(!value),
      child: SizedBox(
        height: 76,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              _SettingIcon(icon: icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _CustomSwitch(value: value),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionSettingRow extends StatelessWidget {
  const _ActionSettingRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = _SettingColors.of(context);

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 76,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              _SettingIcon(icon: icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colors.chevron,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingIcon extends StatelessWidget {
  const _SettingIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = _SettingColors.of(context);

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: colors.iconBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: colors.muted, size: 20),
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  const _CustomSwitch({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    final colors = _SettingColors.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      width: 50,
      height: 30,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: value ? colors.switchOnTrack : colors.switchOffTrack,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value ? colors.switchOnTrack : colors.switchOffBorder,
          width: value ? 0 : 1.8,
        ),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: value ? colors.topBar : colors.switchOffThumb,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
