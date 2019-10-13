import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/results.dart';
import './result_item.dart';

class SliverResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resultsData = Provider.of<Results>(context);
    final results = resultsData.results;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ResultItem(result: results[index]);
        },
        childCount: results.length,
      ),
    );
  }
}
