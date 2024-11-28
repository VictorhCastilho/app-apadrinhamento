import 'package:flutter/material.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';
import '../settings/settings_view.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Displays a list of SampleItems.
///
class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mais Informações'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(url), // Convert the string to a WebUri object
        ),
        onLoadStart: (controller, url) {
          // Lógica ao iniciar o carregamento, se necessário
        },
        onLoadStop: (controller, url) {
          // Lógica ao finalizar o carregamento, se necessário
        },
      ),
    );
  }
}

class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [
      SampleItem(1, 'https://youtu.be/6EMx1gF56xE?si=VjbE2yDkWwVjbadI',
          'assets/images/apadrinhamento1.png'),
      SampleItem(2, 'https://youtu.be/wZT5BEyTMKg?si=GtVIIStzCuUZvpvu',
          'assets/images/apadrinhamento2.png'),
      SampleItem(3, 'https://youtu.be/dwSWGYZ-HVw?si=ldc1kYUemqvzVSTg',
          'assets/images/apadrinhamento3.png'),
      SampleItem(4, 'https://youtu.be/_qv-tuxN7Z4?si=njW0P8tEG1bHs1FA',
          'assets/images/apadrinhamento4.png'),
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
        title: Padding(
          padding: const EdgeInsets.only(
              left: 100.0), // Ajuste o valor conforme necessário
          child: const Text('Apadrinhamento'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Grid de itens
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de colunas
                crossAxisSpacing: 8.0, // Espaçamento horizontal
                mainAxisSpacing: 8.0, // Espaçamento vertical
                childAspectRatio: 1, // Proporção largura/altura
              ),
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
                        image: AssetImage(
                            item.imagePath), // Usa a imagem específica do item
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: 200, // Defina a altura do botão conforme necessário
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: const SizedBox
                          .expand(), // Isso garante que o botão ocupe todo o espaço
                    ),
                  ),
                );
              },
            ),
          ),

          // Novo botão centralizado na parte inferior
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final url = 'https://www.aaci.org.br/apadrinhamento-3';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewScreen(url: url)),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Mais Informações 💬',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
