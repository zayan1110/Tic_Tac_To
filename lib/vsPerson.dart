import 'package:flutter/material.dart';

class VsPerson extends StatefulWidget {
  const VsPerson({super.key});

  @override
  State<VsPerson> createState() => _VsPersonState();
}

class _VsPersonState extends State<VsPerson> {
  bool _ohTurn = true;
  List<String> _displayExOh = List.generate(9, (_) => '');
  final _myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);
  int _exScore = 0;
  int _ohScore = 0;
  int _filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Center(
          child: Text('Tic Tac Toe',
              style: TextStyle(color: Colors.white, fontSize: 30)),
        ),
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        children: [
          Expanded(child: _scoreBoard()),
          Expanded(flex: 3, child: _gameBoard()),
          Expanded(child: _resetButton()),
        ],
      ),
    );
  }

  Widget _scoreBoard() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _playerScore('Player x', _exScore),
          _playerScore('Player o', _ohScore),
        ],
      ),
    );
  }

  Widget _playerScore(String title, int score) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: _myTextStyle),
          Text(score.toString(), style: _myTextStyle),
        ],
      ),
    );
  }

  Widget _gameBoard() {
    return GridView.builder(
      itemCount: 9,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (_, index) => GestureDetector(
        onTap: () => _tabbed(index),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 141, 141, 141)),
          ),
          child: Center(
            child: Text(_displayExOh[index],
                style: const TextStyle(color: Colors.white, fontSize: 40)),
          ),
        ),
      ),
    );
  }

  Widget _resetButton() {
    return Container(
      child: Column(
        children: [
          const Text('Tic Tac Toe',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 162, 162, 162))),
          ElevatedButton(
              onPressed: _resetGame, child: const Icon(Icons.restart_alt)),
        ],
      ),
    );
  }

  void _tabbed(int index) {
    if (_displayExOh[index].isEmpty) {
      setState(() {
        _displayExOh[index] = _ohTurn ? 'o' : 'x';
        _filledBoxes++;
        _ohTurn = !_ohTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    final winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final combo in winningCombinations) {
      final value = _displayExOh[combo[0]];
      if (value.isNotEmpty &&
          value == _displayExOh[combo[1]] &&
          value == _displayExOh[combo[2]]) {
        _showWinDialog(value);
        return;
      }
    }

    if (_filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('WINNER IS $winner'),
        actions: [
          ElevatedButton(
            child: const Text('Play again'),
            onPressed: () {
              _clearBoard();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
    if (winner == 'x') {
      _exScore++;
    } else if (winner == 'o') {
      _ohScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Draw'),
        actions: [
          ElevatedButton(
            child: const Text('Play again'),
            onPressed: () {
              _clearBoard();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void _clearBoard() {
    setState(() {
      _displayExOh = List.generate(9, (_) => '');
      _filledBoxes = 0;
    });
  }

  void _resetGame() {
    setState(() {
      _exScore = 0;
      _ohScore = 0;
      _clearBoard();
      _ohTurn = true;
    });
  }
}
