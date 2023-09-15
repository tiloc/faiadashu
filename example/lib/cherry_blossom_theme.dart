import 'package:faiadashu/questionnaires/view/view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Demonstrate the creation of a scrolling questionnaire with no Scaffold
/// and a unique theme.
class CherryBlossomScaffoldBuilder extends QuestionnairePageScaffoldBuilder {
  const CherryBlossomScaffoldBuilder();

  @override
  Widget build(
    BuildContext context, {
    required void Function(void Function() p1) setStateCallback,
    required Widget child,
  }) {
    return Theme(
      data: ThemeData.light().copyWith(
        scrollbarTheme: ThemeData.light().scrollbarTheme.copyWith(
              thumbVisibility: MaterialStateProperty.all(true),
              thumbColor: MaterialStateProperty.all(
                const Color(0xFF5C1349),
              ),
            ),
        textTheme: GoogleFonts.ralewayTextTheme(),
        iconTheme: ThemeData.light().iconTheme.copyWith(
              color: const Color(0xFF5C1349),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              GoogleFonts.raleway(fontWeight: FontWeight.w600),
            ),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFF5C1349),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
        ),
        checkboxTheme: ThemeData.light().checkboxTheme.copyWith(
              fillColor: MaterialStateProperty.all(
                const Color(0xFFE30425),
              ),
            ),
        radioTheme: ThemeData.light().radioTheme.copyWith(
              fillColor: MaterialStateProperty.all(
                const Color(0xFFE30425),
              ),
            ),
        sliderTheme: ThemeData.light().sliderTheme.copyWith(
              thumbColor: const Color(0xFFE30425),
              activeTrackColor: const Color(0xFFE30425),
              inactiveTrackColor: const Color(0x60E30425),
            ),
        inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.0),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: ThemeData.light().colorScheme.error,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: ThemeData.light().colorScheme.error.withOpacity(0.12),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Color.fromRGBO(0, 0, 0, 0.54),
                ),
              ),
            ),
      ), // Make it always light
      // We have to take care of SafeArea ourselves
      child: SafeArea(
        // This surround Card provides the Material parent that is required by
        // the QuestionnaireFiller. Other potential Material parents would be
        // Scaffolds.
        child: Card(
          // This column surrounds the scroller with whimsical add-ons
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '🦄🌸🦄🌸🦄🌸🦄',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: child,
              ), // This child is the actual scroller
              const Divider(),
              // We're putting our own exit button in here
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('桜の園からの帰り道'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
