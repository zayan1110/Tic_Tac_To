import 'dart:math';
import 'package:flutter/material.dart';

class VsComputer extends StatefulWidget {
  const VsComputer({super.key});

  @override
  State<VsComputer> createState() => _VsComputerState();
}

class _VsComputerState extends State<VsComputer> {
  bool ohTurn = true;
  List<String> displayExOh = List.generate(9, (_) => '');
  final myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);
  int exScore = 0, ohScore = 0, filledBoxes = 0;

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
          _playerScore('Player x', exScore),
          _playerScore('Computer o', ohScore),
        ],
      ),
    );
  }

  Widget _playerScore(String name, int score) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: myTextStyle),
          Text(score.toString(), style: myTextStyle),
        ],
      ),
    );
  }

  Widget _gameBoard() {
    return GridView.builder(
      itemCount: 9,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => _tabbed(index),
        child: _gameCell(index),
      ),
    );
  }

  Widget _gameCell(int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 141, 141, 141)),
      ),
      child: Center(
        child: Text(
          displayExOh[index],
          style: const TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
    );
  }

  Widget _resetButton() {
    return Container(
      child: Column(
        children: [
          const Text(
            'Tic Tac Toe',
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 162, 162, 162)),
          ),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Icon(Icons.restart_alt),
          ),
        ],
      ),
    );
  }

  void _tabbed(int index) {
    if (displayExOh[index].isEmpty) {
      setState(() {
        displayExOh[index] = 'x';
        filledBoxes++;
      });
      _checkWinner();
      if (filledBoxes < 9) {
        _computerMove();
      }
    }
  }

  void _computerMove() {
    final availableMoves = <int>[];
    for (int i = 0; i < 9; i++) {
      if (displayExOh[i].isEmpty) {
        availableMoves.add(i);
      }
    }
    final computerIndex =
        availableMoves[Random().nextInt(availableMoves.length)];
    setState(() {
      displayExOh[computerIndex] = 'o';
      filledBoxes++;
    });
    _checkWinner();
  }

  void _checkWinner() {
    final winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (final positions in winningPositions) {
      final symbol = displayExOh[positions[0]];
      if (symbol.isNotEmpty &&
          symbol == displayExOh[positions[1]] &&
          symbol == displayExOh[positions[2]]) {
        _showWinDialog(symbol);
        return;
      }
    }
    if (filledBoxes == 9) {
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
            onPressed: _clearBoard,
          ),
        ],
      ),
    );
    if (winner == 'x') {
      exScore++;
    } else {
      ohScore++;
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
            onPressed: _clearBoard,
          ),
        ],
      ),
    );
  }

  void _clearBoard() {
    setState(() {
      displayExOh = List.generate(9, (_) => '');
      filledBoxes = 0;
    });
    Navigator.of(context).pop();
  }

  void _resetGame() {
    setState(() {
      exScore = 0;
      ohScore = 0;
      displayExOh = List.generate(9, (_) => '');
      filledBoxes = 0;
      ohTurn = true;
    });
  }
}
