import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePadDialog extends StatefulWidget {
  const SignaturePadDialog();

  @override
  _SignaturePadDialogState createState() => _SignaturePadDialogState();
}

class _SignaturePadDialogState extends State<SignaturePadDialog> {
  final SignatureController _signatureController = SignatureController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
      const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Draw your signature',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 24.0),
                  Signature(
                    height: 248.0,
                    controller: _signatureController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton.icon(
                      textColor: Colors.red,
                      onPressed: () {
                        _signatureController.clear();
                      },
                      icon: const Icon(Icons.clear),
                      label: const Text('CLEAR'),
                    ),
                  )
                ],
              ),
            ),
            ButtonBar(
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: const Text('CANCEL'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, _signatureController.points);
                  },
                  child: const Text('SIGN'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }
}
