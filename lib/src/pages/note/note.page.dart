import 'dart:io';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_me/src/service/service.dart';
import 'package:mind_me/src/stores/notes.store.dart';
import 'package:mind_me/src/widgets/confirm.dialog.dart';
import 'package:mind_me/src/widgets/list_tile_field.widget.dart';

import '../../utils.dart';
import '../../models/note.model.dart';
import '../../widgets/app_bar.widget.dart';
import '../../widgets/button.widget.dart';

class NotePage extends StatefulWidget {
  NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final nav = Get.find<NavigationService>();
  final store = Get.find<NotesStore>();
  final formKey = GlobalKey<FormState>();
  final auth = Get.find<AuthService>();

  late NoteModel note;
  bool isFirstBuild = true;
  bool hasText = false;

  void onFirstBuild(NoteModel? args) {
    note = args ?? NoteModel();
    if (!auth.enabled) note.localAuth = false;
    hasText = !isNull(note.title);
    isFirstBuild = false;
  }

  save() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (!auth.enabled) note.localAuth = false;
      if (note.lock) {
        note.resetNotification();
        if (note.localAuth) note.resetPassCode();
      } else {
        note.resetLock();
        if (note.randomNotification) note.randomizeNotification();
      }
      if (store.has(note))
        store.update(note);
      else
        store.add(note);
      nav.forcePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstBuild) onFirstBuild(ModalRoute.of(context)!.settings.arguments as NoteModel?);
    Widget _buildNote() {
      final width = (Get.size.width - 48) / 2;
      return Center(
        child: AnimatedContainer(
          duration: kThemeChangeDuration,
          width: width,
          margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
          decoration: BoxDecoration(
            color: note.color,
            boxShadow: [BoxShadow(offset: Offset(4, 4), blurRadius: 4, color: Colors.black26)],
          ),
          padding: EdgeInsets.all(16).copyWith(bottom: 8),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            style: MindMeStyles.title,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 1,
            initialValue: note.title,
            inputFormatters: [MaxLinesInputFormatter(width > 160 ? 5 : 4)],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              note.title = value;
              final r = !isNull(value);
              if (r != hasText)
                WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() => hasText = r));
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 8),
              hintText: MindMeTexts.writeHereNoteHint.tr,
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
      );
    }

    Future<Color> _selectColorDialog() async {
      final colors = [
        MindMeColors.yellow,
        MindMeColors.green,
        MindMeColors.blue,
        MindMeColors.red,
        MindMeColors.orange,
        MindMeColors.purple,
      ];
      return await showDialog<Color>(
            context: Get.context!,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              insetPadding: EdgeInsets.all(24),
              titlePadding: EdgeInsets.fromLTRB(24, 16, 24, 0),
              contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 16),
              title: Text(MindMeTexts.pickAColor.tr, style: MindMeStyles.title),
              content: Container(
                width: Get.size.width - 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(colors.length, (index) {
                    final color = colors[index];
                    return GestureDetector(
                      onTap: () => nav.pop(color),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: color,
                        child: note.color == color
                            ? Icon(CarbonIcons.checkmark, color: Colors.black)
                            : null,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ) ??
          note.color;
    }

    Widget _buildColor() {
      return ListTileField<Color>(
        title: MindMeTexts.noteColor.tr,
        initialValue: note.color,
        validator: (value) {
          if (value == null) return MindMeTexts.requiredValue.tr;
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: (value) => value != null ? note.color = value : null,
        builder: (state) => CircleAvatar(radius: 16, backgroundColor: state.value),
        onTap: (state) async {
          final result = await _selectColorDialog();
          state.didChange(result);
          setState(() => note.color = result);
        },
      );
    }

    Widget _buildCode() {
      final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(),
      );
      return ListTileField<String>(
        title: MindMeTexts.fourDigitCode.tr,
        initialValue: note.passCode,
        onSaved: (value) => note.passCode = value?.replaceAll("-", ""),
        validator: (value) {
          if (isNull(value) || value!.replaceAll("-", "").length != 4)
            return MindMeTexts.authIncompleteCode.tr;
          return null;
        },
        builder: (FormFieldState<dynamic> state) {
          final controller = MaskedTextController(mask: "0-0-0-0", text: state.value);
          return Container(
            width: 100,
            height: 32,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (v) {
                if (v.replaceAll("-", "").length > 4) return;
                state.didChange(v);
              },
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
          );
        },
      );
    }

    Future<TimeOfDay> _selectTime(TimeOfDay currentTime) async {
      var time = currentTime;
      final picker = showPicker(
        value: time,
        onChange: (v) => time = v,
        is24HrFormat: ['pt'].contains(Get.locale?.languageCode),
        cancelText: MindMeTexts.cancel.tr,
        okText: MindMeTexts.ok.tr,
        borderRadius: 32,
        iosStylePicker: Platform.isIOS,
        minuteInterval: MinuteInterval.ONE,
        hourLabel: MindMeTexts.hours.tr,
        minuteLabel: MindMeTexts.minutes.tr,
      );
      await nav.navigatorKey.currentState!.push(picker);
      return time;
    }

    Widget _buildNotificationDate() {
      return Column(
        children: [
          ListTileField<TimeOfDay>(
            title: MindMeTexts.notifyAt.tr,
            initialValue: note.time,
            onTap: (state) async => state.didChange(await _selectTime(state.value!)),
            onSaved: (value) => note.time = value ?? note.time,
            builder: (state) {
              return Container(
                height: 32,
                width: 128,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  state.value!.format(Get.context!),
                  style: MindMeStyles.body1.copyWith(height: 1),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                7,
                (index) => Column(
                  children: [
                    Text(datesString[index].tr, style: MindMeStyles.body1),
                    Checkbox(
                      value: note.dates[index],
                      activeColor: MindMeColors.successGreen,
                      onChanged: (value) => setState(() => note.dates[index] = value ?? false),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return await ConfirmDialog(
          title: MindMeTexts.sureLeavePage.tr,
          subtitle: MindMeTexts.loseChanges.tr,
        ).show();
      },
      child: Scaffold(
        appBar: AppBarWidget(title: MindMeTexts.notePage.tr, returnArrow: true),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                _buildNote(),
                _buildColor(),
                SwitchListTileField(
                  key: ValueKey("1"),
                  title: MindMeTexts.lockByPass.tr,
                  initialValue: note.lock,
                  onChanged: (value) => setState(() => note.lock = value),
                ),
                if (note.lock) ...[
                  if (auth.enabled)
                    SwitchListTileField(
                      key: ValueKey("2"),
                      title: MindMeTexts.localAuth.tr,
                      initialValue: note.localAuth,
                      onChanged: (value) => setState(() => note.localAuth = value),
                    ),
                  if (!note.localAuth) _buildCode(),
                ] else ...[
                  SwitchListTileField(
                    key: ValueKey("3"),
                    title: MindMeTexts.sendNotification.tr,
                    initialValue: note.notify,
                    onChanged: (value) => setState(() => note.notify = value),
                  ),
                  if (note.notify) ...[
                    SwitchListTileField(
                      key: ValueKey("4"),
                      title: MindMeTexts.randomNotification.tr,
                      initialValue: note.randomNotification,
                      onChanged: (value) => setState(() => note.randomNotification = value),
                    ),
                    if (!note.randomNotification) _buildNotificationDate(),
                  ]
                ]
              ],
            ),
          ),
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
          height: 72 + Get.mediaQuery.padding.bottom + MediaQuery.of(context).viewInsets.bottom,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(24, 12, 24,
              12 + Get.mediaQuery.padding.bottom + MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 2, offset: Offset(0, -1), color: Colors.black26)],
          ),
          child: ButtonWidget(
            text: "SALVAR",
            onPressed: save,
            active: hasText,
            deactiveColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class MaxLinesInputFormatter extends TextInputFormatter {
  final int maxLines;
  MaxLinesInputFormatter(this.maxLines);
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final tp = TextPainter(
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: newValue.text,
        style: MindMeStyles.title,
      ),
    )..layout(maxWidth: (Get.size.width - 48) / 2 - 32 - 8);
    return tp.didExceedMaxLines ? oldValue : newValue;
  }
}
