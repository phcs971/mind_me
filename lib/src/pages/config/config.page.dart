import 'package:flutter/material.dart';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_me/src/stores/notes.store.dart';
import 'package:mind_me/src/widgets/confirm.dialog.dart';
import 'package:mind_me/src/widgets/snackbar.widget.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils.dart';
import '../../stores/config.store.dart';
import '../../widgets/button.widget.dart';
import '../../widgets/list_tile_field.widget.dart';
import '../../widgets/app_bar.widget.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = Get.find<ConfigStore>();
    final store = Get.find<NotesStore>();

    Widget _buildLanguage() {
      final languages = MindMeTexts().keys;
      List<DropdownMenuItem<String>> items = languages.keys.map((k) {
        return DropdownMenuItem<String>(
          child: Container(
            width: 120,
            child: Text(
              languages[k]![MindMeTexts.languageName]!,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          value: k,
        );
      }).toList();
      final dropKey = GlobalKey<FormState>();
      final border = OutlineInputBorder(borderRadius: BorderRadius.circular(4));
      return ListTileField<String>(
        title: MindMeTexts.language.tr,
        onTap: null,
        initialValue: config.locale,
        builder: (state) {
          return Container(
            width: 168,
            height: 32,
            child: DropdownButtonFormField<String>(
              key: dropKey,
              items: items,
              value: state.value,
              onChanged: (value) {
                if (value != null) {
                  state.didChange(value);
                  config.setLocale(value);
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: border,
                errorBorder: border,
                enabledBorder: border,
                focusedBorder: border,
                disabledBorder: border,
                focusedErrorBorder: border,
              ),
            ),
          );
          // return Container(width: 1);
        },
      );
    }

    return Scaffold(
      appBar: AppBarWidget(title: MindMeTexts.settingsPage.tr, returnArrow: true),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            SwitchListTileField(
              title: MindMeTexts.configNotificationActive.tr,
              initialValue: config.sendNotifications,
              onChanged: config.setSendNotifications,
            ),
            _buildLanguage(),
            Theme(
              data: ThemeData(
                primaryColor: Colors.white,
                accentColor: Colors.white,
              ),
              child: ListTileField(
                title: MindMeTexts.aboutTheApp.tr,
                onTap: (_) async {
                  final info = await PackageInfo.fromPlatform();
                  showAboutDialog(
                    context: context,
                    applicationIcon: Image.asset(MindMeImages.icon, height: 64, width: 64),
                    applicationLegalese: "Pedro Henrique Cordeiro Soares\nphcs.971@gmail.com",
                    applicationVersion: info.version,
                    applicationName: MindMeTexts.mindMe.tr,
                  );
                },
                builder: (_) => Icon(CarbonIcons.information, size: 32, color: Colors.black),
              ),
            ),
            ListTileField(
              title: MindMeTexts.speakWithUs.tr,
              onTap: (_) async {
                try {
                  log.i("<Config> Open Email");
                  await launch("mailto:phcs.971@gmail.com?subject=Mind%20Me%20App");
                } catch (e) {
                  log.e("<Config> Open Email Error $e");
                }
              },
              builder: (_) => Icon(CarbonIcons.help, size: 32, color: Colors.black),
            ),
            ListTileField(
              title: MindMeTexts.buyMeACoffee.tr,
              onTap: (_) async {
                try {
                  log.i("<Config> Open BMC");
                  await launch("https://buymeacoffee.com/phcs");
                } catch (e) {
                  log.e("<Config> Open BMC Error $e");
                }
              },
              builder: (_) => SvgPicture.asset("assets/images/burger.svg",
                  height: 32, width: 32, color: Colors.black),
            ),
            ListTileField(
              title: MindMeTexts.privacyPolicy.tr,
              onTap: (_) async {
                try {
                  log.i("<Config> Open Privacy");
                  await launch("https://mind-me.flycricket.io/privacy.html");
                } catch (e) {
                  log.e("<Config> Open Privacy Error $e");
                }
              },
              builder: (_) => Icon(CarbonIcons.security, size: 32, color: Colors.black),
            ),
            ListTileField(
              title: MindMeTexts.termsAndConditions.tr,
              onTap: (_) async {
                try {
                  log.i("<Config> Open Terms");
                  await launch("https://mind-me.flycricket.io/terms.html");
                } catch (e) {
                  log.e("<Config> Open Terms Error $e");
                }
              },
              builder: (_) => Icon(CarbonIcons.document, size: 32, color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: ButtonWidget(
                onPressed: () async {
                  if (await ConfirmDialog(
                    title: MindMeTexts.sureDeleteNotification.tr,
                    subtitle: MindMeTexts.noComingBack.tr,
                  ).show()) {
                    if (await store.deleteNotifications())
                      SnackbarWidget.build(MindMeTexts.success.tr);
                  }
                },
                color: Colors.white,
                borderColor: Colors.red,
                textColor: Colors.red,
                text: MindMeTexts.removeNextNotification.tr,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: ButtonWidget(
                onPressed: () async {
                  if (await ConfirmDialog(
                    title: MindMeTexts.sureDeleteEverything.tr,
                    subtitle: MindMeTexts.noComingBack.tr,
                  ).show()) {
                    if (await store.deleteAll()) SnackbarWidget.build(MindMeTexts.success.tr);
                  }
                },
                color: Colors.red,
                borderColor: Colors.red,
                text: MindMeTexts.removeEverything.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
