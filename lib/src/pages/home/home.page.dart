import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mind_me/src/service/service.dart';
import 'package:mind_me/src/stores/notes.store.dart';
import 'package:mind_me/src/widgets/note.widget.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/app_bar.widget.dart';
import '../../utils.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final nav = Get.find<NavigationService>();
  final store = Get.find<NotesStore>();
  @override
  Widget build(BuildContext context) {
    _buildOnDrag(Widget child) => Material(
          child: Container(
            child: child,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(8, 8),
                  blurRadius: 8,
                  spreadRadius: 4,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        );

    return Scaffold(
      appBar: AppBarWidget(
        title: MindMeTexts.mindMe.tr,
        leading: IconButton(
          icon: Icon(CarbonIcons.settings),
          color: Colors.black,
          onPressed: () => nav.push(MindMePages.Config),
        ),
        actions: [
          IconButton(
            icon: Icon(CarbonIcons.add),
            color: Colors.black,
            onPressed: () => nav.push(MindMePages.Note),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (store.busy)
            return Shimmer.fromColors(
              baseColor: MindMeColors.yellow,
              highlightColor: Color(0XFFECE7CB),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(5, (_) => NoteWidget.fake()),
                ),
              ),
            );
          if (store.notes.isNotEmpty)
            return ReorderableWrap(
              onReorder: store.reoorder,
              padding: EdgeInsets.all(16),
              spacing: 16,
              runSpacing: 16,
              buildDraggableFeedback: (_, __, child) => _buildOnDrag(child),
              children:
                  List.generate(store.notes.length, (index) => NoteWidget(store.notes[index])),
            );
          return Container(
            padding: EdgeInsets.all(24),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  store.readError ? MindMeTexts.oops.tr : MindMeTexts.hello.tr,
                  style: MindMeStyles.header,
                  textAlign: TextAlign.center,
                ),
                Text(
                  store.readError ? MindMeTexts.somethingWentWrong.tr : MindMeTexts.noNotes.tr,
                  style: MindMeStyles.title.copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                if (store.readError)
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(MindMeColors.darkYellow),
                    ),
                    onPressed: store.getNotes,
                    child: Text(
                      MindMeTexts.clickTryAgain.tr,
                      style: MindMeStyles.button1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                else
                  Text(
                    MindMeTexts.clickToAdd.tr,
                    style: MindMeStyles.body1.copyWith(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: 108),
              ],
            ),
          );
        },
      ),
    );
  }
}
