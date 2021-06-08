// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  final _$loginAsyncAction = AsyncAction('_LoginStoreBase.login');

  @override
  Future<dynamic> login(String email, String senha) {
    return _$loginAsyncAction.run(() => super.login(email, senha));
  }

  final _$loginWithGoogleAsyncAction =
      AsyncAction('_LoginStoreBase.loginWithGoogle');

  @override
  Future<UserCredential> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
