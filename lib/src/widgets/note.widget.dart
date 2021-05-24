import 'package:flutter/material.dart';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:get/get.dart';
import 'package:mind_me/src/widgets/confirm.dialog.dart';

import '../service/service.dart';
import '../stores/notes.store.dart';
import '../models/note.model.dart';
import '../utils.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel note;
  const NoteWidget(this.note, {Key? key}) : super(key: key);

  static double get size => (Get.width - 48) / 2;

  static Widget fake() {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(offset: Offset(4, 4), blurRadius: 4, color: Colors.black26)],
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String obscure(String value) {
      String result = "";
      value.split("").forEach((char) {
        if (char == " ")
          result += char;
        else
          result += "*";
      });
      return result;
    }

    return GestureDetector(
      onTap: NoteDialog(note).open,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: note.color,
          boxShadow: [BoxShadow(offset: Offset(4, 4), blurRadius: 4, color: Colors.black26)],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 2),
                    child: Center(
                      child: Text(
                        note.lock ? obscure(note.title) : note.title,
                        style: MindMeStyles.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  height: 16,
                  width: size - 16,
                  child: note.notify
                      ? RichText(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: MindMeStyles.caption.copyWith(height: 7 / 6),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(CarbonIcons.timer, size: 14),
                                ),
                              ),
                              TextSpan(text: note.notificationText),
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              ],
            ),
            if (note.lock)
              Positioned(
                right: 4,
                bottom: 4,
                child: Icon(CarbonIcons.locked, size: 24),
              ),
          ],
        ),
      ),
    );
  }
}

class NoteDialog extends StatelessWidget {
  final NoteModel note;
  const NoteDialog(this.note, {Key? key}) : super(key: key);

  static double get size => Get.width - 48;
  Future<T?> open<T>() async {
    if (await Get.find<AuthService>().auth(note))
      return await showDialog<T>(context: Get.context!, builder: build);
  }

  @override
  Widget build(BuildContext context) {
    final store = Get.find<NotesStore>();
    final nav = Get.find<NavigationService>();
    return AlertDialog(
      backgroundColor: note.color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.all(24),
      content: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: size,
          height: size,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 4),
                      child: Center(
                        child: Text(
                          note.title,
                          style: MindMeStyles.title.copyWith(fontSize: 38),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    height: 32,
                    width: size - 32,
                    child: note.notify
                        ? RichText(
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: MindMeStyles.caption.copyWith(height: 7 / 6, fontSize: 24),
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Icon(CarbonIcons.timer, size: 28),
                                  ),
                                ),
                                TextSpan(text: note.notificationText),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                ],
              ),
              if (note.lock)
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Icon(CarbonIcons.unlocked, size: 48),
                ),
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  icon: Icon(CarbonIcons.edit),
                  iconSize: 48,
                  onPressed: () => nav.pushReplacement(MindMePages.Note, arguments: note),
                ),
              ),
              Positioned(
                left: 8,
                top: 8,
                child: IconButton(
                  icon: Icon(CarbonIcons.delete),
                  iconSize: 48,
                  onPressed: () async {
                    if (await ConfirmDialog(
                      title: MindMeTexts.sureDeleteThis.tr,
                      subtitle: MindMeTexts.noComingBack.tr,
                    ).show()) {
                      await store.delete(note);
                      nav.pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
