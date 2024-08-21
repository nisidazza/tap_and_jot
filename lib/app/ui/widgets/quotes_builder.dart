import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_jot/app/data/backup_data.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';
import 'package:tap_and_jot/app/ui/widgets/animated_hand_touch.dart';
import 'package:tap_and_jot/app/ui/widgets/blur_background.dart';
import 'package:tap_and_jot/app/ui/widgets/quote_animation.dart';

class QuotesBuilder extends StatefulWidget {
  const QuotesBuilder({super.key});

  @override
  State<QuotesBuilder> createState() => _QuotesBuilderState();
}

class _QuotesBuilderState extends State<QuotesBuilder> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuotesProvider>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuotesProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return Semantics(
          label: 'Loading',
          textDirection: TextDirection.ltr,
          excludeSemantics: true,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (provider.errorMessage.isNotEmpty) {
        return _buildQuote(backupQuotes, provider);
      } else if (provider.quotes.isNotEmpty) {
        return _buildQuote(provider.quotes, provider);
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

  Widget _buildQuote(List<Quote> quotes, QuotesProvider provider) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Visibility(
            visible: provider.isHandIconVisible,
            child: const AnimatedHandTouch()),
        BlurBackground(isQuoteVisible: provider.isQuoteVisible),
        QuoteAnimation(
          quotes: quotes,
        ),
      ],
    );
  }
}
