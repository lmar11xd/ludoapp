import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

AppBar buildAppBar(BuildContext context) {
  const icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(icon)),
    ],
  );
}
