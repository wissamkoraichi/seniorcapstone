import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthTestScreen extends StatefulWidget {
  const AuthTestScreen({super.key});

  @override
  State<AuthTestScreen> createState() => _AuthTestScreenState();
}

class _AuthTestScreenState extends State<AuthTestScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  // ✅ Enforce NCC email domain
  void _enforceNoCtrlDomain(String email) {
    final trimmed = email.trim().toLowerCase();
    if (!trimmed.endsWith('@noctrl.edu')) {
      throw FirebaseAuthException(
        code: 'invalid-domain',
        message: 'Only North Central College emails are allowed (@noctrl.edu).',
      );
    }
  }

  String _friendlyAuthMessage(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-domain':
          return e.message ?? 'Only @noctrl.edu emails are allowed.';
        case 'invalid-email':
          return 'That email address is not valid.';
        case 'user-not-found':
          return 'No account found for that email.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'That email is already registered. Try signing in.';
        case 'weak-password':
          return 'Password is too weak (use at least 6 characters).';
        case 'network-request-failed':
          return 'Network error. Check your connection and try again.';
        default:
          return e.message ?? 'Authentication error: ${e.code}';
      }
    }
    return 'Something went wrong. Please try again.';
  }

  Future<void> _signIn() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final email = _emailCtrl.text;
      final pass = _passCtrl.text;

      _enforceNoCtrlDomain(email);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: pass,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed in successfully ✅')),
      );
    } catch (e) {
      setState(() => _error = _friendlyAuthMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _createAccount() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final email = _emailCtrl.text;
      final pass = _passCtrl.text;

      _enforceNoCtrlDomain(email);

      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: pass,
      );

      // Optional but recommended: email verification
      await cred.user?.sendEmailVerification();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created ✅ Check your email to verify.'),
        ),
      );
    } catch (e) {
      setState(() => _error = _friendlyAuthMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.username, AutofillHints.email],
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'yourname@noctrl.edu',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passCtrl,
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16),

                if (_error != null) ...[
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                ],

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _loading ? null : _signIn,
                        child: _loading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Sign In'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _loading ? null : _createAccount,
                        child: const Text('Create Account'),
                      ),
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
}
