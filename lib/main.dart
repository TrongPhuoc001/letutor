import 'package:flutter/material.dart';
import 'package:lettutor/ui/my_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://f08bb1317e234ea9b5f6cd3f06646f8f@o4504444665724928.ingest.sentry.io/4504444667953152';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );
}
