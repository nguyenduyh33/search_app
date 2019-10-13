import 'package:flutter/material.dart';

class SliverSearchBar extends StatefulWidget {
  final Function onChanged;

  SliverSearchBar(this.onChanged);

  @override
  _SliverSearchBarState createState() => _SliverSearchBarState();
}

class _SliverSearchBarState extends State<SliverSearchBar> {
  final _textFieldController = TextEditingController();

  void submitData() {
    final searchText = _textFieldController.text;
    widget.onChanged(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(12.0),
        child: Text(''),
      ),
      floating: true,
      pinned: false,
      snap: true,
      primary: true,
      automaticallyImplyLeading: false,
      title: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          // border: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          suffixIcon: _textFieldController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear),
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
          setState(() {});
        },
        onSubmitted: (_) {
          submitData();
        },
      ),
    );
  }
}
