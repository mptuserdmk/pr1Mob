import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа: 4 макета UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFE2E8F0),
        fontFamily: 'Roboto',
      ),
      home: const AllLayoutsShowcaseScreen(),
    );
  }
}

/// Главный экран-витрина: размещает все 4 макета на одном экране
class AllLayoutsShowcaseScreen extends StatefulWidget {
  const AllLayoutsShowcaseScreen({super.key});

  @override
  State<AllLayoutsShowcaseScreen> createState() => _AllLayoutsShowcaseScreenState();
}

class _AllLayoutsShowcaseScreenState extends State<AllLayoutsShowcaseScreen> {
  // 0 = Все 4 макета (в ряд / мульти-экран)
  // 1 = 2 Простых макета (Medinow)
  // 2 = 2 Сложных макета (E-Wallet + Organizer)
  // 3 = Макет 1: Medinow Welcome
  // 4 = Макет 2: Meditate Catalog
  // 5 = Макет 3: E-Wallet
  // 6 = Макет 4: Organizer
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.devices_outlined, color: Color(0xFF0F172A), size: 20),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'Практическая работа: 4 макета UI',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment<int>(
                    value: 0,
                    label: Text('Все 4 макета'),
                    icon: Icon(Icons.grid_view_rounded, size: 16),
                  ),
                  ButtonSegment<int>(
                    value: 1,
                    label: Text('2 Простых'),
                    icon: Icon(Icons.spa_outlined, size: 16),
                  ),
                  ButtonSegment<int>(
                    value: 2,
                    label: Text('2 Сложных'),
                    icon: Icon(Icons.credit_card_rounded, size: 16),
                  ),
                ],
                selected: {_selectedFilter > 2 ? 0 : _selectedFilter},
                onSelectionChanged: (Set<int> newSelection) {
                  setState(() {
                    _selectedFilter = newSelection.first;
                  });
                },
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF86EFAC)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_rounded, color: Color(0xFF16A34A), size: 16),
                SizedBox(width: 6),
                Text(
                  'Оценка: 5',
                  style: TextStyle(
                    color: Color(0xFF16A34A),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    // 4 смартфона
    final m1 = _buildMockupCard(
      badge: 'Простой макет 1',
      title: 'Medinow • Приветствие',
      badgeColor: const Color(0xFF00796B),
      child: const MedinowWelcomeMockup(),
    );

    final m2 = _buildMockupCard(
      badge: 'Простой макет 2',
      title: 'Meditate • Каталог сессий',
      badgeColor: const Color(0xFF028174),
      child: const MeditateCatalogMockup(),
    );

    final m3 = _buildMockupCard(
      badge: 'Сложный макет 1',
      title: 'My E-Wallet • Кошелек и карта',
      badgeColor: const Color(0xFF1E1F22),
      child: const EWalletMockup(),
    );

    final m4 = _buildMockupCard(
      badge: 'Сложный макет 2',
      title: 'Organizer • Профиль организатора',
      badgeColor: const Color(0xFF4361EE),
      child: const OrganizerProfileMockup(),
    );

    List<Widget> activeList;
    if (_selectedFilter == 1) {
      activeList = [m1, m2];
    } else if (_selectedFilter == 2) {
      activeList = [m3, m4];
    } else {
      activeList = [m1, m2, m3, m4];
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool canFitRow = constraints.maxWidth >= (activeList.length * 320);

        if (canFitRow) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: activeList.map((card) => Expanded(child: card)).toList(),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: activeList.map((card) {
                return SizedBox(
                  width: 360,
                  height: constraints.maxHeight,
                  child: card,
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget _buildMockupCard({
    required String badge,
    required String title,
    required Color badgeColor,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Заголовок фрейма
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 4, right: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF334155),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Телефонный корпус
          Expanded(
            child: _PhoneDeviceFrame(child: child),
          ),
        ],
      ),
    );
  }
}

/// Рамка смартфона со статус-баром и закругленными углами
class _PhoneDeviceFrame extends StatelessWidget {
  final Widget child;

  const _PhoneDeviceFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: const Color(0xFF0F172A), width: 7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: child,
      ),
    );
  }
}

// ==============================================================================
// 1. ПРОСТОЙ МАКЕТ 1: MEDINOW WELCOME SCREEN (ЗЕЛЕНЫЙ ЭКРАН ВХОДА)
// ==============================================================================
class MedinowWelcomeMockup extends StatelessWidget {
  const MedinowWelcomeMockup({super.key});

  @override
  Widget build(BuildContext context) {
    const tealBg = Color(0xFF00796B);

    return Scaffold(
      backgroundColor: tealBg,
      body: SafeArea(
        child: Stack(
          children: [
            // Иллюстрация медитации в нижней части экрана
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 250,
              child: CustomPaint(
                painter: _MedinowYogiPainter(),
              ),
            ),
            // Контентная часть (логотип + кнопки)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Верхний статус-бар
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '9:41',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.signal_cellular_alt, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Icon(Icons.wifi, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Icon(Icons.battery_full, color: Colors.white, size: 16),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // Логотип
                  const Text(
                    'medinow',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Meditate With Us!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Кнопка 1: Sign in with Apple
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Sign in with Apple',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Кнопка 2: Continue with Email or Phone
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC7F3EC),
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Continue with Email or Phone',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Ссылка 3: Continue With Google
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Continue With Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Художественная векторная отрисовка йога и растений без внешних ассетов
class _MedinowYogiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final leafPaint = Paint()..color = const Color(0xFF4DB6AC).withValues(alpha: 0.45);
    final darkLeafPaint = Paint()..color = const Color(0xFF26A69A).withValues(alpha: 0.6);
    final matPaint = Paint()..color = const Color(0xFF004D40);

    // Растения сзади
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width * 0.2, size.height * 0.6), width: 90, height: 180),
      leafPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width * 0.8, size.height * 0.5), width: 110, height: 210),
      leafPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width * 0.72, size.height * 0.65), width: 80, height: 160),
      darkLeafPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width * 0.3, size.height * 0.7), width: 70, height: 150),
      darkLeafPaint,
    );

    // Коврик
    final matPath = Path()
      ..moveTo(size.width * 0.08, size.height * 0.88)
      ..lineTo(size.width * 0.92, size.height * 0.88)
      ..lineTo(size.width * 0.84, size.height * 0.98)
      ..lineTo(size.width * 0.16, size.height * 0.98)
      ..close();
    canvas.drawPath(matPath, matPaint);

    // Фигура медитирующего человека
    final centerX = size.width * 0.5;
    final baseY = size.height * 0.76;

    // Ноги (скрещенные)
    final pantsPaint = Paint()..color = const Color(0xFF1E293B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(centerX, baseY + 18), width: 150, height: 26),
        const Radius.circular(13),
      ),
      pantsPaint,
    );

    // Торс (белая майка)
    final bodyPaint = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(centerX, baseY - 20), width: 68, height: 60),
        const Radius.circular(18),
      ),
      bodyPaint,
    );

    // Шея и голова
    final skinPaint = Paint()..color = const Color(0xFFFFD1BA);
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, baseY - 56), width: 18, height: 18),
      skinPaint,
    );
    canvas.drawCircle(Offset(centerX, baseY - 74), 22, skinPaint);

    // Волосы
    final hairPaint = Paint()..color = const Color(0xFF1E293B);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, baseY - 78), radius: 24),
      3.14,
      3.14,
      true,
      hairPaint,
    );

    // Сложенные в намасте руки
    final armPath = Path()
      ..moveTo(centerX - 30, baseY - 35)
      ..lineTo(centerX, baseY - 15)
      ..lineTo(centerX + 30, baseY - 35);
    final armPaint = Paint()
      ..color = const Color(0xFFFFD1BA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(armPath, armPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==============================================================================
// 2. ПРОСТОЙ МАКЕТ 2: MEDITATE CATALOG SCREEN (КАТАЛОГ СЕССИЙ)
// ==============================================================================
class MeditateCatalogMockup extends StatelessWidget {
  const MeditateCatalogMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Верхний статус-бар
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9:41',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_alt, size: 15),
                      SizedBox(width: 4),
                      Icon(Icons.wifi, size: 15),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full, size: 15),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Заголовок и поиск
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Meditate',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, size: 26, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Категории (горизонтальный скролл чипов)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryPill('All', isSelected: true),
                    _buildCategoryPill('Bible In a Year', isSelected: false),
                    _buildCategoryPill('Dailies', isSelected: false),
                    _buildCategoryPill('Minutes', isSelected: false),
                    _buildCategoryPill('November', isSelected: false),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Главный большой баннер: A Song of Moon
              _buildBigBannerCard(),
              const SizedBox(height: 16),

              // Сетка 2x2 карточек
              Row(
                children: [
                  Expanded(
                    child: _buildSmallSessionCard(
                      title: 'The Sleep Hour',
                      author: 'Ashna Mukherjee',
                      footer: '3 Sessions',
                      cardColor: const Color(0xFFF68758),
                      icon: Icons.wb_sunny_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSmallSessionCard(
                      title: 'Easy on the Mission',
                      author: 'Peter Mach',
                      footer: '5 minutes',
                      cardColor: const Color(0xFFE4BD54),
                      icon: Icons.nightlight_round,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildSmallSessionCard(
                      title: 'Relax with Me',
                      author: 'Amanda James',
                      footer: '3 Sessions',
                      cardColor: const Color(0xFF3B82F6),
                      icon: Icons.brightness_7_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSmallSessionCard(
                      title: 'Sun and Energy',
                      author: 'Micheal Hiu',
                      footer: '5 minutes',
                      cardColor: const Color(0xFF0D9488),
                      icon: Icons.flare_rounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryPill(String title, {required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF00897B) : const Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF00897B),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildBigBannerCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFD066),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Иллюстрация солнца и месяца
          Container(
            height: 110,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 60,
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF87171),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.wb_sunny, color: Color(0xFFFEF08A), size: 45),
                  ),
                ),
                Positioned(
                  right: 70,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E293B),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.nightlight_round, color: Color(0xFFFDE68A), size: 36),
                  ),
                ),
              ],
            ),
          ),
          // Текстовая плашка
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'A Song of Moon',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Start with the basics',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.favorite_border, size: 14, color: Colors.black45),
                        SizedBox(width: 4),
                        Text(
                          '9 Sessions',
                          style: TextStyle(fontSize: 11, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(Icons.chevron_right, size: 16, color: Colors.black87),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallSessionCard({
    required String title,
    required String author,
    required String footer,
    required Color cardColor,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Шапка карточки с цветом
          Container(
            height: 75,
            width: double.infinity,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(
              child: Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 36),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.favorite_border, size: 12, color: Colors.black45),
                        const SizedBox(width: 3),
                        Text(
                          footer,
                          style: const TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(Icons.chevron_right, size: 14, color: Colors.black87),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 3. СЛОЖНЫЙ МАКЕТ 1: MY E-WALLET SCREEN (КОШЕЛЕК И ИСТОРИЯ ОПЕРАЦИЙ)
// ==============================================================================
class EWalletMockup extends StatelessWidget {
  const EWalletMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Верхний статус-бар
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '9:41',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Row(
                          children: [
                            Icon(Icons.signal_cellular_alt, size: 15),
                            SizedBox(width: 4),
                            Icon(Icons.wifi, size: 15),
                            SizedBox(width: 4),
                            Icon(Icons.battery_full, size: 15),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Шапка экрана: Логотип, Заголовок, Поиск, Еще
                    Row(
                      children: [
                        const Icon(Icons.wallet_outlined, size: 24, color: Colors.black87),
                        const SizedBox(width: 8),
                        const Text(
                          'My E-Wallet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search, size: 22, color: Colors.black87),
                          visualDensity: VisualDensity.compact,
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.more_horiz, size: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Кредитная карточка Andrew Ainsley
                    _buildCreditCard(),
                    const SizedBox(height: 18),

                    // Раздел Transaction History
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Transaction History',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Список транзакций
                    _buildTransactionItem(
                      icon: Icons.chair_rounded,
                      iconBg: const Color(0xFFEFF6FF),
                      iconColor: const Color(0xFF2563EB),
                      title: 'Lawson Chair',
                      date: 'Dec 15, 2024 | 10:00 AM',
                      amount: '\$120',
                      tag: 'Orders',
                      isOrder: true,
                    ),
                    _buildTransactionItem(
                      icon: Icons.account_balance_wallet_rounded,
                      iconBg: const Color(0xFF1E293B),
                      iconColor: Colors.white,
                      title: 'Top Up Wallet',
                      date: 'Dec 14, 2024 | 16:42 PM',
                      amount: '\$400',
                      tag: 'Top Up',
                      isOrder: false,
                    ),
                    _buildTransactionItem(
                      icon: Icons.light_outlined,
                      iconBg: const Color(0xFFFFF7ED),
                      iconColor: const Color(0xFFEA580C),
                      title: 'Parabolic Reflector',
                      date: 'Dec 14, 2024 | 11:39 AM',
                      amount: '\$170',
                      tag: 'Orders',
                      isOrder: true,
                    ),
                    _buildTransactionItem(
                      icon: Icons.table_restaurant_rounded,
                      iconBg: const Color(0xFFFEFCE8),
                      iconColor: const Color(0xFFCA8A04),
                      title: 'Mini Wooden Table',
                      date: 'Dec 13, 2024 | 14:46 PM',
                      amount: '\$165',
                      tag: 'Orders',
                      isOrder: true,
                    ),
                    _buildTransactionItem(
                      icon: Icons.account_balance_wallet_rounded,
                      iconBg: const Color(0xFF1E293B),
                      iconColor: Colors.white,
                      title: 'Top Up Wallet',
                      date: 'Dec 12, 2024 | 09:27 AM',
                      amount: '\$300',
                      tag: 'Top Up',
                      isOrder: false,
                    ),
                  ],
                ),
              ),
            ),

            // Нижняя навигационная панель
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Имя, номер карты и логотипы платежных систем
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Andrew Ainsley',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '•••• •••• •••• 3629',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'VISA',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Mastercard перекрывающиеся круги
                  SizedBox(
                    width: 32,
                    height: 20,
                    child: Stack(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEB001B),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF79E1B).withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Баланс и кнопка Top Up
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Your balance',
                    style: TextStyle(color: Colors.white60, fontSize: 11),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$9,379',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              // Кнопка Top Up
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_balance_wallet_outlined, size: 15, color: Colors.black87),
                    SizedBox(width: 6),
                    Text(
                      'Top Up',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String date,
    required String amount,
    required String tag,
    required bool isOrder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(fontSize: 10, color: Colors.black45),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tag,
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  const SizedBox(width: 3),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isOrder ? const Color(0xFFEF4444) : const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Icon(
                      isOrder ? Icons.arrow_outward_rounded : Icons.arrow_downward_rounded,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _NavIcon(icon: Icons.home_outlined, label: 'Home', isActive: false),
          _NavIcon(icon: Icons.shopping_bag_outlined, label: 'Cart', isActive: false),
          _NavIcon(icon: Icons.receipt_long_outlined, label: 'Orders', isActive: false),
          _NavIcon(icon: Icons.account_balance_wallet, label: 'Wallet', isActive: true),
          _NavIcon(icon: Icons.person_outline, label: 'Profile', isActive: false),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavIcon({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 22,
          color: isActive ? Colors.black87 : Colors.black38,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.black87 : Colors.black38,
          ),
        ),
      ],
    );
  }
}

// ==============================================================================
// 4. СЛОЖНЫЙ МАКЕТ 2: ORGANIZER PROFILE SCREEN (ПРОФИЛЬ АЛЬБЕРТА ФЛОРЕСА)
// ==============================================================================
class OrganizerProfileMockup extends StatefulWidget {
  const OrganizerProfileMockup({super.key});

  @override
  State<OrganizerProfileMockup> createState() => _OrganizerProfileMockupState();
}

class _OrganizerProfileMockupState extends State<OrganizerProfileMockup> {
  int _activeTab = 0; // 0 = About, 1 = Events, 2 = Reviews

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF4361EE);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Верхний статус-бар
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9:41',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_alt, size: 15),
                      SizedBox(width: 4),
                      Icon(Icons.wifi, size: 15),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full, size: 15),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Шапка с кнопкой назад и опциями
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back, color: primaryBlue, size: 22),
                    visualDensity: VisualDensity.compact,
                  ),
                  const Text(
                    'Organizer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.more_vert, color: primaryBlue, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Аватар организатора
              Center(
                child: Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 3),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE0E7FF), Color(0xFFC7D2FE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.person, size: 50, color: Color(0xFF4361EE)),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Имя
              const Center(
                child: Text(
                  'Albert Flores',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Статистика: 2.368 Followers, 346 Following, 13 Events
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _ProfileStatCol(value: '2.368', label: 'Followers'),
                  _ProfileStatCol(value: '346', label: 'Following'),
                  _ProfileStatCol(value: '13', label: 'Events'),
                ],
              ),
              const SizedBox(height: 18),

              // Кнопки Follow и Messages
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.person_add_alt_1, size: 16),
                        label: const Text('Follow', style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
                        label: const Text('Messages', style: TextStyle(fontWeight: FontWeight.bold)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryBlue,
                          side: const BorderSide(color: primaryBlue, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Вкладки: About, Events, Reviews
              Row(
                children: [
                  _buildTabPill(index: 0, title: 'About', primaryBlue: primaryBlue),
                  const SizedBox(width: 8),
                  _buildTabPill(index: 1, title: 'Events', primaryBlue: primaryBlue),
                  const SizedBox(width: 8),
                  _buildTabPill(index: 2, title: 'Reviews', primaryBlue: primaryBlue),
                ],
              ),
              const SizedBox(height: 16),

              // Блок About
              const Text(
                'About',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.45,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                    ),
                    TextSpan(
                      text: 'Read more...',
                      style: TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabPill({
    required int index,
    required String title,
    required Color primaryBlue,
  }) {
    final bool isSelected = _activeTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: isSelected ? primaryBlue : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primaryBlue, width: 1.4),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileStatCol extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStatCol({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
