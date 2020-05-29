import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MaterialApp(
    home: CoinApp(),
  ));
}

class CoinApp extends StatefulWidget {
  @override
  _CoinAppState createState() => _CoinAppState();
}

class _CoinAppState extends State<CoinApp> {
  TextEditingController _controller = TextEditingController();
  int noteNum = 0, coinNum = 0;
  Map<double, int> coinCategory = {
    200: 0,
    100: 0,
    50: 0,
    20: 0,
    10: 0,
    5: 0,
    1: 0,
    0.5: 0,
    0.25: 0,
    0.20: 0,
    0.10: 0,
    0.05: 0,
    0.01: 0
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coin Change')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              onTap: () => clear(),
              style: TextStyle(fontSize: 22),
              controller: _controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onEditingComplete: () => onClicked(),
            ),
            SizedBox(height: 20),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              onPressed: () => onClicked(),
              child: Text(
                'Calculate',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              color: ThemeData().primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (noteNum != 0)
                    Text('$noteNum note', style: TextStyle(fontSize: 18)),
                  if (coinNum != 0)
                    Text('$coinNum coin', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: coinCategory.length,
              itemBuilder: (_, i) => coinCategory.values.toList()[i] != 0
                  ? Card(
                      child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      leading: CircleAvatar(
                        radius: 25,
                        child: FittedBox(
                          child: Text(
                            '${coinCategory.keys.toList()[i] < 1 ? (coinCategory.keys.toList()[i] * 100).toInt() : coinCategory.keys.toList()[i].toInt()} '
                            '${coinCategory.keys.toList()[i] >= 1 ? '\$' : '¢'}',
                          ),
                        ),
                      ),
                      trailing: Text(
                        coinCategory.values.toList()[i].toString(),
                        style: TextStyle(fontSize: 22),
                      ),
                    ))
                  : Container(),
            )),
          ],
        ),
      ),
    );
  }

  void onClicked() {
    FocusScope.of(context).unfocus();
    if (noteNum != 0 || coinNum != 0) {
      clear();
    }
    setState(() {
      change(double.tryParse(_controller.text) ?? 0);
    });
  }

  void clear() {
    _controller.clear();
    coinNum = 0;
    noteNum = 0;
    coinCategory.forEach((k, v) {
      coinCategory[k] = 0;
    });
  }

  void change(double number) {
    coinCategory.forEach((k, v) {
      while (number >= k && number > 0) {
        number -= k;
        if (number < 1) number = double.parse(number.toStringAsPrecision(2));
        coinCategory[k]++;
        k >= 1 ? noteNum++ : coinNum++;
      }
    });
  }
}
