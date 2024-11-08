import 'package:flutter/material.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';
import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [
      SampleItem(1, 'https://youtu.be/6EMx1gF56xE?si=VjbE2yDkWwVjbadI', 'assets/images/apadrinhamento1.png'), 
      SampleItem(2, 'https://youtu.be/wZT5BEyTMKg?si=GtVIIStzCuUZvpvu', 'assets/images/apadrinhamento2.png'), 
      SampleItem(3, 'https://youtu.be/dwSWGYZ-HVw?si=ldc1kYUemqvzVSTg', 'assets/images/apadrinhamento3.png'), 
      SampleItem(4, 'https://youtu.be/_qv-tuxN7Z4?si=njW0P8tEG1bHs1FA', 'assets/images/apadrinhamento4.png'),
    ],
  });

  static const routeName = '/';

  final List<SampleItem> items;

  Future<void> _precacheImages(BuildContext context) async {
    for (var item in items) {
      await precacheImage(AssetImage(item.imagePath), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Chama o método para pré-carregar as imagens quando a tela é construída
    _precacheImages(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apadrinhamento'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return GestureDetector(
            onTap: () {
              // Navega para a tela de detalhes passando a URL do vídeo
              Navigator.restorablePushNamed(
                context,
                SampleItemDetailsView.routeName,
                arguments: item.videoUrl,
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item.imagePath), // Usa a imagem específica do item
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: 200, // Defina a altura do botão conforme necessário
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: const SizedBox.expand(), // Isso garante que o botão ocupe todo o espaço
              ),
            ),
          );
        },
      ),
    );
  }
}