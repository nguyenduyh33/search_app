import 'package:flutter/material.dart';

class SliverSearchBar extends StatefulWidget {
  final Function onChanged;

  SliverSearchBar(this.onChanged);

  @override
  _SliverSearchBarState createState() => _SliverSearchBarState();
}

class _SliverSearchBarState extends State<SliverSearchBar> {
  final _textFieldController = TextEditingController();
  FocusNode _focusNode;
  var _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocus);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_textFieldController.text.length == 1) {
      return;
    }
    widget.onChanged(_textFieldController.text);
    _showClearButton = false;
  }

  void _handleChange() {
    setState(() {
      _showClearButton = _textFieldController.text.isNotEmpty;
    });
  }

  void _handleFocus() {
    print(_focusNode.hasFocus);

    setState(() {
      if (_focusNode.hasFocus) {
        _showClearButton = _textFieldController.text.isNotEmpty;
      } else {
        _showClearButton = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height * .3,
      title: TextField(
        focusNode: _focusNode,
        controller: _textFieldController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).primaryColorLight,
          hintText: 'Search eBay...',
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
          suffixIcon: _showClearButton
              ? IconButton(
                  icon: Icon(Icons.clear),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    // Workaround for framework issue found here https://github.com/flutter/flutter/issues/17647
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _textFieldController.clear();
                      });
                    });
                  },
                )
              : null,
        ),
        onChanged: (_) {
          _handleChange();
        },
        onSubmitted: (_) {
          _submitData();
        },
      ),
      flexibleSpace: Stack(children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/alvord4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: Text(
            'Looking For Something?',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ),
      ]),
    );
  }
}
