import 'package:flutter/material.dart';
import 'package:tap_and_jot/app/data/backup_data.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/ui/widgets/quote_animation.dart';

class FutureBuilderQuotes extends StatelessWidget {
  const FutureBuilderQuotes({
    super.key,
    required this.futureQuotes,
    required this.shouldDisplay,
    required this.isOpaque,
  });

  final Future<List<Quote>> futureQuotes;
  final bool shouldDisplay;
  final bool isOpaque;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quote>>(
        future: futureQuotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Semantics(
              label: 'Loading',
              textDirection: TextDirection.ltr,
              excludeSemantics: true,
              child: const Center(
                child: CircularProgressIndicator(
                  // dirty fix - TODO: fix progress indicator showing under hand icon
                  color: Colors.transparent),
              ),
            );
          } else if (snapshot.hasError) {
            return QuoteAnimation(
              quotes: backupQuotes,
              shouldDisplay: shouldDisplay,
              isOpaque: isOpaque,
            );
          } else if (snapshot.hasData) {
            return QuoteAnimation(
              quotes: snapshot.data!,
              shouldDisplay: shouldDisplay,
              isOpaque: isOpaque,
            );
          } else {
            return const Center(
              child: Text(
                'No data available',
                textDirection: TextDirection.ltr,
              ),
            );
          }
        });
  }
}
