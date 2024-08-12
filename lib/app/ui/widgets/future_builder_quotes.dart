import 'package:flutter/material.dart';
import 'package:tap_and_jot/app/data/backup_data.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/ui/widgets/animated_hand_touch.dart';
import 'package:tap_and_jot/app/ui/widgets/blur_background.dart';
import 'package:tap_and_jot/app/ui/widgets/quote_animation.dart';

class FutureBuilderQuotes extends StatefulWidget {
  const FutureBuilderQuotes(
      {super.key,
      required this.futureQuotes,
      required this.shouldDisplay,
      required this.isOpaque,
      required this.showQuoteOnTap,
      required this.isHandIconVisible});

  final Future<List<Quote>> futureQuotes;
  final bool shouldDisplay;
  final bool isOpaque;
  final VoidCallback showQuoteOnTap;
  final bool isHandIconVisible;

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
    return FutureBuilder<List<Quote>>(
        future: widget.futureQuotes,
        builder: (context, snapshot) {
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
            return _buildQuote(backupQuotes);
          } else if (snapshot.hasData) {
            return _buildQuote(snapshot.data!);
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

  Widget _buildQuote(List<Quote> data) {
    return Column(
      children: [
        Expanded(
            child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Visibility(
                visible: widget.isHandIconVisible,
                child: AnimatedHandTouch(
                    touchHandController: _touchHandController,
                    showQuote: widget.showQuoteOnTap)),
            BlurBackground(shouldDisplay: widget.shouldDisplay),
            QuoteAnimation(
              quotes: data,
              shouldDisplay: widget.shouldDisplay,
              isOpaque: widget.isOpaque,
            ),
          ],
        )),
      ],
    );
  }
}
