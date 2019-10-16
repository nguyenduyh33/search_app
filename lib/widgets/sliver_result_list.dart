import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/results.dart';
import './result_item.dart';
import './creation_aware_list_item.dart';

class SliverResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resultsData = Provider.of<Results>(context);
    final results = resultsData.results;

    return results.length > 0
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CreationAwareListItem(
                    child: ResultItem(result: results[index]),
                    onCreation: () {
                      Provider.of<Results>(context, listen: false)
                          .handleResultBuilt(index);
                    });
              },
              childCount: results.length,
            ),
          )
        : SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No results',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.title.fontSize,
                    ),
                  ),
                  Text('Try a synonym or more general words')
                ],
              ),
            ),
          );
  }
}
