import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider((ref) => AuthService());

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState?>(
  (ref) => AuthStateNotifier(ref.watch(authServiceProvider)),
);

class AuthState {
  final AuthModel user;
  final String? token;
  final bool isLoading;
  final String? error;

  AuthState({
    required this.user,
    this.token,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    AuthModel? user,
    String? token,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState?> {
  final AuthService _authService;

  AuthStateNotifier(this._authService) : super(null);

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    state = null;
    try {
      final user = await _authService.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
      _authService.token = user.token;
      state = AuthState(user: user, token: user.token);
    } catch (e) {
      state = null;
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = null;
    try {
      final user = await _authService.login(
        email: email,
        password: password,
      );
      _authService.token = user.token;
      state = AuthState(user: user, token: user.token);
    } catch (e) {
      state = null;
      rethrow;
    }
  }

  void logout() {
    _authService.token = null;
    state = null;
  }
}
