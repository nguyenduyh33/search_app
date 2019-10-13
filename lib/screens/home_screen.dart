import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/sliver_search_bar.dart';
import '../widgets/sliver_result_list.dart';

import '../providers/results.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;

  Future<void> handleSearch(String searchTerm) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Results>(context, listen: false)
          .findItemsByKeywords(searchTerm);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occured!'),
                content: Text('Something went wrong.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   final PreferredSizeWidget appBar = AppBar(
  //     title: Text(widget.title),
  //     // title: SearchBar(handleSearch),
  //   );

  //   final mediaQuery = MediaQuery.of(context);
  //   final isLandscape = mediaQuery.orientation == Orientation.landscape;
  //   final bodySize = mediaQuery.size.height -
  //       appBar.preferredSize.height -
  //       mediaQuery.padding.top -
  //       mediaQuery.padding.bottom;

  //   final pageBody = SafeArea(
  //     child: SingleChildScrollView(
  //       child: Container(
  //         color: Color(0xFF736AB7),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             Container(
  //               height: bodySize * (!isLandscape ? 0.1 : 0.3),
  //               child: SearchBar(handleSearch),
  //             ),
  //             Container(
  //                 height: bodySize * (!isLandscape ? 0.9 : 0.7),
  //                 child: _isLoading
  //                     ? Center(
  //                         child: CircularProgressIndicator(),
  //                       )
  //                     : ResultList()),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );

  //   return Scaffold(
  //     appBar: appBar,
  //     body: pageBody,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverSearchBar(handleSearch),
          _isLoading
              ? SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SliverResultList(),
        ],
      ),
    );
  }
}
