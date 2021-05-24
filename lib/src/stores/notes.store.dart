import 'package:mind_me/src/widgets/snackbar.widget.dart';
import 'package:mobx/mobx.dart';

import '../utils.dart';
import '../service/service.dart';
import '../models/note.model.dart';

part 'notes.store.g.dart';

class NotesStore = _NotesStoreBase with _$NotesStore;

abstract class _NotesStoreBase with Store {
  NotificationService get notificationService => Get.find<NotificationService>();
  @observable
  bool busy = false;

  @observable
  List<NoteModel> notes = ObservableList();

  @action
  void reoorder(int old, int index) {
    notes.insert(index, notes.removeAt(old));
    for (var i = 0; i < notes.length; i++) notes[i].index = i;
    DatabaseService.instance.updateAll(notes);
  }

  @observable
  bool readError = false;

  bool has(NoteModel note) => notes.any((n) => n.id == note.id);

  @action
  Future<bool> getNotes() async {
    busy = true;
    readError = false;
    notes.clear();
    try {
      log.v("<Notes> Get Notes");
      await Future.delayed(Duration(seconds: 2));
      notes.addAll(await DatabaseService.instance.read());
      log.i("<Notes> Got ${notes.length} Notes");
      notes.sort((a, b) => a.index.compareTo(b.index));
      busy = false;
      return true;
    } catch (e) {
      log.e("<Notes> Get Notes Error $e");
      busy = false;
      readError = true;
      return false;
    }
  }

  @action
  Future<bool> add(NoteModel note) async {
    try {
      log.v("<Notes> Add Note");
      if (note.notify) note.notificationIds = await notificationService.create(note);
      await DatabaseService.instance.create(note);
      notes.add(note);
      log.i("<Notes> Add Note Success");
      return true;
    } catch (e) {
      log.e("<Notes> Add Note Error $e");
      SnackbarWidget.error(MindMeTexts.baseError.tr);
      return false;
    }
  }

  @action
  Future<bool> setAllNotifications() async {
    try {
      log.v("<Notes> Set Notifications");
      for (var note in notes) {
        if (note.notify) {
          note.notificationIds = await notificationService.create(note);
          await DatabaseService.instance.update(note);
        }
      }
      log.i("<Notes> Set Notifications Success");
      return true;
    } catch (e) {
      log.e("<Notes> Set Notifications Error $e");
      SnackbarWidget.error(MindMeTexts.baseError.tr);
      return false;
    }
  }

  @action
  Future<bool> update(NoteModel note) async {
    if (!has(note)) return false;
    try {
      log.v("<Notes> Update Note ${note.id}");
      await DatabaseService.instance.update(note);
      final index = notes.indexWhere((n) => n.id == note.id);
      if (note.title != notes[index].title || !note.compareNotificationDate(notes[index])) {
        if (notes[index].notificationIds != null)
          await notificationService.remove(note.notificationIds!);
        if (note.notify) note.notificationIds = await notificationService.create(note);
      }
      notes.removeAt(index);
      notes.insert(index, note);
      log.i("<Notes> Update Note ${note.id} Success");
      return true;
    } catch (e) {
      log.e("<Notes> Update Note ${note.id} Error $e");
      SnackbarWidget.error(MindMeTexts.baseError.tr);
      return false;
    }
  }

  @action
  Future<bool> delete(NoteModel note) async {
    try {
      log.v("<Notes> Delete Note ${note.id}");
      await DatabaseService.instance.delete(note.id);
      if (note.notificationIds != null) await notificationService.remove(note.notificationIds!);
      notes.remove(note);
      log.i("<Notes> Delete Note ${note.id} Success");
      return true;
    } catch (e) {
      log.e("<Notes> Delete Note ${note.id} Error $e");
      SnackbarWidget.error(MindMeTexts.baseError.tr);
      return false;
    }
  }

  @action
  Future<bool> deleteNotifications() async {
    try {
      log.v("<Notes> Delete Notifications ");
      await notificationService.clear();
      final result = ObservableList<NoteModel>();
      for (var note in notes) {
        if (note.notify) {
          note.resetNotification();
          await DatabaseService.instance.update(note);
        }
        result.add(note);
      }
      notes = result;
      log.i("<Notes> Delete Notifications Success");
      return true;
    } catch (e) {
      log.e("<Notes> Delete Notifications Error $e");
      SnackbarWidget.error(MindMeTexts.baseError.tr);
      return false;
    }
  }

  @action
  Future<bool> deleteAll() async {
    try {
      log.v("<Notes> Delete All ");
      await notificationService.clear();
      await DatabaseService.instance.deleteAll();
      notes.clear();
      log.i("<Notes> Delete All Success");
      return true;
    } catch (e) {
      log.e("<Notes> Delete All Error $e");
      SnackbarWidget.error(MindMeTexts.baseError.tr);
      return false;
    }
  }

  NoteModel? byId(String id) {
    try {
      return notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }
}
