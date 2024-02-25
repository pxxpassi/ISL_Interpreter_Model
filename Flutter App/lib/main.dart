import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sign_ease/homepage.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  print(cameras);
  runApp(CameraBox(cameras: cameras));
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key, required cameras}) : super(key: key);
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  void _navigateToHomePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      _navigateToHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 60, right: 40, top: 30),
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Text(
                        'SIGNEASE',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 35, right: 35),
              padding: const EdgeInsets.only(left: 80, top: 400),
              child: const Text(
                'welcome back!',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/////////////home screen////////////////////////////////////////////////////////////////

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();

}

class HomePageState extends State<HomePage> {

  void _navigateToCamPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const CameraScreen(cameras: []);
        },
      ),
    );
  }
  void _navigateToDeveloper() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const Developer();
        },
      ),
    );
  }
  void _navigateToHelp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const Help();
        },
      ),
    );
  }
  void _navigateToLearnPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const LearnPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/page.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'SignEase',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Hello, there!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
              ),
              ListTile(
                title: const Text('Learn to Sign'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LearnPage()));
                },
              ),
              ListTile(
                title: const Text('About Us'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LearnPage()));
                },
              ),
              // Add more ListTile widgets for additional menu items
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 300),
              ElevatedButton(
                onPressed: _navigateToCamPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(300, 100),
                ),
                child: const Text('Open Camera'),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _navigateToLearnPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(300, 100),
                ),
                child: const Text('Learn To Sign'),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _navigateToDeveloper,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(50, 50),
                    ),
                    child: const Text('Developer'),
                  ),
                  ElevatedButton(
                    onPressed: _navigateToHelp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(50, 50),
                    ),
                    child: const Text('Need Help?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}

///////////////////CAM PAGE//////////////////////////////////////////////

class CameraBox extends StatelessWidget {
  final List<CameraDescription> cameras;

  const CameraBox({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(cameras: cameras),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({Key? key, required this.cameras}) : super(key: key);
  @override
  State<CameraScreen> createState() => _CameraScreenState();

}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraDescription camera;
  late CameraController cameraController;
  late Future<void> initializeController;

  Future<void> getCameras() async {
    try {
      cameras = await availableCameras();
    } catch (e) {
      print(e);
    }
    if (cameras.isNotEmpty) {
      camera = cameras.first;
    } else {
      // Handle the case when no cameras are available
      print("No cameras available");
    }
  }

  @override
  void initState() {
    super.initState();
    // Uncomment the line below if you want to get the list of available cameras
    getCameras();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.isNotEmpty) {
        camera = cameras.first;
        cameraController = CameraController(
          camera,
          ResolutionPreset.low,
        );
        initializeController = cameraController.initialize();
        // The print statement below might not give the expected result
        // since the initialization might not be completed at this point.
        print(cameraController.value.isInitialized);
      } else {
        // Handle the case when no cameras are available
        print("No cameras available");
      }
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  void _toggleCamera() async {
    await cameraController.dispose();
    setState(() {
      // Get the index of the current camera in the list
      int currentIndex = cameras.indexOf(camera);

      // Toggle between the front and back cameras
      int nextIndex = (currentIndex + 1) % cameras.length;
      camera = cameras[nextIndex];

      cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
      );
      initializeController = cameraController.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FutureBuilder<void>(
            future: initializeController,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (cameraController != null && cameraController.value.isInitialized) {
                  // If the Future is complete and camera is initialized, display the preview.
                  return CameraPreview(cameraController);
                } else {
                  // Handle the case when the camera is not initialized properly
                  return const Center(child: Text("Error initializing camera"));
                }
              } else {
                // Otherwise, display a loading indicator.
                print(snapshot.connectionState);
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    await initializeController;
                    final tempDir = await getTemporaryDirectory();
                    final path = '${tempDir.path}/${DateTime.now()}.png';
                    await cameraController.takePicture();
                    SnackBar snackBar = SnackBar(
                      content: Text('Picture saved to $path'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(50, 50),
                ),
                child: const Icon(Icons.camera_alt),
              ),
              ElevatedButton(
                onPressed: _toggleCamera,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(50, 50),
                ),
                child: const Icon(Icons.switch_camera),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


////////////////////////LEARN ISL PAGE////////////////////////////////////
class LearnISL extends StatefulWidget {
  const LearnISL({Key? key}) : super(key: key);

  @override
  LearnISLState createState() => LearnISLState();
}

class LearnISLState extends State<LearnISL> {
  final List<Flashcard1> flashcards = List.generate(
    26,
        (index) => Flashcard1(
      question: String.fromCharCode('A'.codeUnitAt(0) + index),
      answer: 'Answer ${index + 1}',
      imagePath: 'assets/ISL/${index + 1}.png', // Assuming you have images named 1.png, 2.png, etc.
    ),
  );

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ISL Language',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flashcard1Widget(flashcard: flashcards[currentIndex]),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: showBackFlashcard, // Add this line
                  child: const Text('Previous'), // Add this line
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: showNextFlashcard,
                  child: const Text('Next'),
                ),
              ],
            ),
          ]
      ),
    );

  }
  void showBackFlashcard() {
    setState(() {
      currentIndex = (currentIndex - 1) % flashcards.length;
    });
    if (currentIndex < 0) {
      currentIndex = flashcards.length - 1;
    }}
  void showNextFlashcard() {
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards.length;
    });
  }
/*void showAnswer() {
    final currentFlashcard = flashcards[currentIndex];
    final snackBar = SnackBar(
      content: Text('Answer: ${currentFlashcard.answer}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }*/
}

class Flashcard1 {
  final String question;
  final String answer;
  final String imagePath;

  Flashcard1({required this.question,required this.answer, required this.imagePath});
}

class Flashcard1Widget extends StatelessWidget {
  final Flashcard1 flashcard;

  const Flashcard1Widget({super.key, required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: 350, // Adjust the desired width
              height: 350, // Adjust the desired height
              child: Image.asset(
                flashcard.imagePath, // Use the image path from the Flashcard
                fit: BoxFit.cover, // Use BoxFit to fill the available space
              ),
            ),
            const SizedBox(height: 20), // Add more spacing between image and text
            Text(
              "Translation for Sign:\n${flashcard.question}",
              style: const TextStyle(fontSize: 24), // Increase the font size as needed
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////LEARN ASL PAGE//////////////////////////////////
class LearnASL extends StatefulWidget {
  const LearnASL({Key? key}) : super(key: key);

  @override
  LearnASLState createState() => LearnASLState();
}

class LearnASLState extends State<LearnASL> {
  final List<Flashcard1> flashcards = List.generate(
    26,
        (index) => Flashcard1(
      question: String.fromCharCode('A'.codeUnitAt(0) + index),
      answer: 'Answer ${index + 1}',
      imagePath: 'assets/ASL/${index + 1}.png', // Assuming you have images named 1.png, 2.png, etc.
    ),
  );

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ISL Language',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flashcard2Widget(flashcard: flashcards[currentIndex]),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: showBackFlashcard, // Add this line
                  child: const Text('Previous'), // Add this line
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: showNextFlashcard,
                  child: const Text('Next'),
                ),
              ],
            ),
          ]
      ),
    );

  }
  void showBackFlashcard() {
    setState(() {
      currentIndex = (currentIndex - 1) % flashcards.length;
    });
    if (currentIndex < 0) {
      currentIndex = flashcards.length - 1;
    }}
  void showNextFlashcard() {
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards.length;
    });
  }
/*void showAnswer() {
    final currentFlashcard = flashcards[currentIndex];
    final snackBar = SnackBar(
      content: Text('Answer: ${currentFlashcard.answer}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }*/
}

class Flashcard2 {
  final String question;
  final String answer;
  final String imagePath;

  Flashcard2({required this.question,required this.answer, required this.imagePath});
}

class Flashcard2Widget extends StatelessWidget {
  final Flashcard1 flashcard;

  const Flashcard2Widget({super.key, required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: 350, // Adjust the desired width
              height: 350, // Adjust the desired height
              child: Image.asset(
                flashcard.imagePath, // Use the image path from the Flashcard
                fit: BoxFit.cover, // Use BoxFit to fill the available space
              ),
            ),
            const SizedBox(height: 20), // Add more spacing between image and text
            Text(
              "Translation for Sign:\n${flashcard.question}",
              style: const TextStyle(fontSize: 24), // Increase the font size as needed
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////TEST////////////////////////////////////////

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  TestState createState() => TestState();
}

class TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container (
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Camera - Test',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
        ),
      ),
    );
  }
}

class Developer extends StatefulWidget {
  const Developer({Key? key}) : super(key: key);

  @override
  DevState createState() => DevState();
}

class DevState extends State<Developer> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController textBlockController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/dev.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Contribute',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: textBlockController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Issue/ Queries/ Why contribute?'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()
                {
                  // Access the entered values
                  String name = nameController.text;
                  String email = emailController.text;
                  String textBlock = textBlockController.text;

                  // Now you can use these values as needed
                  print('Name: $name, Email: $email, Text Block: $textBlock');
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Instructions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
        ),
      ),
    );
  }
}
