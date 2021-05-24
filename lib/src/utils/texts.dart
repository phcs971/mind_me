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
  static const goBack = "goBack";
  static const cancel = "cancel";
  static const ok = "ok";
  static const hours = "hours";
  static const minutes = "minutes";
  static const success = "success";
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
  //-> NotificationsText
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
  //-> Error
  static const baseError = "baseError";
  static const oops = "oops";
  static const somethingWentWrong = "somethingWentWrong";
  static const tryAgain = "tryAgain";
  static const clickTryAgain = "clickTryAgain";
  static const couldNotRemove = "couldNotRemove";
  static const couldNotAdd = "couldNotAdd";
  static const couldNotUpdate = "couldNotUpdate";
  //-> Home Page
  static const hello = "hello";
  static const noNotes = "noNotes";
  static const clickToAdd = "clickToAdd";
  //-> Config Page
  static const configNotificationActive = "configNotificationActive";
  static const language = "language";
  static const aboutTheApp = "aboutTheApp";
  static const speakWithUs = "speakWithUs";
  static const buyMeACoffee = "buyMeACoffee";
  static const removeNextNotification = "removeNextNotification";
  static const removeEverything = "removeEverything";
  //-> Auth
  // static const authGoToSettingsIOS = "authGoToSettingsIOS";
  // static const authGoToSettingsDescription = "authGoToSettingsDescription";
  // static const authLockOut = "authLockOut";
  static const authReason = "authReason";
  static const authWriteYourCode = "authWriteYourCode";
  static const authIncorrectCode = "authIncorrectCode";
  static const authIncompleteCode = "authIncompleteCode";

  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          languageName: "English",
          goBack: "Back",
          cancel: "Cancel",
          ok: "Ok",
          hours: "Hours",
          minutes: "Minutes",
          success: "Task Completed Successfully",
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
          //-> NotificationsText
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
          //-> Error
          baseError: "An error happened when doing this action!",
          oops: "Oops!",
          somethingWentWrong: "Something went wrong!",
          tryAgain: "TRY AGAIN",
          clickTryAgain: "Click Here to Try Again!",
          couldNotRemove: "Couldn't remove this note.",
          couldNotAdd: "Couldn't create this note.",
          couldNotUpdate: "Couldn't update this note.",
          //-> Home Page
          hello: "Hello!",
          noNotes: "It looks like you don't have any notes yet!",
          clickToAdd: "Tap the + button to create a new one.",
          //-> Config Page
          configNotificationActive: "Send Notifications",
          language: "Language",
          aboutTheApp: "About the App",
          speakWithUs: "Contact Me",
          buyMeACoffee: "Buy me a Burger",
          removeNextNotification: "REMOVE NEXT NOTIFICATIONS",
          removeEverything: "DELETE EVERYTHING",
          //-> Auth
          // authGoToSettingsIOS: "Settings",
          // authGoToSettingsDescription: "Please set up your authentication method",
          // authLockOut: "Please reenable your authentication method",
          authReason: "Please authenticate to see this note!",
          authWriteYourCode: "Write the 4 digit code to open this note",
          authIncorrectCode: "Incorrect Code",
          authIncompleteCode: "Code must have 4 digits",
        },
        'pt': {
          languageName: "Português",
          goBack: "Voltar",
          cancel: "Cancelar",
          ok: "Confirmar",
          hours: "Horas",
          minutes: "Minutos",
          success: "Operação realizada com sucesso!",
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
          //-> NotificationsText
          notificationRandom: "Aleatório",
          notificationWeekday: "Dias de Semana",
          notificationWeekend: "Finais de Semana",
          notificationEveryday: "Todos os Dias",
          //-> Add Note
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
          //-> Error
          baseError: "Um erro aconteceu ao realizar essa ação!",
          oops: "Opa!",
          somethingWentWrong: "Alguma coisa deu errado!",
          tryAgain: "TENTAR",
          clickTryAgain: "Clique Aqui para Tentar Novamente!",
          couldNotRemove: "Não foi possível remover esse lembrete.",
          couldNotAdd: "Não foi possível criar esse lembrete.",
          couldNotUpdate: "Não foi possível atualizar esse lembrete.",
          //-> Home Page
          hello: "Olá!",
          noNotes: "Parece que você ainda não tem nenhum lembrete!",
          clickToAdd: "Clique no botão + para criar um novo.",
          //-> Config Page
          configNotificationActive: "Enviar Notificações",
          language: "Linguagem",
          aboutTheApp: "Sobre o App",
          speakWithUs: "Fale Comigo",
          buyMeACoffee: "Me compre um lanche",
          removeNextNotification: "REMOVER PRÓXIMAS NOTIFICAÇÕES",
          removeEverything: "APAGAR TUDO",
          //-> Auth
          // authGoToSettingsIOS: "Ajustes",
          // authGoToSettingsDescription: "Por favor defina seu método de autenticação",
          // authLockOut: "Por favor tente novamente",
          authReason: "Por favor autentique-se para ver esse lembrete!",
          authWriteYourCode: "Escreva o código de 4 digitos para ver esse lembrete",
          authIncorrectCode: "Código Incorreto",
          authIncompleteCode: "O código deve ter 4 digitos",
        }
      };
}
