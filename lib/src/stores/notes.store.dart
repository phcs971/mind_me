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
  Future<bool> deleteNote(NoteModel note) async {
    return notes.remove(note);
  }
}
