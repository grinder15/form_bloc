import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:signature/signature.dart';

import 'signature_pad_dialog.dart';
import 'signature_preview_dialog.dart';

class SignatureFieldBlocBuilder extends StatelessWidget {
  const SignatureFieldBlocBuilder({
    Key key,
    @required this.inputFieldBloc,
    this.enableOnlyWhenFormBlocCanSubmit = false,
    this.isEnabled = true,
    this.errorBuilder,
    this.padding,
    this.decoration = const InputDecoration(),
    this.animateWhenCanShow = true,
  })  : assert(enableOnlyWhenFormBlocCanSubmit != null),
        assert(isEnabled != null),
        assert(decoration != null),
        super(key: key);

  final InputFieldBloc<List<Point>, Object> inputFieldBloc;

  final FieldBlocErrorBuilder errorBuilder;

  final bool enableOnlyWhenFormBlocCanSubmit;

  final bool isEnabled;

  final EdgeInsets padding;

  final InputDecoration decoration;

  final bool animateWhenCanShow;

  @override
  Widget build(BuildContext context) {
    return DialogFieldBlocBuilder<List<Point>>(
      inputFieldBloc: inputFieldBloc,
      errorBuilder: errorBuilder,
      enableOnlyWhenFormBlocCanSubmit: enableOnlyWhenFormBlocCanSubmit,
      isEnabled: isEnabled,
      padding: padding,
      decoration: decoration.copyWith(
          suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<InputFieldBloc<List<Point>, Object>,
              InputFieldBlocState<List<Point>, Object>>(
            cubit: inputFieldBloc,
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: state.value != null && state.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => SignaturePreviewDialog(
                                points: state.value),
                          );
                        },
                      )
                    : Container(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              inputFieldBloc.clear();
            },
          ),
        ],
      )),
      animateWhenCanShow: animateWhenCanShow,
      showDialog: (context) async {
        final points = await showDialog<List<Point>>(
          context: context,
          builder: (_) => const SignaturePadDialog(),
        );
        return points;
      },
      convertToString: (value) {
        return value.isEmpty ? 'Please sign here' : 'You already signed';
      },
    );
  }
}
