import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:calculator_frontend/data/account_repository.dart";
import "package:calculator_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'account.freezed.dart';

@freezed
class AccountData with _$AccountData {
  factory AccountData({
    AccountIdLight? accountId,
    ApiKey? apiKey,
  }) = _AccountData;
}

abstract class AccountEvent {}
class DoRegister extends AccountEvent {
  DoRegister();
}
class DoLogin extends AccountEvent {}
class DoLogout extends AccountEvent {}
class NewAccountIdValue extends AccountEvent {
  final AccountIdLight value;
  NewAccountIdValue(this.value);
}
class NewApiKeyValue extends AccountEvent {
  final ApiKey value;
  NewApiKeyValue(this.value);
}

/// Do register/login operations
class AccountBloc extends Bloc<AccountEvent, AccountData> {
  final AccountRepository account;

  AccountBloc(this.account) : super(AccountData()) {
    // TODO: It is possible to start register and login multiple times?
    on<DoRegister>((data, emit) async {
      emit(state.copyWith(
        accountId: await account.register(),
        apiKey: null,
      ));
    });
    on<DoLogin>((_, emit) async {
      emit(state.copyWith(
        apiKey: await account.login(),
      ));
    });
    on<DoLogout>((_, emit) async {
      await account.logout();
    });
    on<NewAccountIdValue>((id, emit) {
      emit(state.copyWith(accountId: id.value));
    });
    on<NewApiKeyValue>((key, emit) {
      emit(state.copyWith(apiKey: key.value));
    });

    account.accountId.whereNotNull().listen((event) {
      add(NewAccountIdValue(event));
    });
    account.accountAccessToken.whereNotNull().listen((event) { add(NewApiKeyValue(event)); });
  }
}
