import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:provider/provider.dart';
import 'package:search_app/widgets/icon_field.dart';
import '../providers/results.dart';

class ResultDetailScreen extends StatelessWidget {
  final String resultId;

  const ResultDetailScreen(this.resultId);

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<Results>(
      context,
      listen: false,
    ).findById(resultId);

    final topContent = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(result.imageUrl),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(10),
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Colors.black87,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              '\$${result?.price}',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );

    final titleSection = Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    result.title,
                    style: Theme.of(context).textTheme.title.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
                isNotEmpty(result?.primaryCategory?.categoryName)
                    ? Text('Category: ${result.primaryCategory.categoryName}')
                    : Container(),
                isNotEmpty(result?.condition?.conditionDisplayName)
                    ? Text(
                        'Condition: ${result.condition.conditionDisplayName}')
                    : Container(),
                isNotEmpty(result?.subtitle)
                    ? Container(
                        padding: const EdgeInsets.all(16),
                        child: Text('Test', softWrap: true),
                      )
                    : Container(),
              ],
            ),
          ),
          IconField(
              text: result.timeLeftSummary,
              color: result.isExpiringWithin24Hours
                  ? Colors.red
                  : Theme.of(context).accentColor,
              iconData: Icons.timer,
              stack: true),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Back'),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            topContent,
            titleSection,
          ],
        ),
      ),
    );
  }
}
