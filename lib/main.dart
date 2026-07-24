import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoveSaúde',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00897B),
          primary: const Color(0xFF00897B),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pausasConcluidas = 0;

  void incrementarPausas() {
    setState(() {
      pausasConcluidas++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoveSaúde', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade600, Colors.teal.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.favorite, color: Colors.white, size: 40),
                  const SizedBox(height: 10),
                  const Text(
                    'Sua Saúde em Primeiro Lugar',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Mantenha a postura correta e faça pausas regulares para evitar lesões.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const Divider(color: Colors.white38, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Pausas ativas hoje: $pausasConcluidas',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Menu Principal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _buildMenuCard(
              context,
              title: 'Guia de Postura & Alongamentos',
              subtitle: 'Aprenda conceitos fundamentais e rotinas de exercícios',
              icon: Icons.menu_book_rounded,
              color: Colors.blue.shade600,
              page: const ModuloPage(),
            ),
            const SizedBox(height: 12),
            _buildMenuCard(
              context,
              title: 'Quiz de Ergonomia',
              subtitle: 'Teste seus conhecimentos sobre postura e saúde',
              icon: Icons.quiz_rounded,
              color: Colors.orange.shade700,
              page: const QuizPage(),
            ),
            const SizedBox(height: 12),
            _buildMenuCard(
              context,
              title: 'Timer de Pausa Ativa',
              subtitle: 'Cronômetro interativo com alertas de alongamento',
              icon: Icons.timer_rounded,
              color: Colors.teal.shade600,
              page: TimerPage(onFinish: incrementarPausas),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class ModuloPage extends StatelessWidget {
  const ModuloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conteúdo Educativo'),
          backgroundColor: Colors.teal.shade700,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(icon: Icon(Icons.accessibility_new), text: 'Ergonomia'),
              Tab(icon: Icon(Icons.fitness_center), text: 'Alongamentos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildErgonomiaTab(),
            _buildAlongamentosTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildErgonomiaTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            'https://images.unsplash.com/photo-1586281380349-632531db7ed4?w=600&auto=format&fit=crop',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 180,
              color: Colors.grey.shade300,
              child: const Icon(Icons.image_not_supported, size: 50),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Postura Adequada no Home Office / Estudo',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Manter uma postura ergonômica previne dores lombares, lesões por esforço repetitivo (LER) e fadiga muscular.',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        const ExpansionTile(
          title: Text('1. Posição da Tela', style: TextStyle(fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('O topo do monitor deve estar na altura dos olhos, a uma distância de um braço estendido (50 a 70 cm).'),
            )
          ],
        ),
        const ExpansionTile(
          title: Text('2. Apoio dos Pés e Pernas', style: TextStyle(fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Os pés devem ficar totalmente apoiados no chão ou em um descanso para pés. Ângulo dos joelhos em 90 graus.'),
            )
          ],
        ),
        const ExpansionTile(
          title: Text('3. Suporte Lombar', style: TextStyle(fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Mantenha as costas totalmente apoiadas no encosto da cadeira, preservando a curvatura natural da coluna.'),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildAlongamentosTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildStretchItem(
          title: 'Alongamento de Pescoço',
          description: 'Incline a cabeça suavemente para o lado direito por 15 segundos e depois troque o lado.',
          imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=600&auto=format&fit=crop',
        ),
        const SizedBox(height: 16),
        _buildStretchItem(
          title: 'Extensão de Ombros e Peitoral',
          description: 'Entrelace as mãos atrás das costas e puxe suavemente para trás, abrindo o peito.',
          imageUrl: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=600&auto=format&fit=crop',
        ),
      ],
    );
  }

  Widget _buildStretchItem({required String title, required String description, required String imageUrl}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 140,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.fitness_center, size: 40),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(description, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questaoAtual = 0;
  int pontuacao = 0;
  int? opcaoSelecionada;
  bool respondeu = false;

  final List<Map<String, dynamic>> perguntas = [
    {
      'pergunta': 'Qual o tempo máximo recomendado de permanência contínua na mesma postura?',
      'opcoes': ['2 horas', '50 minutos', '15 minutos', '3 horas'],
      'correta': 1,
    },
    {
      'pergunta': 'Onde deve ser posicionada a borda superior da tela do computador?',
      'opcoes': ['Abaixo do peito', 'Na altura dos olhos', 'Acima da cabeça', 'Qualquer altura'],
      'correta': 1,
    },
    {
      'pergunta': 'O que significa a sigla LER no contexto de saúde ocupacional?',
      'opcoes': [
        'Lesão por Esforço Repetitivo',
        'Lombalgia Extrema Restritiva',
        'Limitação Externa do Respiro',
        'Linguagem de Erros de Repouso'
      ],
      'correta': 0,
    }
  ];

  void responder(int index) {
    if (respondeu) return;

    setState(() {
      opcaoSelecionada = index;
      respondeu = true;
      if (index == perguntas[questaoAtual]['correta']) {
        pontuacao++;
      }
    });
  }

  void proximaPergunta() {
    setState(() {
      questaoAtual++;
      opcaoSelecionada = null;
      respondeu = false;
    });
  }

  void reiniciarQuiz() {
    setState(() {
      questaoAtual = 0;
      pontuacao = 0;
      opcaoSelecionada = null;
      respondeu = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool finalizou = questaoAtual >= perguntas.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz de Ergonomia'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: finalizou ? _buildResultadoScreen() : _buildPerguntaScreen(),
      ),
    );
  }

  Widget _buildPerguntaScreen() {
    final q = perguntas[questaoAtual];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearProgressIndicator(
          value: (questaoAtual + 1) / perguntas.length,
          backgroundColor: Colors.grey.shade300,
          color: Colors.teal,
        ),
        const SizedBox(height: 16),
        Text(
          'Pergunta ${questaoAtual + 1} de ${perguntas.length}',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Text(
          q['pergunta'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...List.generate(q['opcoes'].length, (i) {
          Color btnColor = Colors.white;
          Color textColor = Colors.black87;

          if (respondeu) {
            if (i == q['correta']) {
              btnColor = Colors.green.shade100;
              textColor = Colors.green.shade900;
            } else if (i == opcaoSelecionada) {
              btnColor = Colors.red.shade100;
              textColor = Colors.red.shade900;
            }
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: btnColor,
                side: BorderSide(
                  color: respondeu && i == q['correta']
                      ? Colors.green
                      : (respondeu && i == opcaoSelecionada ? Colors.red : Colors.grey.shade400),
                ),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
              ),
              onPressed: () => responder(i),
              child: Text(
                q['opcoes'][i],
                style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          );
        }),
        const Spacer(),
        if (respondeu)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
            onPressed: proximaPergunta,
            child: Text(questaoAtual == perguntas.length - 1 ? 'Ver Resultado' : 'Próxima Pergunta'),
          )
      ],
    );
  }

  Widget _buildResultadoScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            pontuacao >= 2 ? Icons.emoji_events : Icons.sentiment_dissatisfied,
            size: 80,
            color: pontuacao >= 2 ? Colors.amber : Colors.orange,
          ),
          const SizedBox(height: 20),
          const Text('Quiz Concluído!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(
            'Você acertou $pontuacao de ${perguntas.length} perguntas.',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.replay),
            label: const Text('Tentar Novamente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: reiniciarQuiz,
          )
        ],
      ),
    );
  }
}

class TimerPage extends StatefulWidget {
  final VoidCallback onFinish;
  const TimerPage({super.key, required this.onFinish});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const int tempoTotal = 300;
  int segundosRestantes = tempoTotal;
  Timer? timer;
  bool rodando = false;

  void iniciarTimer() {
    if (rodando) return;

    setState(() {
      rodando = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (segundosRestantes > 0) {
        setState(() {
          segundosRestantes--;
        });
      } else {
        t.cancel();
        setState(() {
          rodando = false;
        });
        widget.onFinish();
        _mostrarAlertaConclusao();
      }
    });
  }

  void pausarTimer() {
    timer?.cancel();
    setState(() {
      rodando = false;
    });
  }

  void resetarTimer() {
    timer?.cancel();
    setState(() {
      segundosRestantes = tempoTotal;
      rodando = false;
    });
  }

  void _mostrarAlertaConclusao() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pausa Concluída! 🎉'),
        content: const Text('Excelente! Você deu uma pausa para cuidar do seu corpo. Volte para os estudos renovado!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  String _formatarTempo(int segundos) {
    int min = segundos ~/ 60;
    int seg = segundos % 60;
    return '${min.toString().padLeft(2, '0')}:${seg.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progresso = segundosRestantes / tempoTotal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer de Pausa Ativa'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      value: progresso,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.shade200,
                      color: Colors.teal,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatarTempo(segundosRestantes),
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rodando ? 'Em andamento...' : 'Pausado',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.large(
                    heroTag: 'playBtn',
                    onPressed: rodando ? pausarTimer : iniciarTimer,
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    child: Icon(rodando ? Icons.pause : Icons.play_arrow, size: 40),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: 'resetBtn',
                    onPressed: resetarTimer,
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black87,
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
