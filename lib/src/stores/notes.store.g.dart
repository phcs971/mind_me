// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotesStore on _NotesStoreBase, Store {
  final _$busyAtom = Atom(name: '_NotesStoreBase.busy');

  @override
  bool get busy {
    _$busyAtom.reportRead();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.reportWrite(value, super.busy, () {
      super.busy = value;
    });
  }

  final _$notesAtom = Atom(name: '_NotesStoreBase.notes');

  @override
  List<NoteModel> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(List<NoteModel> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  final _$readErrorAtom = Atom(name: '_NotesStoreBase.readError');

  @override
  bool get readError {
    _$readErrorAtom.reportRead();
    return super.readError;
  }

  @override
  set readError(bool value) {
    _$readErrorAtom.reportWrite(value, super.readError, () {
      super.readError = value;
    });
  }

  final _$getNotesAsyncAction = AsyncAction('_NotesStoreBase.getNotes');

  @override
  Future<bool> getNotes() {
    return _$getNotesAsyncAction.run(() => super.getNotes());
  }

  final _$addAsyncAction = AsyncAction('_NotesStoreBase.add');

  @override
  Future<bool> add(NoteModel note) {
    return _$addAsyncAction.run(() => super.add(note));
  }

  final _$setAllNotificationsAsyncAction =
      AsyncAction('_NotesStoreBase.setAllNotifications');

  @override
  Future<bool> setAllNotifications() {
    return _$setAllNotificationsAsyncAction
        .run(() => super.setAllNotifications());
  }

  final _$updateAsyncAction = AsyncAction('_NotesStoreBase.update');

  @override
  Future<bool> update(NoteModel note) {
    return _$updateAsyncAction.run(() => super.update(note));
  }

  final _$deleteAsyncAction = AsyncAction('_NotesStoreBase.delete');

  @override
  Future<bool> delete(NoteModel note) {
    return _$deleteAsyncAction.run(() => super.delete(note));
  }

  final _$deleteNotificationsAsyncAction =
      AsyncAction('_NotesStoreBase.deleteNotifications');

  @override
  Future<bool> deleteNotifications() {
    return _$deleteNotificationsAsyncAction
        .run(() => super.deleteNotifications());
  }

  final _$deleteAllAsyncAction = AsyncAction('_NotesStoreBase.deleteAll');

  @override
  Future<bool> deleteAll() {
    return _$deleteAllAsyncAction.run(() => super.deleteAll());
  }

  final _$_NotesStoreBaseActionController =
      ActionController(name: '_NotesStoreBase');

  @override
  void reoorder(int old, int index) {
    final _$actionInfo = _$_NotesStoreBaseActionController.startAction(
        name: '_NotesStoreBase.reoorder');
    try {
      return super.reoorder(old, index);
    } finally {
      _$_NotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
busy: ${busy},
notes: ${notes},
readError: ${readError}
    ''';
  }
}
