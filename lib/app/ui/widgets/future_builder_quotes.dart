import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_jot/app/data/backup_data.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';
import 'package:tap_and_jot/app/ui/widgets/animated_hand_touch.dart';
import 'package:tap_and_jot/app/ui/widgets/blur_background.dart';
import 'package:tap_and_jot/app/ui/widgets/quote_animation.dart';

class FutureBuilderQuotes extends StatefulWidget {
  const FutureBuilderQuotes({super.key, required this.futureQuotes});

  final Future<List<Quote>> futureQuotes;

  @override
  State<FutureBuilderQuotes> createState() => _FutureBuilderQuotesState();
}

class _FutureBuilderQuotesState extends State<FutureBuilderQuotes>
    with TickerProviderStateMixin {
  late AnimationController _touchHandController;

  @override
  void initState() {
    _touchHandController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _touchHandController.reset();
    _touchHandController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _touchHandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuotesProvider>(builder: (context, provider, child) {
      return FutureBuilder<List<Quote>>(
          future: widget.futureQuotes,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Semantics(
                label: 'Loading',
                textDirection: TextDirection.ltr,
                excludeSemantics: true,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return _buildQuote(backupQuotes, provider);
            } else if (snapshot.hasData) {
              return _buildQuote(snapshot.data!, provider);
            } else {
              return const Center(
                child: Text(
                  'No data available',
                  textDirection: TextDirection.ltr,
                ),
              );
            }
          });
    });
  }

  Widget _buildQuote(List<Quote> quotes, QuotesProvider provider) {
    return Column(
      children: [
        Expanded(
            child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Visibility(
                visible: provider.isHandIconVisible,
                child: AnimatedHandTouch(
                    touchHandController: _touchHandController,
                    showQuote: provider.showQuoteOnTap)),
            BlurBackground(shouldDisplay: provider.shouldDisplay),
            QuoteAnimation(
              quotes: quotes,
            ),
          ],
        )),
      ],
    );
  }
}
