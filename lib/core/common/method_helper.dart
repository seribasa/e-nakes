import 'package:url_launcher/url_launcher.dart';

Future<void> navigateGoogleMapTo(String nameLocation) async {
  // final Uri uri = Uri.parse('https://flutter.dev');

  final url = 'https://www.google.com/maps/search/?api=1&query=$nameLocation';
  var uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch ${uri.toString()}';
  }
}
