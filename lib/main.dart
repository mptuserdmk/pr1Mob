import 'package:flutter/material.dart';

// ============================================================================
// ГЛАВНАЯ ТОЧКА ВХОДА В ПРИЛОЖЕНИЕ FLUTTER
// ============================================================================
void main() {
  runApp(const MyApp());
}

// ============================================================================
// КОРНЕВОЙ ВИДЖЕТ ПРИЛОЖЕНИЯ
// Устанавливает тему (Material 3), цветовую палитру и стартовый экран
// ============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Название приложения для системы
      title: 'Практическая работа: Flutter UI',
      // Отключаем плашку DEBUG в углу экрана
      debugShowCheckedModeBanner: false,
      // Глобальная тема приложения
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0077B6), // Фирменный синий цвет
          primary: const Color(0xFF0077B6),
          secondary: const Color(0xFF00B4D8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8FA), // Мягкий фон экрана
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
      ),
      // Стартовый экран с вкладками
      home: const HomeScreen(),
    );
  }
}

// ============================================================================
// 1. ГЛАВНЫЙ ЭКРАН С НАВИГАЦИЕЙ (HomeScreen)
// Содержит BottomNavigationBar с двумя вкладками:
//   - Вкладка 1: "Простые макеты" (Профиль и Авторизация)
//   - Вкладка 2: "Сложные макеты" (Каталог товаров и Статья с комментариями)
// ============================================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Индекс активной вкладки (0 - простые макеты, 1 - сложные макеты)
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Список двух основных страниц для переключения
    final List<Widget> tabPages = [
      const SimpleLayoutsMenu(),
      const ComplexLayoutsMenu(),
    ];

    return Scaffold(
      // Верхняя панель AppBar
      appBar: AppBar(
        title: Text(
          _selectedTabIndex == 0
              ? 'Простые макеты (2 шт.)'
              : 'Сложные макеты (2 шт.)',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          // Значок оценки работы
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade400),
            ),
            child: const Row(
              children: [
                Icon(Icons.stars, color: Colors.green, size: 16),
                SizedBox(width: 4),
                Text(
                  'Оценка: 5',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Текущая вкладка в теле Scaffold
      body: tabPages[_selectedTabIndex],

      // Нижняя панель навигации (BottomNavigationBar)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (int index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF0077B6),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one_outlined),
            activeIcon: Icon(Icons.looks_one),
            label: 'Простые макеты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two_outlined),
            activeIcon: Icon(Icons.looks_two),
            label: 'Сложные макеты',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// МЕНЮ ВКЛАДКИ 1: ПРОСТЫЕ МАКЕТЫ
// ============================================================================
class SimpleLayoutsMenu extends StatelessWidget {
  const SimpleLayoutsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Информационная карточка
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2FE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFF0288D1)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Раздел 1: Базовые макеты. Изучены виджеты Column, Row, Container, CircleAvatar, TextField, ElevatedButton.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF0369A1)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Карточка макета 1: Профиль пользователя
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF0077B6),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Макет 1: Профиль пользователя',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Аватарка, имя, статус, статистика и кнопки',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Открыть экран профиля'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0077B6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Карточка макета 2: Экран авторизации
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        color: Colors.teal,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Макет 2: Экран авторизации',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Логотип, поля ввода логина/пароля, вход, соцсети',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Открыть экран авторизации'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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

// ============================================================================
// МЕНЮ ВКЛАДКИ 2: СЛОЖНЫЕ МАКЕТЫ
// ============================================================================
class ComplexLayoutsMenu extends StatelessWidget {
  const ComplexLayoutsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Информационная карточка
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.workspace_premium_outlined, color: Color(0xFFD97706)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Раздел 2: Сложные макеты. Изучены горизонтальный скролл, поиск с фильтрами, карточки товаров, списки отзывов и бейджи.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF92400E)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Карточка сложного макета 1: Интернет-магазин / Каталог
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.storefront,
                        color: Colors.orange,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Макет 3: Каталог интернет-магазина',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Поиск, фильтры, горизонтальные категории, карточки с ценами',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CatalogScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Открыть каталог товаров'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Карточка сложного макета 2: Статья с отзывами
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.article_outlined,
                        color: Colors.indigo,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Макет 4: Статья и отзывы',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Баннер, теги, автор, форматированный текст, лайки и отзывы',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ArticleScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Открыть статью с отзывами'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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

// ============================================================================
// ----------------------------------------------------------------------------
// ПРОСТОЙ МАКЕТ 1: ЭКРАН ПРОФИЛЯ ПОЛЬЗОВАТЕЛЯ
// ----------------------------------------------------------------------------
// ============================================================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Вспомогательный метод для колонки статистики
  Widget _buildStatColumn(String number, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0077B6),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Верхняя панель с кнопкой возврата
      appBar: AppBar(
        title: const Text('Профиль пользователя'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),

      // Скроллируемая область для предотвращения переполнения экрана
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Карточка с основной информацией пользователя
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Аватарка пользователя (CircleAvatar)
                    const CircleAvatar(
                      radius: 46,
                      backgroundColor: Color(0xFF0077B6),
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 14),

                    // Имя пользователя
                    const Text(
                      'Алексей Смирнов',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Статус / должность
                    const Text(
                      'Junior Flutter Developer',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Краткое описание (био)
                    const Text(
                      'Изучаю мобильную разработку на Flutter. Практикую верстку интерфейсов по макетам Figma.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 18),

                    // Кнопки действий (Row)
                    Row(
                      children: [
                        // Кнопка редактирования
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit, size: 16),
                            label: const Text('Изменить'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0077B6),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Кнопка поделиться
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share, size: 16),
                            label: const Text('Поделиться'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF0077B6),
                              side: const BorderSide(color: Color(0xFF0077B6)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Блок статистики (Row в Card)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn('14', 'Проектов'),
                    Container(
                      height: 28,
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                    _buildStatColumn('2.4k', 'Подписчиков'),
                    Container(
                      height: 28,
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                    _buildStatColumn('348', 'Подписок'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Контактные данные (ListTile)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Контактная информация',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(
                      Icons.email_outlined,
                      color: Color(0xFF0077B6),
                    ),
                    title: Text('alex.dev@flutter.ru'),
                    subtitle: Text('Email'),
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(
                      Icons.phone_outlined,
                      color: Color(0xFF0077B6),
                    ),
                    title: Text('+7 (999) 123-45-67'),
                    subtitle: Text('Телефон'),
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF0077B6),
                    ),
                    title: Text('Москва, Россия'),
                    subtitle: Text('Город проживания'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Секция навыков (Wrap с Chips)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ключевые навыки',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        Chip(label: Text('Flutter')),
                        Chip(label: Text('Dart')),
                        Chip(label: Text('Widgets')),
                        Chip(label: Text('UI Design')),
                        Chip(label: Text('Figma')),
                        Chip(label: Text('Git')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ----------------------------------------------------------------------------
// ПРОСТОЙ МАКЕТ 2: ЭКРАН АВТОРИЗАЦИИ / ВХОДА
// ----------------------------------------------------------------------------
// ============================================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Флаг видимости пароля
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Верхняя панель
      appBar: AppBar(title: const Text('Вход в аккаунт')),

      // Скроллируемая колонка
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            // Логотип приложения (Container со скруглением и иконкой)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.lock_person_outlined,
                size: 42,
                color: Color(0xFF0077B6),
              ),
            ),
            const SizedBox(height: 20),

            // Заголовок формы
            const Text(
              'С возвращением!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Подзаголовок
            const Text(
              'Введите ваш email и пароль для входа',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 32),

            // 1. Поле ввода Email (TextField)
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Электронная почта',
                hintText: 'user@example.com',
                prefixIcon: const Icon(Icons.email_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Поле ввода пароля (TextField)
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Пароль',
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Ссылка "Забыли пароль?"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Забыли пароль?'),
              ),
            ),
            const SizedBox(height: 16),

            // Кнопка входа (ElevatedButton)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Вход выполнен успешно!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0077B6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Войти',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Разделитель "или войдите через"
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade300)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'или войдите через',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade300)),
              ],
            ),
            const SizedBox(height: 20),

            // Кнопки альтернативного входа (Row)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.g_mobiledata,
                    size: 28,
                    color: Colors.red,
                  ),
                  label: const Text('Google'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.apple, size: 22, color: Colors.black),
                  label: const Text('Apple'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.phone_android,
                    size: 20,
                    color: Colors.blue,
                  ),
                  label: const Text('Телефон'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Ссылка на регистрацию
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Нет аккаунта?'),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ----------------------------------------------------------------------------
// СЛОЖНЫЙ МАКЕТ 1: ЭКРАН ИНТЕРНЕТ-МАГАЗИНА / КАТАЛОГА ТОВАРОВ
// ----------------------------------------------------------------------------
// ============================================================================
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // Список категорий для горизонтального скролла
  final List<String> _categories = [
    'Все блюда',
    'Салаты',
    'Пицца',
    'Паста',
    'Напитки',
    'Десерты',
  ];

  // Выбранная категория
  int _selectedCategoryIndex = 0;

  // Количество товаров в корзине
  int _cartItemCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Шапка каталога с корзиной
      appBar: AppBar(
        title: const Text('Каталог товаров'),
        actions: [
          // Иконка корзины с бейджем количества
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$_cartItemCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),

      // Тело каталога
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Поисковая строка с кнопкой фильтра (Row + TextField)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Поиск блюд и продуктов...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0077B6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // 2. Рекламный баннер с градиентом
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0077B6), Color(0xFF00B4D8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'СКИДКА 20%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Быстрая доставка еды!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Промокод: FLUTTER2026',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.fastfood_rounded,
                    size: 60,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // 3. Заголовок категорий
            const Text(
              'Категории',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Горизонтальный скролл категорий (SingleChildScrollView с scrollDirection.horizontal)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_categories.length, (index) {
                  final bool isSelected = _selectedCategoryIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(_categories[index]),
                      selected: isSelected,
                      selectedColor: const Color(0xFF0077B6),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 22),

            // 4. Заголовок секции популярных товаров
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Популярные блюда',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text('Смотреть все')),
              ],
            ),
            const SizedBox(height: 8),

            // Карточки товаров
            _buildProductCard(
              title: 'Свежий салат Цезарь',
              description: 'Куриное филе, пармезан, салат романо, соус цезарь',
              price: '420 ₽',
              rating: '4.9',
              icon: Icons.restaurant,
              iconColor: Colors.green,
            ),
            _buildProductCard(
              title: 'Пицца Четыре Сыра',
              description: 'Моцарелла, дорблю, пармезан, чеддер, томатный соус',
              price: '680 ₽',
              rating: '4.8',
              icon: Icons.local_pizza_rounded,
              iconColor: Colors.deepOrange,
            ),
            _buildProductCard(
              title: 'Паста с морепродуктами',
              description:
                  'Феттучини, тигровые креветки, кальмары, сливочный соус',
              price: '590 ₽',
              rating: '4.9',
              icon: Icons.dinner_dining_rounded,
              iconColor: Colors.blueAccent,
            ),
            _buildProductCard(
              title: 'Ягодный смузи',
              description: 'Клубника, малина, банан, миндальное молоко, мята',
              price: '280 ₽',
              rating: '4.7',
              icon: Icons.local_cafe_rounded,
              iconColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  // Метод сборки карточки товара (Card + Row + Column)
  Widget _buildProductCard({
    required String title,
    required String description,
    required String price,
    required String rating,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Иконка-заглушка товара в цветном контейнере
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 36),
            ),
            const SizedBox(width: 14),

            // Описание и цена
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),

                  // Рейтинг и кнопка покупки
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),

                      // Цена
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0077B6),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Кнопка добавления в корзину
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _cartItemCount++;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$title добавлен в корзину'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0077B6),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Купить',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
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

// ============================================================================
// ----------------------------------------------------------------------------
// СЛОЖНЫЙ МАКЕТ 2: ЭКРАН СТАТЬИ С КОММЕНТАРИЯМИ И ОТЗЫВАМИ
// ----------------------------------------------------------------------------
// ============================================================================
class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Верхняя панель
      appBar: AppBar(
        title: const Text('Статья и обсуждение'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),

      // Скроллируемое тело статьи
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Иллюстративный баннер статьи
            Container(
              height: 180,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF03045E), Color(0xFF0077B6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flutter_dash, size: 70, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'FLUTTER UI DESIGN GUIDE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Контентная часть статьи
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Бейджи тегов (Row)
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildTagChip('#Flutter'),
                      _buildTagChip('#Dart'),
                      _buildTagChip('#MobileDevelopment'),
                      _buildTagChip('#UI/UX'),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Заголовок статьи
                  const Text(
                    'Основы построения пользовательских интерфейсов на Flutter',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Автор и дата публикации (Row)
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF0077B6),
                        child: Text(
                          'МИ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Михаил Иванов',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Опубликовано сегодня • 5 мин чтения',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('Подписаться'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Текст статьи
                  const Text(
                    'Фреймворк Flutter предоставляет мощную декларативную модель разработки. Интерфейс создается путем композиции независимых виджетов: от простейших строк (Text) и отступов (Padding) до сложных списков (ListView).',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'В рамках данной практической работы были исследованы и применены такие базовые элементы, как Scaffold, Column, Row, Container, Card и SingleChildScrollView. Это позволило воссоздать структуру профессиональных дизайн-макетов из Figma.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Блок статистики (Лайки, Просмотры, Комментарии)
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatButton(Icons.favorite, '328', Colors.red),
                          _buildStatButton(
                            Icons.visibility_outlined,
                            '2.1k',
                            Colors.blueGrey,
                          ),
                          _buildStatButton(
                            Icons.chat_bubble_outline,
                            '3',
                            Colors.blueGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Заголовок раздела комментариев
                  const Text(
                    'Комментарии и отзывы (3)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),

                  // Список комментариев
                  _buildCommentCard(
                    author: 'Анна Соколова',
                    timeAgo: '2 часа назад',
                    rating: 5,
                    comment:
                        'Отличная верстка! Очень понятный код и аккуратная структура компонентов.',
                  ),
                  _buildCommentCard(
                    author: 'Дмитрий Кузнецов',
                    timeAgo: '4 часа назад',
                    rating: 5,
                    comment:
                        'Все требования соблюдены. Особенно понравилась адаптивность под разные размеры экрана.',
                  ),
                  _buildCommentCard(
                    author: 'Елена Васильева',
                    timeAgo: 'Вчера',
                    rating: 4,
                    comment:
                        'Отличный наглядный пример реализации базовых виджетов Flutter.',
                  ),
                  const SizedBox(height: 16),

                  // Поле для добавления нового отзыва/комментария
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Оставить свой отзыв...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.send_rounded,
                            color: Color(0xFF0077B6),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Комментарий отправлен!'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Метод сборки бейджа тега
  Widget _buildTagChip(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF0288D1),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Метод кнопки статистики
  Widget _buildStatButton(IconData icon, String count, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 6),
        Text(
          count,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }

  // Карточка одного комментария
  Widget _buildCommentCard({
    required String author,
    required String timeAgo,
    required int rating,
    required String comment,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    author.isNotEmpty ? author[0] : '?',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF0077B6),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  author,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                // Звездочки оценки
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 14,
                      color: index < rating
                          ? Colors.amber
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              comment,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              timeAgo,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
