import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePreviewDialog extends StatefulWidget {
  const SignaturePreviewDialog({
    @required this.points,
  });

  final List<Point> points;

  @override
  _SignaturePreviewDialogState createState() => _SignaturePreviewDialogState();
}

class _SignaturePreviewDialogState extends State<SignaturePreviewDialog> {
  SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(points: widget.points);
  }

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
                    'Signature',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 24.0),
                  Signature(
                    height: 248.0,
                    controller: _signatureController,
                  ),
                ],
              ),
            ),
            ButtonBar(
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
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
