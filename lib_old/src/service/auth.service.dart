import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mind_me/src/models/note.model.dart';
import 'package:mind_me/src/stores/notes.store.dart';
import 'package:mind_me/src/widgets/snackbar.widget.dart';

import '../utils.dart';
import 'navigation.service.dart';

class AuthService {
  bool enabled = false;
  bool started = false;

  final localAuth = LocalAuthentication();

  Future init() async {
    if (started) return;
    enabled = await localAuth.isDeviceSupported();
    started = true;
  }

  Future<bool> auth(NoteModel note) async {
    log.i("<Auth> Is Supported: ${await localAuth.isDeviceSupported()}");
    log.i("<Auth> Can Check Bio: ${await localAuth.canCheckBiometrics}");
    log.i("<Auth> Available Bio: ${await localAuth.getAvailableBiometrics()}");
    if (!note.lock) return true;
    if (!started) await init();
    try {
      if (note.localAuth) {
        if (!enabled) {
          note.resetLock();
          Get.find<NotesStore>().update(note);
          return true;
        }
        return await localAuth.authenticate(localizedReason: MindMeTexts.authReason.tr);
      } else {
        return await showDialog<bool>(
              context: Get.context!,
              builder: (context) {
                final nav = Get.find<NavigationService>();
                final border = OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(),
                );
                final controller = MaskedTextController(mask: "0-0-0-0");
                String? text;
                return AlertDialog(
                  title: Text(MindMeTexts.authWriteYourCode.tr, style: MindMeStyles.subtitle1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  titlePadding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                  contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                  actionsPadding: EdgeInsets.fromLTRB(24, 0, 16, 0),
                  content: TextFormField(
                    controller: controller,
                    validator: (v) {
                      if (v?.replaceAll("-", "") != note.passCode)
                        return MindMeTexts.authIncorrectCode.tr;
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    onChanged: (v) => text = v.replaceAll("-", ""),
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: border,
                      hintText: "0-0-0-0",
                      contentPadding: EdgeInsets.zero,
                      errorBorder: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      disabledBorder: border,
                      focusedErrorBorder: border,
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        MindMeTexts.cancel.tr.toUpperCase(),
                        style: MindMeStyles.button1
                            .copyWith(fontWeight: FontWeight.w400, color: Colors.red),
                      ),
                      onPressed: () => nav.pop(false),
                    ),
                    TextButton(
                      child: Text(
                        MindMeTexts.ok.tr.toUpperCase(),
                        style: MindMeStyles.button1
                            .copyWith(fontWeight: FontWeight.w400, color: Colors.blue),
                      ),
                      onPressed: () {
                        if (text == note.passCode) nav.pop(true);
                      },
                    ),
                  ],
                );
              },
            ) ??
            false;
      }
    } catch (e) {
      SnackbarWidget.error(MindMeTexts.authUnabled.tr);
      return false;
    }
  }
}
