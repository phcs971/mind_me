import 'package:mind_me/src/models/note.model.dart';
import 'package:mobx/mobx.dart';

import '../utils.dart';
part 'notes.store.g.dart';

class NotesStore = _NotesStoreBase with _$NotesStore;

abstract class _NotesStoreBase with Store {
  @observable
  bool busy = false;

  @observable
  List<NoteModel> notes = ObservableList();

  @action
  void reoorder(int old, int index) => notes.insert(index, notes.removeAt(old));

  bool has(NoteModel note) => notes.any((n) => n.id == note.id);

  @action
  Future<bool> getNotes() async {
    notes.clear();
    notes.addAll([
      NoteModel()..title = "Vai pra academia",
      NoteModel()
        ..title = "Vai logo"
        ..color = MindMeColors.blue,
      NoteModel()
        ..title = "Exemplo"
        ..color = MindMeColors.purple
        ..lock = true,
      NoteModel()..title = "Continue programando",
      NoteModel()
        ..title = "Notificação"
        ..notify = true
        ..dates[0] = true
        ..dates[6] = true,
    ]);
    return true;
  }

  @action
  Future<bool> add(NoteModel note) async {
    notes.add(note);
    return true;
  }

  @action
  Future<bool> update(NoteModel note) async {
    if (!has(note)) return false;
    final currentNote = notes.firstWhere((n) => n.id == note.id);
    final index = notes.indexOf(currentNote);
    notes.removeAt(index);
    notes.insert(index, note);
    // notes[notes.indexWhere((n) => n.id == note.id)] = note;
    return true;
  }

  @action
  Future<bool> delete(NoteModel note) async {
    return notes.remove(note);
  }
}
