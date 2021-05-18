import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_me/src/utils.dart';

class ListTileField<T> extends StatelessWidget {
  final String title;
  final T? initialValue;
  final void Function(T? value)? onSaved;
  final String? Function(T? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final Widget Function(FormFieldState<T> state) builder;
  final void Function(FormFieldState<T> state)? onTap;
  const ListTileField(
      {Key? key,
      required this.title,
      required this.builder,
      this.onTap,
      this.initialValue,
      this.autovalidateMode,
      this.onSaved,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) => ListTile(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (onTap != null) onTap!(state);
        },
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        title: Text(title, style: MindMeStyles.body1),
        subtitle: state.hasError && !isNull(state.errorText)
            ? Text(
                state.errorText!,
                style: MindMeStyles.caption.copyWith(color: Colors.red),
              )
            : null,
        trailing: builder(state),
      ),
    );
  }
}

class SwitchListTileField extends ListTileField<bool> {
  SwitchListTileField(
      {required String title,
      bool initialValue = false,
      Key? key,
      void Function(bool value)? onChanged})
      : super(
          key: key,
          onSaved: onChanged != null ? (value) => onChanged(value ?? false) : null,
          onTap: (state) {
            if (onChanged != null) onChanged(!state.value!);
            state.didChange(!state.value!);
          },
          title: title,
          initialValue: initialValue,
          builder: (state) => CupertinoSwitch(
            value: state.value ?? false,
            onChanged: (value) {
              if (onChanged != null) onChanged(value);
              state.didChange(value);
            },
            activeColor: MindMeColors.successGreen,
          ),
        );
}
