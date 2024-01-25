import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdpatativeButtons extends StatelessWidget {
  final String? label;
  final Function()? fn;

  const AdpatativeButtons({
    this.label,
    this.fn,
  });

  @override
  Widget build(BuildContext context) {
    // PROCURAR UMA FORMA DE SUBSTITUIR
    // const buttonData = {child: this.label!, onPressed: this.fn};
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(this.label!),
            onPressed: this.fn!,
          )
        : ElevatedButton(
            child: Text(this.label!),
            onPressed: this.fn!,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary),
            ),
          );
  }
}
