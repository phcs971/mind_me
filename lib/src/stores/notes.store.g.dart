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

  final _$getNotesAsyncAction = AsyncAction('_NotesStoreBase.getNotes');

  @override
  Future<bool> getNotes() {
    return _$getNotesAsyncAction.run(() => super.getNotes());
  }

  final _$deleteNoteAsyncAction = AsyncAction('_NotesStoreBase.deleteNote');

  @override
  Future<bool> deleteNote(NoteModel note) {
    return _$deleteNoteAsyncAction.run(() => super.deleteNote(note));
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
notes: ${notes}
    ''';
  }
}
