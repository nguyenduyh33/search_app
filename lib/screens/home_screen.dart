import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../widgets/sliver_search_bar.dart';
import '../widgets/sliver_result_list.dart';

import '../providers/results.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  var _currentSearchTerm;

  Future<void> handleSearch(String searchTerm) async {
    setState(() {
      _isLoading = true;
      _currentSearchTerm = searchTerm;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverSearchBar(handleSearch),
          _isLoading
              ? SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              // : SliverResultList()
              : isEmpty(_currentSearchTerm)
                  ? SliverFillRemaining(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Text(
                            'Try searching for something on eBay!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  Theme.of(context).textTheme.title.fontSize,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SliverResultList(),
        ],
      ),
    );
  }
}
