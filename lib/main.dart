import 'dart:math';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Shortener',
      home: ShortenUrlScreen(),
    );
  }
}

class ShortenUrlScreen extends StatefulWidget {
  @override
  _ShortenUrlScreenState createState() => _ShortenUrlScreenState();
}

class _ShortenUrlScreenState extends State<ShortenUrlScreen> {
  final TextEditingController _urlController = TextEditingController();
  final String baseUrl = 'https://your-base-url.com'; // Replace with your base URL
  String originalUrl = '';
  String shortenedUrl = '';

  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  void _shortenUrl() {
    // Logic to generate a random string as the shortened URL
    String inputUrl = _urlController.text;
    String randomString = _generateRandomString(8); // Adjust the length as needed
    // Replace this logic with your actual URL shortening implementation
    // For simplicity, we're just appending the random string to the base URL here.
    String newShortenedUrl = '$baseUrl/$randomString';

    // Update the state to display the URLs in the container
    setState(() {
      originalUrl = inputUrl;
      shortenedUrl = newShortenedUrl;
    });

    // Clear the input field
    _urlController.clear();
  }

  void _copyToClipboard() {
    FlutterClipboard.copy(shortenedUrl)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('URL copied to clipboard')),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('URL Shortener'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'Enter URL'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _shortenUrl();
              },
              child: Text('Shorten URL'),
            ),
            SizedBox(height: 16),
            if (originalUrl.isNotEmpty && shortenedUrl.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Original URL: $originalUrl'),
                    SizedBox(height: 8),
                    Text('Shortened URL: $shortenedUrl'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _copyToClipboard,
                      child: Text('Copy to Clipboard'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
