import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(213, 222, 240, 1),
        body: Column(
          children: [
            const SizedBox(height: 70),
            const Row(
              children: [
                SizedBox(width: 16),
                Expanded(child: Center(child: Text('You'))),
                SizedBox(width: 12),
                Expanded(child: Center(child: Text('Enimy'))),
                SizedBox(width: 16),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            const Expanded(child: SizedBox()),
            // это вторая строка, которая растянута на весь экран, т.о. она прижимает к краям первую и третью строки
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 16), // создает пустоту с левого края
                Expanded(
                  child: Column(
                    children: [
                      Text('Defend'.toUpperCase()),
                      const SizedBox(height: 13),
                      // создает пустоту между Defend и кнопками снизу
                      BodyPartButton(
                        bodyPart: BodyPart.head,
                        selected: defendingBodyPart == BodyPart.head,
                        bodyPartSetter: _selectDefendingBodyPart,
                      ),

                      const SizedBox(height: 13),
                      // создает пустоту между кнопками head & torso слева
                      BodyPartButton(
                          bodyPart: BodyPart.torso,
                          selected: defendingBodyPart == BodyPart.torso,
                          bodyPartSetter: _selectDefendingBodyPart),

                      const SizedBox(height: 13),
                      // создает пустоту между кнопками head & torso слева
                      BodyPartButton(
                          bodyPart: BodyPart.legs,
                          selected: defendingBodyPart == BodyPart.legs,
                          bodyPartSetter: _selectDefendingBodyPart),
                    ],
                  ),
                ),
                const SizedBox(width: 12), // создает пустоту в центре между кнопками
                Expanded(
                  child: Column(
                    children: [
                      Text('Attack'.toUpperCase()),
                      const SizedBox(height: 13),
                      // создает пустоту между Attack и кнопками снизу
                      BodyPartButton(
                        bodyPart: BodyPart.head,
                        selected: attackingBodyPart == BodyPart.head,
                        bodyPartSetter: _selectAttackingBodyPart,
                      ),
                      const SizedBox(height: 13),
                      // создает пустоту между кнопками head & torso справа
                      BodyPartButton(
                          bodyPart: BodyPart.torso,
                          selected: attackingBodyPart == BodyPart.torso,
                          bodyPartSetter: _selectAttackingBodyPart),

                      const SizedBox(height: 13),
                      // создает пустоту между кнопками head & torso слева
                      BodyPartButton(
                          bodyPart: BodyPart.legs,
                          selected: attackingBodyPart == BodyPart.legs,
                          bodyPartSetter: _selectAttackingBodyPart),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                    child: SizedBox(
                  height: 40,
                  child: GestureDetector(
                    onTap: () => {
                      if (attackingBodyPart != null &&
                          defendingBodyPart != null)
                        {
                          setState(() {
                            attackingBodyPart = null;
                            defendingBodyPart = null;
                          }),
                        },
                    },
                    child: ColoredBox(
                      color:
                          attackingBodyPart == null || defendingBodyPart == null
                              ? Colors.black38
                              : const Color.fromRGBO(0, 0, 0, 0.87),
                      child: Center(
                        child: Text(
                          'Go'.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
                const SizedBox(width: 16),
              ],
            )
          ],
        ));
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('Legs');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color:
              selected ? const Color.fromRGBO(28, 121, 206, 1) : Colors.black38,
          child: Center(child: Text(bodyPart.name.toUpperCase())),
        ),
      ),
    );
  }
}
