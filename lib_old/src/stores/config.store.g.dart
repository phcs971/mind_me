// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigStore on _ConfigStoreBase, Store {
  final _$localeAtom = Atom(name: '_ConfigStoreBase.locale');

  @override
  String get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(String value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  final _$sendNotificationsAtom =
      Atom(name: '_ConfigStoreBase.sendNotifications');

  @override
  bool get sendNotifications {
    _$sendNotificationsAtom.reportRead();
    return super.sendNotifications;
  }

  @override
  set sendNotifications(bool value) {
    _$sendNotificationsAtom.reportWrite(value, super.sendNotifications, () {
      super.sendNotifications = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_ConfigStoreBase.init');

  @override
  Future<dynamic> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$setLocaleAsyncAction = AsyncAction('_ConfigStoreBase.setLocale');

  @override
  Future<void> setLocale(String _locale) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(_locale));
  }

  final _$setSendNotificationsAsyncAction =
      AsyncAction('_ConfigStoreBase.setSendNotifications');

  @override
  Future<void> setSendNotifications(bool value) {
    return _$setSendNotificationsAsyncAction
        .run(() => super.setSendNotifications(value));
  }

  @override
  String toString() {
    return '''
locale: ${locale},
sendNotifications: ${sendNotifications}
    ''';
  }
}
