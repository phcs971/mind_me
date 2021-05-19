import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mind_me/src/service/service.dart';
import 'package:mind_me/src/stores/notes.store.dart';
import 'package:mind_me/src/widgets/note.widget.dart';
import 'package:reorderables/reorderables.dart';

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
          return ReorderableWrap(
            onReorder: store.reoorder,
            padding: EdgeInsets.all(16),
            spacing: 16,
            runSpacing: 16,
            buildDraggableFeedback: (_, __, child) => _buildOnDrag(child),
            children: List.generate(store.notes.length, (index) => NoteWidget(store.notes[index])),
          );
        },
      ),
    );
  }
}
