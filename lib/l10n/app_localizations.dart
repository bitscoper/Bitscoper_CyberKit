import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @a_domain_name.
  ///
  /// In en, this message translates to:
  /// **'A Domain Name'**
  String get a_domain_name;

  /// No description provided for @a_host_or_ip_address.
  ///
  /// In en, this message translates to:
  /// **'A Host or IP Address'**
  String get a_host_or_ip_address;

  /// No description provided for @a_multiline_string.
  ///
  /// In en, this message translates to:
  /// **'A Multiline String'**
  String get a_multiline_string;

  /// No description provided for @a_string.
  ///
  /// In en, this message translates to:
  /// **'A String'**
  String get a_string;

  /// No description provided for @abdullah_as_sadeed.
  ///
  /// In en, this message translates to:
  /// **'Abdullah As-Sadeed'**
  String get abdullah_as_sadeed;

  /// No description provided for @automatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get automatic;

  /// No description provided for @available_update.
  ///
  /// In en, this message translates to:
  /// **'Available Update'**
  String get available_update;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @base_encoder.
  ///
  /// In en, this message translates to:
  /// **'Base Encoder'**
  String get base_encoder;

  /// No description provided for @basic_service_set_identifier_bssid.
  ///
  /// In en, this message translates to:
  /// **'Basic Service Set Identifier (BSSID)'**
  String get basic_service_set_identifier_bssid;

  /// No description provided for @bitscoper_cyber_toolbox.
  ///
  /// In en, this message translates to:
  /// **'Bitscoper Cyber ToolBox'**
  String get bitscoper_cyber_toolbox;

  /// No description provided for @broadcast_address.
  ///
  /// In en, this message translates to:
  /// **'Broadcast Address'**
  String get broadcast_address;

  /// No description provided for @calculated.
  ///
  /// In en, this message translates to:
  /// **'Calculated'**
  String get calculated;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Locale to Bangla'**
  String get change_language;

  /// No description provided for @check_version.
  ///
  /// In en, this message translates to:
  /// **'Check Version'**
  String get check_version;

  /// No description provided for @checking_version.
  ///
  /// In en, this message translates to:
  /// **'Checking Version ...'**
  String get checking_version;

  /// No description provided for @circle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get circle;

  /// No description provided for @color_selection.
  ///
  /// In en, this message translates to:
  /// **'Color Selection'**
  String get color_selection;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @copied_to_clipboard.
  ///
  /// In en, this message translates to:
  /// **'has been copied to clipboard.'**
  String get copied_to_clipboard;

  /// No description provided for @crawl.
  ///
  /// In en, this message translates to:
  /// **'Crawl'**
  String get crawl;

  /// No description provided for @crawled.
  ///
  /// In en, this message translates to:
  /// **'Crawled'**
  String get crawled;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @data_module_shape.
  ///
  /// In en, this message translates to:
  /// **'Data Module Shape'**
  String get data_module_shape;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @dns_provider.
  ///
  /// In en, this message translates to:
  /// **'DNS Provider'**
  String get dns_provider;

  /// No description provided for @dns_record.
  ///
  /// In en, this message translates to:
  /// **'DNS record'**
  String get dns_record;

  /// No description provided for @dns_record_retriever.
  ///
  /// In en, this message translates to:
  /// **'DNS Record Retriever'**
  String get dns_record_retriever;

  /// No description provided for @elapsed_time.
  ///
  /// In en, this message translates to:
  /// **'Elapsed Time'**
  String get elapsed_time;

  /// No description provided for @enter_a_domain_name.
  ///
  /// In en, this message translates to:
  /// **'Enter a domain name!'**
  String get enter_a_domain_name;

  /// No description provided for @enter_a_host_or_ip_address.
  ///
  /// In en, this message translates to:
  /// **'Enter a host or IP address!'**
  String get enter_a_host_or_ip_address;

  /// No description provided for @enter_a_lower_limit.
  ///
  /// In en, this message translates to:
  /// **'Enter a Lower Limit!'**
  String get enter_a_lower_limit;

  /// No description provided for @enter_a_number.
  ///
  /// In en, this message translates to:
  /// **'Enter a Number!'**
  String get enter_a_number;

  /// No description provided for @enter_a_positive_integer.
  ///
  /// In en, this message translates to:
  /// **'Enter a Positive Integer!'**
  String get enter_a_positive_integer;

  /// No description provided for @enter_a_positive_number.
  ///
  /// In en, this message translates to:
  /// **'Enter a Positive Number!'**
  String get enter_a_positive_number;

  /// No description provided for @enter_a_string.
  ///
  /// In en, this message translates to:
  /// **'Enter a string!'**
  String get enter_a_string;

  /// No description provided for @enter_a_uri_prefix.
  ///
  /// In en, this message translates to:
  /// **'Enter a URI Prefix!'**
  String get enter_a_uri_prefix;

  /// No description provided for @enter_an_integer.
  ///
  /// In en, this message translates to:
  /// **'Enter an Integer!'**
  String get enter_an_integer;

  /// No description provided for @enter_an_upper_limit.
  ///
  /// In en, this message translates to:
  /// **'Enter an Upper Limit!'**
  String get enter_an_upper_limit;

  /// No description provided for @enter_morse_code.
  ///
  /// In en, this message translates to:
  /// **'Enter morse code!'**
  String get enter_morse_code;

  /// No description provided for @enter_padding.
  ///
  /// In en, this message translates to:
  /// **'Enter Padding!'**
  String get enter_padding;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @error_correction_level.
  ///
  /// In en, this message translates to:
  /// **'Error Correction Level'**
  String get error_correction_level;

  /// No description provided for @extract.
  ///
  /// In en, this message translates to:
  /// **'Extract'**
  String get extract;

  /// No description provided for @extracted.
  ///
  /// In en, this message translates to:
  /// **'Extracted'**
  String get extracted;

  /// No description provided for @eye.
  ///
  /// In en, this message translates to:
  /// **'Eye'**
  String get eye;

  /// No description provided for @eye_shape.
  ///
  /// In en, this message translates to:
  /// **'Eye Shape'**
  String get eye_shape;

  /// No description provided for @false_.
  ///
  /// In en, this message translates to:
  /// **'False'**
  String get false_;

  /// No description provided for @file_hash_calculator.
  ///
  /// In en, this message translates to:
  /// **'File Hash Calculator'**
  String get file_hash_calculator;

  /// No description provided for @gapless.
  ///
  /// In en, this message translates to:
  /// **'Gapless'**
  String get gapless;

  /// No description provided for @gateway.
  ///
  /// In en, this message translates to:
  /// **'Gateway'**
  String get gateway;

  /// No description provided for @google_play.
  ///
  /// In en, this message translates to:
  /// **'Google Play'**
  String get google_play;

  /// No description provided for @hash.
  ///
  /// In en, this message translates to:
  /// **'hash'**
  String get hash;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @internet_protocol_version_4_ipv4_address.
  ///
  /// In en, this message translates to:
  /// **'Internet Protocol Version 4 (IPv4) Address'**
  String get internet_protocol_version_4_ipv4_address;

  /// No description provided for @internet_protocol_version_6_ipv6_address.
  ///
  /// In en, this message translates to:
  /// **'Internet Protocol Version 6 (IPv6) Address'**
  String get internet_protocol_version_6_ipv6_address;

  /// No description provided for @it_takes_time_to_retrieve_all_possible_types_of_forward_and_reverse_records.
  ///
  /// In en, this message translates to:
  /// **'It takes time to retrieve all possible types of forward and reverse records.'**
  String
  get it_takes_time_to_retrieve_all_possible_types_of_forward_and_reverse_records;

  /// No description provided for @latest_version.
  ///
  /// In en, this message translates to:
  /// **'Latest Version'**
  String get latest_version;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @lower_limit.
  ///
  /// In en, this message translates to:
  /// **'Lower Limit'**
  String get lower_limit;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @microsoft_store.
  ///
  /// In en, this message translates to:
  /// **'Microsoft Store'**
  String get microsoft_store;

  /// No description provided for @morse_code.
  ///
  /// In en, this message translates to:
  /// **'Morse Code'**
  String get morse_code;

  /// No description provided for @morse_code_translator.
  ///
  /// In en, this message translates to:
  /// **'Morse Code Translator'**
  String get morse_code_translator;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @open_graph_protocol_data_extractor.
  ///
  /// In en, this message translates to:
  /// **'Open Graph Protocol Data Extractor'**
  String get open_graph_protocol_data_extractor;

  /// No description provided for @padding.
  ///
  /// In en, this message translates to:
  /// **'Padding'**
  String get padding;

  /// No description provided for @ping.
  ///
  /// In en, this message translates to:
  /// **'Ping'**
  String get ping;

  /// No description provided for @pinger.
  ///
  /// In en, this message translates to:
  /// **'Pinger'**
  String get pinger;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @qr_code_generator.
  ///
  /// In en, this message translates to:
  /// **'QR Code Generator'**
  String get qr_code_generator;

  /// No description provided for @quartile.
  ///
  /// In en, this message translates to:
  /// **'Quartile'**
  String get quartile;

  /// No description provided for @records.
  ///
  /// In en, this message translates to:
  /// **'records'**
  String get records;

  /// No description provided for @retrieve.
  ///
  /// In en, this message translates to:
  /// **'Retrieve'**
  String get retrieve;

  /// No description provided for @retrieved.
  ///
  /// In en, this message translates to:
  /// **'Retrieved'**
  String get retrieved;

  /// No description provided for @retrieving.
  ///
  /// In en, this message translates to:
  /// **'Retrieving'**
  String get retrieving;

  /// No description provided for @route_tracer.
  ///
  /// In en, this message translates to:
  /// **'Route Tracer'**
  String get route_tracer;

  /// No description provided for @route_tracer_apology.
  ///
  /// In en, this message translates to:
  /// **'Apologies, Route Tracer is currently unavailable due to build errors.'**
  String get route_tracer_apology;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @scanned.
  ///
  /// In en, this message translates to:
  /// **'Scanned'**
  String get scanned;

  /// No description provided for @scanned_ports.
  ///
  /// In en, this message translates to:
  /// **'Scanned Ports'**
  String get scanned_ports;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @select_files.
  ///
  /// In en, this message translates to:
  /// **'Select Files'**
  String get select_files;

  /// No description provided for @select_files_to_calculate_their_md5_sha1_sha224_sha256_sha384_sha512_hashes.
  ///
  /// In en, this message translates to:
  /// **'Select files to calculate their MD5, SHA1, SHA224, SHA256, SHA384, and SHA512 hashes.'**
  String
  get select_files_to_calculate_their_md5_sha1_sha224_sha256_sha384_sha512_hashes;

  /// No description provided for @series_uri_crawler.
  ///
  /// In en, this message translates to:
  /// **'Series URI Crawler'**
  String get series_uri_crawler;

  /// No description provided for @service_set_identifier_ssid.
  ///
  /// In en, this message translates to:
  /// **'Service Set Identifier (SSID)'**
  String get service_set_identifier_ssid;

  /// No description provided for @source_code.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get source_code;

  /// No description provided for @square.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get square;

  /// No description provided for @start_typing_a_string_to_calculate_its_md5_sha1_sha224_sha256_sha384_sha512_hashes.
  ///
  /// In en, this message translates to:
  /// **'Start typing a string to calculate its MD5, SHA1, SHA224, SHA256, SHA384, and SHA512 hashes.'**
  String
  get start_typing_a_string_to_calculate_its_md5_sha1_sha224_sha256_sha384_sha512_hashes;

  /// No description provided for @start_typing_a_string_to_encode_it_into_the_bases.
  ///
  /// In en, this message translates to:
  /// **'Start typing a string to encode it to into the bases.'**
  String get start_typing_a_string_to_encode_it_into_the_bases;

  /// No description provided for @start_typing_a_string_to_generate_qr_code.
  ///
  /// In en, this message translates to:
  /// **'Start typing a string to generate QR Code.'**
  String get start_typing_a_string_to_generate_qr_code;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @string_hash_calculator.
  ///
  /// In en, this message translates to:
  /// **'String Hash Calculator'**
  String get string_hash_calculator;

  /// No description provided for @subnet_mask.
  ///
  /// In en, this message translates to:
  /// **'Subnet Mask'**
  String get subnet_mask;

  /// No description provided for @tcp_port_scanner.
  ///
  /// In en, this message translates to:
  /// **'TCP Port Scanner'**
  String get tcp_port_scanner;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @toggle_theme.
  ///
  /// In en, this message translates to:
  /// **'Toggle Theme'**
  String get toggle_theme;

  /// No description provided for @true_.
  ///
  /// In en, this message translates to:
  /// **'True'**
  String get true_;

  /// No description provided for @ttl.
  ///
  /// In en, this message translates to:
  /// **'TTL'**
  String get ttl;

  /// No description provided for @up_to_date.
  ///
  /// In en, this message translates to:
  /// **'Up to Date'**
  String get up_to_date;

  /// No description provided for @upper_limit.
  ///
  /// In en, this message translates to:
  /// **'Upper Limit'**
  String get upper_limit;

  /// No description provided for @upper_limit_must_be_greater_than_lower_limit.
  ///
  /// In en, this message translates to:
  /// **'Upper limit must be greater than lower limit!'**
  String get upper_limit_must_be_greater_than_lower_limit;

  /// No description provided for @uri.
  ///
  /// In en, this message translates to:
  /// **'URI'**
  String get uri;

  /// No description provided for @uri_prefix.
  ///
  /// In en, this message translates to:
  /// **'URI Prefix'**
  String get uri_prefix;

  /// No description provided for @uri_suffix.
  ///
  /// In en, this message translates to:
  /// **'URI Suffix'**
  String get uri_suffix;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @wait.
  ///
  /// In en, this message translates to:
  /// **'Wait'**
  String get wait;

  /// No description provided for @whois_retriever.
  ///
  /// In en, this message translates to:
  /// **'WHOIS Retriever'**
  String get whois_retriever;

  /// No description provided for @wifi_information_viewer.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Information Viewer'**
  String get wifi_information_viewer;

  /// No description provided for @wifi_is_disconnected.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi is disconnected!'**
  String get wifi_is_disconnected;

  /// No description provided for @you_are_using_the_latest_version.
  ///
  /// In en, this message translates to:
  /// **'You are using the latest version.'**
  String get you_are_using_the_latest_version;

  /// No description provided for @your_version.
  ///
  /// In en, this message translates to:
  /// **'Your Version'**
  String get your_version;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
