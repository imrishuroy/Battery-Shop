import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';
  const AboutScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => AboutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Text(
                'Disclaimer',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                _disclaimer,
                style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                'Contact',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 17.0),
                  children: [
                    TextSpan(text: 'Ph - '),
                    TextSpan(
                      text: '9035797534',
                      style: TextStyle(color: Colors.red),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launch('tel://9035797534'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 17.0),
                  children: [
                    const TextSpan(text: 'Gmail - '),
                    TextSpan(
                      text: 'textfawaz@gmail.com',
                      style: TextStyle(color: Colors.red),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launch('mailto:textfawaz@gmail.com'),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 5.0),
              // Text('Gmail - textfawaz@gmail.com'),
              const SizedBox(height: 24.0),
              Center(
                child: Text(
                  'Made with ❤️ by sixteenbrains.com',
                  style: TextStyle(
                    fontSize: 12.0,
                    letterSpacing: 1.2,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 2.0),
              Center(
                child: Text(
                  'version 1.0.0',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}

const String _disclaimer =
    'Battery dealers is app, owned and operated by Fawaz for all kind spare parts and do not own or control any car make or spare parts brand.\n\nAll Car Make, Marque, Model, Submodel, Modification, Variants names are respective trademarks of OEM\'s (“Original Equipment Manufacturer”) and this battery dealer app has no relation to them.\n\nNeither endorses any aftermarket or replacement car parts nor claims any such part as genuine or OEM authorised. The app is the facilitator for all kind of spare parts sales and not acting on behalf of the OEM and/or supplier.\n\nAll car images, logos on this site are the property of their respective owners. We do not hold any copyright in regards to these pictures . These pictures have been collected from different public sources including various websites, considered to be in public domain. If any one has any objection to display of any picture, image or text it may be brought to our notice by sending an email (contact us) and the disputed media will be be removed immediately, after verification of the claim.\n\nIts App offers to customer goods of relevant pages randomly, sorted or filtered by customer’s choice. goods are intentionally prioritised in search results it is stated clearly. It is on the sole discretion of the user to decide and opt for any kind of goods.';
