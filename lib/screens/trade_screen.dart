// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:apple_gadgets_bd/services/api_service.dart';

const getOpenTrades = 'GetOpenTrades';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  List tradeList = [];

  Future<void> getTrades() async {
    final td = await getData(getOpenTrades);

    if (td != null) {
      setState(() => tradeList = td);
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  double getTotalProfit() {
    double p = 0;
    if (tradeList.isNotEmpty) {
      for (dynamic e in tradeList) {
        p += e['profit'];
      }

      return p;
    }
    return p;
  }

  @override
  void initState() {
    super.initState();
    getTrades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TOTAL PROFIT ${getTotalProfit().toStringAsFixed(2)}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final t = tradeList[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.lightBlue.shade300),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(0, 1), // Shadow position
                  ),
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Current Price: ${t['currentPrice'].toString()}'),
                    Text('Open Price: ${t['openPrice'].toString()}'),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Profit: ${t['profit'].toString()}'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Symbol: ${t['symbol']}'),
                    Text('Ticket: ${t['ticket'].toString()}'),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: tradeList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getTrades();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
