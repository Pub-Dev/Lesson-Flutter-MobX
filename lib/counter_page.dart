import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_study/stores/counter_store.dart';
import 'package:mobx/mobx.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final Counter counter = Counter();

  ReactionDisposer autoRunExample;
  ReactionDisposer reactionExample;
  ReactionDisposer whenExample;

  @override
  void initState() {
    // Reaction que se ativa a todo momento
    autoRunExample = autorun(
      (_) => print('valor: ${counter.value}'),
    );

    // Reaction que monitora apenas uma variavel
    reactionExample = reaction(
      (_) => counter.value,
      (value) => print('Monitorando apenas um valor. Valor: $value'),
    );

    // Reaction que quando acontecer a condicao, ele vai acionar/realizar alguma coisa
    // isto executara apenas UMA VEZ!!!
    whenExample = when(
      (_) => counter.value >= 10, //quando acontecer isso
      () => print('Chegamos no numero 10!!!'), //executa isso
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            // Colocamos o observer do mobx para sempre atualizar a tela, quando a propriedade "value" for alterada
            Observer(
              builder: (context) {
                return Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    // Por padrao, sempre dee dispose em suas reactions
    autoRunExample.reaction.dispose();
    reactionExample.reaction.dispose();
    whenExample.reaction.dispose();
    super.dispose();
  }
}
