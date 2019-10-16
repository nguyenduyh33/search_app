import 'package:flutter/material.dart';

class CreationAwareListItem extends StatefulWidget {
  final Function onCreation;
  final Widget child;
  const CreationAwareListItem({
    Key key,
    this.onCreation,
    this.child,
  }) : super(key: key);

  @override
  _CreationAwareListItemState createState() => _CreationAwareListItemState();
}

class _CreationAwareListItemState extends State<CreationAwareListItem> {
  @override
  void initState() {
    super.initState();
    if (widget.onCreation != null) {
      widget.onCreation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
