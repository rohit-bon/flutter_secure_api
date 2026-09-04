import 'package:flutter/material.dart';
import 'package:flutter_secure_api/flutter_secure_api.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Secure API Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SecureApiClient api;

  String message = 'No request made';

  @override
  void initState() {
    super.initState();

    api = SecureApiClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    );
  }

  Future<void> makeRequest() async {
    try {
      final response = await api.get('/users/1');

      setState(() {
        message = response.data.toString();
      });
    } on ApiException catch (error) {
      setState(() {
        message = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Secure API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: makeRequest,
              child: const Text('Make API Request'),
            ),
            const SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}