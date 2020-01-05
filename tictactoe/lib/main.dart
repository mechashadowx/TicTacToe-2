import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tictactoe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: HomePage(),
    );
  }
}

final black = Color(0xFF000000);
final red = Color(0xFFC33C3C);
final gray = Color(0xFF939393);
final white = Color(0xFFD0D0D0);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int n = 3, m = 3;
  List<List<int>> grid;
  int play = 0;
  bool replay;
  String title = 'TicTacToe';

  @override
  void initState() {
    super.initState();
    grid = List.generate(n, (_) => List(m));
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        grid[i][j] = 0;
      }
    }
    play = 1;
    replay = false;
  }

  win(int winner) {
    if (winner == 1) {
      setState(() {
        this.title = 'BLACK';
      });
    } else {
      setState(() {
        this.title = 'RED';
      });
    }
  }

  draw() {
    setState(() {
      this.title = 'DRAW';
    });
  }

  finish(bool done) {
    setState(() {
      replay = true;
    });
    if (done) {
      win(play);
    } else {
      draw();
    }
  }

  bool check() {
    bool done1 = true;
    bool done2 = true;
    bool done3 = true;
    bool done4 = true;
    for (int i = 0; i < n; i++) {
      done1 = true;
      for (int j = 1; j < m; j++) {
        if (grid[i][j] != grid[i][j - 1] || grid[i][j] == 0) {
          done1 = false;
        }
      }
      if (done1) return true;
    }
    for (int i = 0; i < m; i++) {
      done2 = true;
      for (int j = 1; j < n; j++) {
        if (grid[j][i] != grid[j - 1][i] || grid[j][i] == 0) {
          done2 = false;
        }
      }
      if (done2) return true;
    }
    for (int i = 1; i < n; i++) {
      if (grid[i - 1][i - 1] != grid[i][i] || grid[i][i] == 0) {
        done3 = false;
      }
    }
    for (int i = 1; i < n; i++) {
      if (grid[i][n - i - 1] != grid[i - 1][n - i] || grid[i][n - i - 1] == 0) {
        done4 = false;
      }
    }
    return (done1 || done2 || done3 || done4);
  }

  fill(int x, int y, int p) {
    if (replay || grid[x][y] != 0) return;
    setState(() {
      this.grid[x][y] = p;
    });
    if (check()) {
      finish(true);
      return;
    }
    bool full = true;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        if (grid[i][j] == 0) full = false;
      }
    }
    if (full) {
      finish(false);
      return;
    }
    setState(() {
      this.play = (p == 1 ? 2 : 1);
    });
  }

  Color toColor(int x) {
    if (x == 1)
      return black;
    else if (x == 2)
      return red;
    else
      return white;
  }

  reset() {
    setState(() {
      play = 1;
      replay = false;
      for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
          grid[i][j] = 0;
        }
      }
      this.title = 'TicTacToe';
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: gray,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: data.size.height * 0.3,
              width: data.size.width,
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(data.size.height * 0.05),
                  bottomRight: Radius.circular(data.size.height * 0.05),
                ),
              ),
              child: Center(
                child: Text(
                  this.title,
                  style: TextStyle(
                    color: gray,
                    fontSize: data.size.width * 0.15,
                  ),
                ),
              ),
            ),
            Container(
              height: data.size.height * 0.47,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: data.size.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Cell(
                          border: toColor(grid[0][0]),
                          play: this.play,
                          index: this.grid[0][0],
                          x: 0,
                          y: 0,
                          fill: fill,
                        ),
                        Cell(
                          border: toColor(grid[0][1]),
                          play: this.play,
                          index: this.grid[0][1],
                          x: 0,
                          y: 1,
                          fill: fill,
                        ),
                        Cell(
                          border: toColor(grid[0][2]),
                          play: this.play,
                          index: this.grid[0][2],
                          x: 0,
                          y: 2,
                          fill: fill,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: data.size.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Cell(
                          border: toColor(grid[1][0]),
                          play: this.play,
                          index: this.grid[1][0],
                          x: 1,
                          y: 0,
                          fill: fill,
                        ),
                        Cell(
                          border: toColor(grid[1][1]),
                          play: this.play,
                          index: this.grid[1][1],
                          x: 1,
                          y: 1,
                          fill: fill,
                        ),
                        Cell(
                          border: toColor(grid[1][2]),
                          play: this.play,
                          index: this.grid[1][2],
                          x: 1,
                          y: 2,
                          fill: fill,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: data.size.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Cell(
                          border: toColor(grid[2][0]),
                          play: this.play,
                          index: this.grid[2][0],
                          x: 2,
                          y: 0,
                          fill: fill,
                        ),
                        Cell(
                          border: toColor(grid[2][1]),
                          play: this.play,
                          index: this.grid[2][1],
                          x: 2,
                          y: 1,
                          fill: fill,
                        ),
                        Cell(
                          border: toColor(grid[2][2]),
                          play: this.play,
                          index: this.grid[2][2],
                          x: 2,
                          y: 2,
                          fill: fill,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: this.reset,
              child: Container(
                margin: EdgeInsets.only(bottom: data.size.height * 0.07),
                width: data.size.width * 0.3,
                decoration: BoxDecoration(
                  color: gray,
                  border: Border.all(
                    width: 3,
                    color: red,
                  ),
                  borderRadius: BorderRadius.circular(data.size.width * 0.05),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: black,
                        fontSize: data.size.width * 0.06,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cell extends StatefulWidget {
  final Color border;
  final int play, x, y, index;
  final Function fill;

  Cell({
    this.border,
    this.play,
    this.index,
    this.x,
    this.y,
    this.fill,
  });

  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
  fill() {
    widget.fill(widget.x, widget.y, widget.play);
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return GestureDetector(
      onTap: fill,
      child: Container(
        height: data.size.width * 0.23,
        width: data.size.width * 0.23,
        decoration: BoxDecoration(
          color: gray,
          border: Border.all(
            color: widget.border,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(data.size.width * 0.05),
        ),
        child: Center(
          child: IndexedStack(
            index: widget.index,
            alignment: Alignment.center,
            children: <Widget>[
              Container(),
              Image(
                image: AssetImage('assets/cross.png'),
                height: data.size.width * 0.16,
                width: data.size.width * 0.16,
              ),
              Image(
                image: AssetImage('assets/circle.png'),
                height: data.size.width * 0.16,
                width: data.size.width * 0.16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
