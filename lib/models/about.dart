import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 68,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://picsum.photos/60/68"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          width: 38,
          height: 35,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://picsum.photos/38/35"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(
          width: 207,
          height: 50,
          child: Text(
            'About :',
            style: TextStyle(
              color: Color(0xFF720D9D),
              fontSize: 40,
              fontFamily: 'Amaranth',
              height: 0,
            ),
          ),
        ),
        SizedBox(
          width: 343,
          height: 613,
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Making Movement Fun for People with Ataxia!\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontFamily: 'Inter',
                    height: 0,
                  ),
                ),
                const TextSpan(
                  text:
                      '\nCoOrdiPlay is a mobile app designed to support individuals with ataxia—a condition that affects coordination, balance, and speech. Through fun, adaptive games and exercises, CoOrdiPlay helps improve motor skills, cognitive function, and overall well-being.\n\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    height: 0,
                  ),
                ),
                const TextSpan(
                  text: 'What is Ataxia?\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontFamily: 'Inter',
                    height: 0,
                  ),
                ),
                const TextSpan(
                  text:
                      '                   Ataxia is a neurological disorder caused by damage to the cerebellum. It can lead to difficulty walking, unsteady movements, slurred speech, and trouble with fine motor tasks. Though there\'s no cure, regular therapy and tools like CoOrdiPlay can help manage symptoms.\n\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    height: 0,
                  ),
                ),
                const TextSpan(
                  text: 'Why CoOrdiPlay?\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontFamily: 'Inter',
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '                   🎮 Fun and Engaging Games                   📊 Progress Tracking                   🧠 Brain Exercises                   💙 Supportive Community\n\nWhether you\'re living with ataxia or recovering from an injury, CoOrdiPlay makes therapy enjoyable and motivating.',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
