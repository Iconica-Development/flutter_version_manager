// import "package:example/firebase_options.dart";
// import "package:firebase_core/firebase_core.dart";
import "package:firebase_version_repository/firebase_version_repository.dart";
import "package:flutter/material.dart";
import "package:flutter_version_manager/flutter_version_manager.dart";

void main() async {
  // await Firebase.initializeApp(
  // options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  /// The main application widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      );
}

/// The home page of the application.
class MyHomePage extends StatefulWidget {
  /// The home page of the application.
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // VersionRepositoryInterface versionRepositoryInterface =
  //     FirebaseVersionRepository();
  VersionRepositoryInterface versionRepositoryInterface =
      LocalVersionRepository();
  late VersionRepositoryService service;
  String? version;

  @override
  void initState() {
    super.initState();
    service = VersionRepositoryService(
      versionRepositoryInterface: versionRepositoryInterface,
    );

    Future.delayed(Duration.zero, () async {
      version = (await service.getCurrentBackendVersion()).toString();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => FlutterVersionManager(
        service: service,
        backendLeading: true,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Flutter version manager"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Current version: $version"),
              ],
            ),
          ),
        ),
      );
}
