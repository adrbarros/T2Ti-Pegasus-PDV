import 'package:flutter/material.dart';

import 'package:pegasus_pdv/src/view/page/page.dart';

class ConfiguracaoPage extends StatefulWidget {
  const ConfiguracaoPage({Key? key}) : super(key: key);

  @override
  ConfiguracaoPageState createState() => ConfiguracaoPageState();
}

class ConfiguracaoPageState extends State<ConfiguracaoPage> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
  
  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              color: Colors.blueGrey, 
              child: const ConfiguracaoAbaGeral(),
            ),
            Container(
              color: Colors.red, 
              child: const ConfiguracaoAbaNfce(),
            ),
            Container(
              color: Colors.green, 
              child: const ConfiguracaoAbaCadastro(title: 'Configurações do SAT', modulo: 'SAT'),
            ),
            Container(
              color: Colors.blue, 
              child: const ConfiguracaoAbaCadastro(title: 'Configurações do MFE', modulo: 'MFE'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Geral',
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: 'NFC-e',
            icon: Icon(Icons.description_outlined),
          ),
          BottomNavigationBarItem(
            label: 'SAT',
            icon: Icon(Icons.print_outlined),
          ),
          BottomNavigationBarItem(
            label: 'MFE',
            icon: Icon(Icons.scanner_outlined),
          ),
        ],
      ),
    );
  }
}
