import 'package:flutter/material.dart';

class ResultDetailScreen extends StatelessWidget {
  final String resultId;
  final String resultTitle;

  const ResultDetailScreen(this.resultId, this.resultTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resultTitle),
      ),
      body: Column(
        // child: Text('This is the detail screen'),
      ),
    );
  }
}
