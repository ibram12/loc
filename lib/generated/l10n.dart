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

  /// `Add Hall`
  String get add_hall {
    return Intl.message(
      'Add Hall',
      name: 'add_hall',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Time Line`
  String get time_line {
    return Intl.message(
      'Time Line',
      name: 'time_line',
      desc: '',
      args: [],
    );
  }

  /// `Add Event`
  String get add_event {
    return Intl.message(
      'Add Event',
      name: 'add_event',
      desc: '',
      args: [],
    );
  }

  /// `Admin Panel`
  String get admin_panel {
    return Intl.message(
      'Admin Panel',
      name: 'admin_panel',
      desc: '',
      args: [],
    );
  }

  /// `made a reservation from`
  String get home_made_a_reservation_from {
    return Intl.message(
      'made a reservation from',
      name: 'home_made_a_reservation_from',
      desc: '',
      args: [],
    );
  }

  /// `Make Reservation`
  String get make_reservation {
    return Intl.message(
      'Make Reservation',
      name: 'make_reservation',
      desc: '',
      args: [],
    );
  }

  /// `New Service`
  String get new_service {
    return Intl.message(
      'New Service',
      name: 'new_service',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message(
      'to',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `for`
  String get forr {
    return Intl.message(
      'for',
      name: 'forr',
      desc: '',
      args: [],
    );
  }

  /// `in`
  String get inn {
    return Intl.message(
      'in',
      name: 'inn',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get time_line_loading {
    return Intl.message(
      'Loading...',
      name: 'time_line_loading',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `please, Select Service`
  String get please_select_service {
    return Intl.message(
      'please, Select Service',
      name: 'please_select_service',
      desc: '',
      args: [],
    );
  }

  /// `on`
  String get on {
    return Intl.message(
      'on',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `at`
  String get at {
    return Intl.message(
      'at',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `to make`
  String get to_make {
    return Intl.message(
      'to make',
      name: 'to_make',
      desc: '',
      args: [],
    );
  }

  /// `SELECT YOUR SERVICE`
  String get select_your_service {
    return Intl.message(
      'SELECT YOUR SERVICE',
      name: 'select_your_service',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get add_reservation_something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'add_reservation_something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `your request sent successfully`
  String get your_request_sent_successfully {
    return Intl.message(
      'your request sent successfully',
      name: 'your_request_sent_successfully',
      desc: '',
      args: [],
    );
  }

  /// `sent request`
  String get sent_request {
    return Intl.message(
      'sent request',
      name: 'sent_request',
      desc: '',
      args: [],
    );
  }

  /// `please select hall`
  String get please_select_hall {
    return Intl.message(
      'please select hall',
      name: 'please_select_hall',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get book_hall_something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'book_hall_something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Remove Hall`
  String get remove_hall {
    return Intl.message(
      'Remove Hall',
      name: 'remove_hall',
      desc: '',
      args: [],
    );
  }

  /// `Hall`
  String get hall {
    return Intl.message(
      'Hall',
      name: 'hall',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Password`
  String get admin_feature_wrong_password {
    return Intl.message(
      'Wrong Password',
      name: 'admin_feature_wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Add New User`
  String get add_new_user {
    return Intl.message(
      'Add New User',
      name: 'add_new_user',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get user_name {
    return Intl.message(
      'User Name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up Successfully`
  String get sign_up_successfully {
    return Intl.message(
      'Sign Up Successfully',
      name: 'sign_up_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter User Email`
  String get enter_user_email {
    return Intl.message(
      'Enter User Email',
      name: 'enter_user_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Select Services`
  String get select_services {
    return Intl.message(
      'Select Services',
      name: 'select_services',
      desc: '',
      args: [],
    );
  }

  /// `please select service type`
  String get please_select_service_type {
    return Intl.message(
      'please select service type',
      name: 'please_select_service_type',
      desc: '',
      args: [],
    );
  }

  /// `please select role type`
  String get please_select_role_type {
    return Intl.message(
      'please select role type',
      name: 'please_select_role_type',
      desc: '',
      args: [],
    );
  }

  /// `Enter Admin Password`
  String get enter_admin_password {
    return Intl.message(
      'Enter Admin Password',
      name: 'enter_admin_password',
      desc: '',
      args: [],
    );
  }

  /// `Admin Password`
  String get admin_password {
    return Intl.message(
      'Admin Password',
      name: 'admin_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Service Type`
  String get enter_service_type {
    return Intl.message(
      'Enter Service Type',
      name: 'enter_service_type',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message(
      'Service',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get service_type {
    return Intl.message(
      'Service Type',
      name: 'service_type',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `App Users`
  String get app_users {
    return Intl.message(
      'App Users',
      name: 'app_users',
      desc: '',
      args: [],
    );
  }

  /// `No Users yet`
  String get no_users_yet {
    return Intl.message(
      'No Users yet',
      name: 'no_users_yet',
      desc: '',
      args: [],
    );
  }

  /// `Wellcome`
  String get wellcome {
    return Intl.message(
      'Wellcome',
      name: 'wellcome',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login To Continue Using The App`
  String get login_to_continue_using_the_app {
    return Intl.message(
      'Login To Continue Using The App',
      name: 'login_to_continue_using_the_app',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get login_email {
    return Intl.message(
      'Email',
      name: 'login_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get enter_your_email {
    return Intl.message(
      'Enter Your Email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_password {
    return Intl.message(
      'Password',
      name: 'login_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password ?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Pick the date`
  String get pick_the_date {
    return Intl.message(
      'Pick the date',
      name: 'pick_the_date',
      desc: '',
      args: [],
    );
  }

  /// `The operation has been cancelled`
  String get the_operation_has_been_cancelled {
    return Intl.message(
      'The operation has been cancelled',
      name: 'the_operation_has_been_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Edit start time`
  String get edit_start_time {
    return Intl.message(
      'Edit start time',
      name: 'edit_start_time',
      desc: '',
      args: [],
    );
  }

  /// `Edit end time`
  String get edit_end_time {
    return Intl.message(
      'Edit end time',
      name: 'edit_end_time',
      desc: '',
      args: [],
    );
  }

  /// `You Have Updated Your Request from`
  String get you_have_updated_your_request_from {
    return Intl.message(
      'You Have Updated Your Request from',
      name: 'you_have_updated_your_request_from',
      desc: '',
      args: [],
    );
  }

  /// `The start time is after the end time`
  String get the_start_time_is_after_the_end_time {
    return Intl.message(
      'The start time is after the end time',
      name: 'the_start_time_is_after_the_end_time',
      desc: '',
      args: [],
    );
  }

  /// `The start time can't be the same as the end time`
  String get the_start_time_cant_be_the_same_as_the_end_time {
    return Intl.message(
      'The start time can\'t be the same as the end time',
      name: 'the_start_time_cant_be_the_same_as_the_end_time',
      desc: '',
      args: [],
    );
  }

  /// `There was a conflict with another reservation`
  String get there_was_a_conflict_with_another_reservation {
    return Intl.message(
      'There was a conflict with another reservation',
      name: 'there_was_a_conflict_with_another_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch requests`
  String get failed_to_fetch_requests {
    return Intl.message(
      'Failed to fetch requests',
      name: 'failed_to_fetch_requests',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get sign_up_cubit_in_admin_the_password_provided_is_too_weak {
    return Intl.message(
      'The password provided is too weak.',
      name: 'sign_up_cubit_in_admin_the_password_provided_is_too_weak',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get the_account_already_exists_for_that_email {
    return Intl.message(
      'The account already exists for that email.',
      name: 'the_account_already_exists_for_that_email',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try later.`
  String get something_went_wrong_please_try_later {
    return Intl.message(
      'Something went wrong, please try later.',
      name: 'something_went_wrong_please_try_later',
      desc: '',
      args: [],
    );
  }

  /// `Wrong email or password`
  String get login_cubit_messages_wrong_email_or_password {
    return Intl.message(
      'Wrong email or password',
      name: 'login_cubit_messages_wrong_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Pick the start time`
  String get select_time_cubit_in_book_hall_feature_pick_the_start_time {
    return Intl.message(
      'Pick the start time',
      name: 'select_time_cubit_in_book_hall_feature_pick_the_start_time',
      desc: '',
      args: [],
    );
  }

  /// `The operation has been cancelled`
  String
      get select_time_cubit_in_book_hall_feature_the_operation_has_been_cancelled {
    return Intl.message(
      'The operation has been cancelled',
      name:
          'select_time_cubit_in_book_hall_feature_the_operation_has_been_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Pick the end time`
  String get select_time_cubit_in_book_hall_feature_pick_the_end_time {
    return Intl.message(
      'Pick the end time',
      name: 'select_time_cubit_in_book_hall_feature_pick_the_end_time',
      desc: '',
      args: [],
    );
  }

  /// `Pick the date`
  String get select_time_cubit_in_book_hall_feature_pick_the_date {
    return Intl.message(
      'Pick the date',
      name: 'select_time_cubit_in_book_hall_feature_pick_the_date',
      desc: '',
      args: [],
    );
  }

  /// `The start time can't be after the end time`
  String
      get select_time_cubit_in_book_hall_feature_the_start_time_cant_be_after_the_end_time {
    return Intl.message(
      'The start time can\'t be after the end time',
      name:
          'select_time_cubit_in_book_hall_feature_the_start_time_cant_be_after_the_end_time',
      desc: '',
      args: [],
    );
  }

  /// `The end time can't be the same as the start time`
  String
      get select_time_cubit_in_book_hall_feature_the_end_time_cant_be_the_same_as_the_start_time {
    return Intl.message(
      'The end time can\'t be the same as the start time',
      name:
          'select_time_cubit_in_book_hall_feature_the_end_time_cant_be_the_same_as_the_start_time',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch requests`
  String get show_user_requests_in_requests_feature_failed_to_fetch_requests {
    return Intl.message(
      'Failed to fetch requests',
      name: 'show_user_requests_in_requests_feature_failed_to_fetch_requests',
      desc: '',
      args: [],
    );
  }

  /// `Edit the date`
  String get user_edit_request_cubit_in_requests_feature_edit_the_date {
    return Intl.message(
      'Edit the date',
      name: 'user_edit_request_cubit_in_requests_feature_edit_the_date',
      desc: '',
      args: [],
    );
  }

  /// `Edit start time`
  String get user_edit_request_cubit_in_requests_feature_edit_start_time {
    return Intl.message(
      'Edit start time',
      name: 'user_edit_request_cubit_in_requests_feature_edit_start_time',
      desc: '',
      args: [],
    );
  }

  /// `Edit end time`
  String get user_edit_request_cubit_in_requests_feature_edit_end_time {
    return Intl.message(
      'Edit end time',
      name: 'user_edit_request_cubit_in_requests_feature_edit_end_time',
      desc: '',
      args: [],
    );
  }

  /// `You Have Updated Your Request from`
  String
      get user_edit_request_cubit_in_requests_feature_you_have_updated_your_request_from {
    return Intl.message(
      'You Have Updated Your Request from',
      name:
          'user_edit_request_cubit_in_requests_feature_you_have_updated_your_request_from',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update request`
  String
      get user_edit_request_cubit_in_requests_feature_failed_to_update_request {
    return Intl.message(
      'Failed to update request',
      name:
          'user_edit_request_cubit_in_requests_feature_failed_to_update_request',
      desc: '',
      args: [],
    );
  }

  /// `The operation has been cancelled`
  String
      get user_edit_request_cubit_in_requests_feature_the_operation_has_been_cancelled {
    return Intl.message(
      'The operation has been cancelled',
      name:
          'user_edit_request_cubit_in_requests_feature_the_operation_has_been_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `The start time is after the end time`
  String
      get user_edit_request_cubit_in_requests_feature_the_start_time_is_after_the_end_time {
    return Intl.message(
      'The start time is after the end time',
      name:
          'user_edit_request_cubit_in_requests_feature_the_start_time_is_after_the_end_time',
      desc: '',
      args: [],
    );
  }

  /// `The start time can't be the same as the end time`
  String
      get user_edit_request_cubit_in_requests_feature_the_start_time_cant_be_the_same_as_the_end_time {
    return Intl.message(
      'The start time can\'t be the same as the end time',
      name:
          'user_edit_request_cubit_in_requests_feature_the_start_time_cant_be_the_same_as_the_end_time',
      desc: '',
      args: [],
    );
  }

  /// `There was a conflict with another reservation`
  String
      get user_edit_request_cubit_in_requests_feature_there_was_a_conflict_with_another_reservation {
    return Intl.message(
      'There was a conflict with another reservation',
      name:
          'user_edit_request_cubit_in_requests_feature_there_was_a_conflict_with_another_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try later`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong, please try later',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `You have modified`
  String get you_have_modified {
    return Intl.message(
      'You have modified',
      name: 'you_have_modified',
      desc: '',
      args: [],
    );
  }

  /// `Role to`
  String get role_to {
    return Intl.message(
      'Role to',
      name: 'role_to',
      desc: '',
      args: [],
    );
  }

  /// `Services has been modified to`
  String get services_has_been_modified_to {
    return Intl.message(
      'Services has been modified to',
      name: 'services_has_been_modified_to',
      desc: '',
      args: [],
    );
  }

  /// `Modify permissions`
  String get modify_permissions {
    return Intl.message(
      'Modify permissions',
      name: 'modify_permissions',
      desc: '',
      args: [],
    );
  }

  /// `Modify permissions for`
  String get modify_permissions_for {
    return Intl.message(
      'Modify permissions for',
      name: 'modify_permissions_for',
      desc: '',
      args: [],
    );
  }

  /// `Edit Services`
  String get edit_services {
    return Intl.message(
      'Edit Services',
      name: 'edit_services',
      desc: '',
      args: [],
    );
  }

  /// `Edit Role`
  String get edit_role {
    return Intl.message(
      'Edit Role',
      name: 'edit_role',
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
