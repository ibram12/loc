// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `loc`
  String get name_app {
    return Intl.message(
      'loc',
      name: 'name_app',
      desc: '',
      args: [],
    );
  }

  /// `loc`
  String get title {
    return Intl.message(
      'loc',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `add loc`
  String get add_khdma {
    return Intl.message(
      'add loc',
      name: 'add_khdma',
      desc: '',
      args: [],
    );
  }

  /// `name loc`
  String get name_loc {
    return Intl.message(
      'name loc',
      name: 'name_loc',
      desc: '',
      args: [],
    );
  }

  /// `floor`
  String get floor {
    return Intl.message(
      'floor',
      name: 'floor',
      desc: '',
      args: [],
    );
  }

  /// `add loc`
  String get add_loc {
    return Intl.message(
      'add loc',
      name: 'add_loc',
      desc: '',
      args: [],
    );
  }

  /// `Cancal`
  String get cancal {
    return Intl.message(
      'Cancal',
      name: 'cancal',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this item?`
  String get mass_alart {
    return Intl.message(
      'Are you sure you want to remove this item?',
      name: 'mass_alart',
      desc: '',
      args: [],
    );
  }

  /// `Remove Item`
  String get title_alart {
    return Intl.message(
      'Remove Item',
      name: 'title_alart',
      desc: '',
      args: [],
    );
  }

  /// `Halls`
  String get halls {
    return Intl.message(
      'Halls',
      name: 'halls',
      desc: '',
      args: [],
    );
  }

  /// `Book Hall`
  String get book_hall {
    return Intl.message(
      'Book Hall',
      name: 'book_hall',
      desc: '',
      args: [],
    );
  }

  /// `Add a reservation`
  String get add_reservation {
    return Intl.message(
      'Add a reservation',
      name: 'add_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get start_time {
    return Intl.message(
      'Start Time',
      name: 'start_time',
      desc: '',
      args: [],
    );
  }

  /// `Select Start Time`
  String get set_start_time {
    return Intl.message(
      'Select Start Time',
      name: 'set_start_time',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get end_time {
    return Intl.message(
      'End Time',
      name: 'end_time',
      desc: '',
      args: [],
    );
  }

  /// `Select End Time`
  String get set_end_time {
    return Intl.message(
      'Select End Time',
      name: 'set_end_time',
      desc: '',
      args: [],
    );
  }

  /// `Selected Time Range`
  String get time_range {
    return Intl.message(
      'Selected Time Range',
      name: 'time_range',
      desc: '',
      args: [],
    );
  }

  /// `Choose the date`
  String get choose_date {
    return Intl.message(
      'Choose the date',
      name: 'choose_date',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
