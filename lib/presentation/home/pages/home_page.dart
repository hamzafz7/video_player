import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioPath;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _pickVideoAndExtractAudio() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.single.path != null) {
        String videoPath = result.files.single.path!;
        String outputPath = await _getOutputPath();

        // Extract audio using ffmpeg
        final shell = Shell();
        await shell.run('''
          ffmpeg -i "$videoPath" -q:a 0 -map a "$outputPath/audio.mp3"
        ''');

        setState(() {
          _audioPath = '$outputPath/audio.mp3';
        });

        // Play the extracted audio
        if (_audioPath != null) { 
      
          _audioPlayer.play(DeviceFileSource(_audioPath!));
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String> _getOutputPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _audioPath == null
            ? Text('No audio extracted')
            : Text('Playing extracted audio...'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickVideoAndExtractAudio,
        child: Icon(Icons.audiotrack),
      ),
    );
  }
}
