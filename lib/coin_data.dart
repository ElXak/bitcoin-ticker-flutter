import 'package:bitcoin_ticker/services/notworking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';
const String bitcoinAverageAPIKey =
    'ODMxMGQ4YjZhZDU4NGU1MTk2Yzc1NjAxYzI0MzhlOGY';

class CoinData {
  Future<dynamic> get({String crypto, String currency}) async {
    String url = '$bitcoinAverageURL/$crypto$currency';
    print(url);
    NetworkHelper networkHelper =
        NetworkHelper(url, {'x-ba-key': bitcoinAverageAPIKey});
    var coinData = await networkHelper.getData();
    return coinData;
  }
}
