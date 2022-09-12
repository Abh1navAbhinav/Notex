import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notex/notex_model/note_model.dart';
import 'package:notex/screens/home.dart';

var isEditing = true.obs;
var isViewing = true.obs;
var title = 'Title'.obs;

const noteDbName = 'Note-db';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(NoteModelAdapter().typeId)) {
    Hive.registerAdapter(NoteModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromARGB(255, 27, 88, 83),
            ),
      ),
      home:   HomeScreen(),
    );
  }
}
