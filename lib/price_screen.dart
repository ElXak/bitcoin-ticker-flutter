import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  var lastPrice = Map();

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() async {
    for (String crypto in cryptoList) {
      lastPrice[crypto] = '?';

      try {
        var data = await coinData.get(
          crypto: crypto,
          currency: selectedCurrency,
        );

        setState(() {
          lastPrice[crypto] = data['last'].toStringAsFixed(2);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Column cardsList() {
    List<CoinCard> coinCards = [];

    for (String crypto in cryptoList) {
      CoinCard newCard = CoinCard(
        lastPrice: lastPrice[crypto],
        selectedCurrency: selectedCurrency,
        coinName: crypto,
      );
      coinCards.add(newCard);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: coinCards,
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
/*
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
*/

    for (String currency in currenciesList) {
      DropdownMenuItem<String> newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
/*
      items: [
      DropdownMenuItem(
      child: Text('USD'),
      value: 'USD',
      ),
      DropdownMenuItem(
      child: Text('EUR'),
      value: 'EUR',
      ),
      DropdownMenuItem(
      child: Text('GBP'),
      value: 'GBP',
      ),
      ],
*/
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      Text newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        updateUI();
      },
/*
              children: [
                Text('USD'),
                Text('EUR'),
                Text('GBP'),
              ],
*/
      children: pickerItems,
    );
  }

/*
  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
      // } else if (Platform.isAndroid) {
    } else {
      return androidDropdown();
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          cardsList(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
