import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatefulWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  State<SampleItemDetailsView> createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final String videoUrl = ModalRoute.of(context)!.settings.arguments as String;
    final String videoId = YoutubePlayer.convertUrlToId(videoUrl)!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    // Adiciona listener ao controller
    _controller.addListener(() {
      if (_controller.value.isFullScreen) {
        setState(() {
          _isFullScreen = true; // Atualiza a visibilidade da AppBar
        });
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
      } else {
        setState(() {
          _isFullScreen = false; // Restaura a visibilidade da AppBar
        });
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Limpa o controller quando não for mais necessário
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen ? null : AppBar( // Oculta a AppBar em fullscreen
        title: const Text('Apadrinhamento'),
      ),
      body: Column(
        children: [
          Expanded( 
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    player,
                    const SizedBox(height: 20),
                    const Text(''),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
