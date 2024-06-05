// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tap_and_jot/app/ui/screens/home_page.dart';
import 'package:tap_and_jot/app/ui/screens/quote_page.dart';

void main() {
  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });
  testWidgets('Home Screen meets a11y criteria', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(const HomePage());

    // Checks that tappable nodes have a minimum size of 48 by 48 pixels
    // for Android.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    // Checks that tappable nodes have a minimum size of 44 by 44 pixels
    // for iOS.
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

    // Checks that touch targets with a tap or long press action are labeled.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    // Checks whether semantic nodes meet the minimum text contrast levels.
    // The recommended text contrast is 3:1 for larger text
    // (18 point and above regular).
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });

  testWidgets('Quote Screen meets a11y criteria', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(const MaterialApp(home: QuotePage()));

    // Checks that tappable nodes have a minimum size of 48 by 48 pixels
    // for Android.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    // Checks that tappable nodes have a minimum size of 44 by 44 pixels
    // for iOS.
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

    // // Checks that touch targets with a tap or long press action are labeled.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    // // Checks whether semantic nodes meet the minimum text contrast levels.
    // // The recommended text contrast is 3:1 for larger text
    // // (18 point and above regular).
    await expectLater(tester, meetsGuideline(textContrastGuideline));

    await tester.pump(const Duration(seconds: 3));

    handle.dispose();
  });
}
