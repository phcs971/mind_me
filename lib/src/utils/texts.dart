part of '../utils.dart';

class MindMeStyles {
  static AppLocalizations? get text => AppLocalizations.of(Get.context!);
  MindMeStyles._();

  static const fontFamily = "Chalkboard SE";
  static TextStyle theme({
    Color color = Colors.black,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle header = theme(fontWeight: FontWeight.w700, fontSize: 24);

  static TextStyle title = theme(fontWeight: FontWeight.w700, fontSize: 19);

  static TextStyle subtitle1 = theme(fontWeight: FontWeight.w700, fontSize: 16);

  static TextStyle subtitle2 = theme(fontWeight: FontWeight.w600, fontSize: 14);

  static TextStyle body1 = theme(fontWeight: FontWeight.w400, fontSize: 16);

  static TextStyle body2 = theme(fontWeight: FontWeight.w400, fontSize: 14);

  static TextStyle caption = theme(fontWeight: FontWeight.w400, fontSize: 12);

  static TextStyle overline = theme(fontWeight: FontWeight.w700, fontSize: 10);

  static TextStyle button1 = theme(fontWeight: FontWeight.w700, fontSize: 14);

  static TextStyle button2 = theme(fontWeight: FontWeight.w700, fontSize: 12);
}

class MindMeTexts extends Translations {
  static const languageName = "languageName";
  static const cancel = "cancel";
  static const ok = "ok";
  static const hours = "hours";
  static const minutes = "minutes";
  //-> Pages
  static const settingsPage = "settingsPage";
  static const notePage = "notePage";
  static const mindMe = "mindMe";
  //-> WeekDays
  static const dayMon = "dayMon";
  static const dayTue = "dayTue";
  static const dayWed = "dayWed";
  static const dayThu = "dayThu";
  static const dayFri = "dayFri";
  static const daySat = "daySat";
  static const daySun = "daySun";
  //-> Notifications
  static const notificationRandom = "notificationRandom";
  static const notificationWeekday = "notificationWeekday";
  static const notificationWeekend = "notificationWeekend";
  static const notificationEveryday = "notificationEveryday";
  //-> Add Note
  static const writeHereNoteHint = "writeHereNoteHint";
  static const requiredValue = "requiredValue";
  static const noteColor = "noteColor";
  static const pickAColor = "pickAColor";
  static const lockByPass = "lockByPass";
  static const localAuth = "localAuth";
  static const fourDigitCode = "fourDigitCode";
  static const sendNotification = "sendNotification";
  static const randomNotification = "randomNotification";
  static const notifyAt = "notifyAt";
  //-> ConfirmDialog
  static const sureLeavePage = "sureLeavePage";
  static const loseChanges = "loseChanges";
  static const noComingBack = "noComingBack";
  static const sureDeleteEverything = "sureDeleteEverything";
  static const sureDeleteThis = "sureDeleteThis";
  static const sureDeleteNotification = "sureDeleteNotification";
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          languageName: "English",
          cancel: "Cancel",
          ok: "Ok",
          hours: "Hours",
          minutes: "Minutes",
          //-> Pages
          settingsPage: "Settings",
          notePage: "Note",
          mindMe: "MIND ME",
          //-> WeekDays
          dayMon: "Mon",
          dayTue: "Tue",
          dayWed: "Wed",
          dayThu: "Thu",
          dayFri: "Fri",
          daySat: "Sat",
          daySun: "Sun",
          //-> Notifications
          notificationRandom: "Random",
          notificationWeekday: "Weekdays",
          notificationWeekend: "Weekends",
          notificationEveryday: "Everyday",
          //-> Add Note
          writeHereNoteHint: "Write here your note...",
          requiredValue: "This item is required!",
          noteColor: "Note Color",
          pickAColor: "Pick a Color",
          lockByPass: "Lock by Password",
          localAuth: "Use Cellphone Authentication",
          fourDigitCode: "Four Digit Code",
          sendNotification: "Send Notifications",
          randomNotification: "Random Notifications",
          notifyAt: "Notify at",
          //-> Confirm Dialog
          sureLeavePage: "Are you sure you want to leave this page?",
          loseChanges: "You will lose all the changes you made!",
          noComingBack: "There is no coming back from this!",
          sureDeleteEverything: "Are you sure you want to delete everything?",
          sureDeleteThis: "Are you sure you want to delete this notes?",
          sureDeleteNotification: "Are you sure you want to remove all notifications?",
        },
        'pt': {
          languageName: "Português",
          cancel: "Cancelar",
          ok: "Confirmar",
          hours: "Horas",
          minutes: "Minutos",
          //-> Pages
          settingsPage: "Configurações",
          notePage: "Lembrete",
          mindMe: "MIND ME",
          //-> WeekDays
          dayMon: "Seg",
          dayTue: "Ter",
          dayWed: "Qua",
          dayThu: "Qui",
          dayFri: "Sex",
          daySat: "Sab",
          daySun: "Dom",
          //-> Notifications
          notificationRandom: "Aleatório",
          notificationWeekday: "Dias de Semana",
          notificationWeekend: "Finais de Semana",
          notificationEveryday: "Todos os Dias",
          //->Add Note
          writeHereNoteHint: "Escreva aqui seu lembrete...",
          requiredValue: "Este item é obrigatório!",
          noteColor: "Cor do Lembrete",
          pickAColor: "Escolha uma cor",
          lockByPass: "Bloquear por Senha",
          localAuth: "Usar Autenticação do Celular",
          fourDigitCode: "Código de 4 digitos",
          sendNotification: "Enviar Notificações",
          randomNotification: "Notificações Aleatórias",
          notifyAt: "Notificar em",
          //-> Confirm Dialog
          sureLeavePage: "Você tem certeza que deseja sair dessa página?",
          loseChanges: "Você perdera todas as mudanças feitas!",
          noComingBack: "Não tem como desfazer essa ação!",
          sureDeleteEverything: "Você tem certeza que deseja deletar tudo?",
          sureDeleteThis: "Você tem certeza que deseja deletar esse lembrete?",
          sureDeleteNotification: "Você tem certeza que deseja remover todas notificações?",
        }
      };
}
