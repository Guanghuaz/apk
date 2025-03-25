import 'package:flutter/material.dart';
import 'dart:math'; // 导入 math 库用于生成随机数

void main() {
  runApp(const MedReminderApp());
}

class MedReminderApp extends StatelessWidget {
  const MedReminderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '智能药盒',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _authService = AuthService();

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final token = await _authService.login(
        _phoneController.text, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (token != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登录成功，Token: $token')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage())); // 替换为 MainPage
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登录失败，请检查手机号或密码')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: '手机号'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '密码'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading ? const CircularProgressIndicator() : const Text('登录'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              },
              child: const Text('没有账号？去注册'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _authService = AuthService();

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    final token = await _authService.register(
        _phoneController.text, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (token != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('注册成功，Token: $token')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage())); // 替换为 MainPage
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('注册失败，请检查手机号和密码')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('注册')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: '手机号'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '密码'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              child: _isLoading ? const CircularProgressIndicator() : const Text('注册'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()));
              },
              child: const Text('已有账号？去登录'),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthService {
  // 模拟注册
  Future<String?> register(String phone, String password) async {
    // 模拟 API 调用
    await Future.delayed(const Duration(seconds: 2));
    if (phone.isNotEmpty && password.isNotEmpty) {
      return 'mock_token_for_$phone';
    } else {
      return null;
    }
  }

  // 模拟登录
  Future<String?> login(String phone, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (phone == '12345678901' && password == 'password123') {
      return 'mock_token_12345';
    } else {
      return null;
    }
  }
}

class DataService {
  // 模拟获取首页数据
  Future<Map<String, dynamic>> getHomePageData() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'tips': '按时服药，保持健康。',
      'temperature': 25.5,
      'humidity': 55.0,
      'lastMedicationReminder': '无',
      'nextMedicationTime': '今晚 8 点',
      'carouselImages': [
        "https://img2.baidu.com/it/u=3603627379,2528879396&fm=253&fmt=auto&app=138&f=JPG?w=1470&h=80" // 更新的图片地址
      ],
    };
  }

  // 模拟获取处方数据
  Future<List<Prescription>> getPrescriptions() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Prescription(time: '早上 8:00', medicine: '阿司匹林'),
      Prescription(time: '中午 12:00', medicine: '二甲双胍'),
      Prescription(time: '晚上 8:00', medicine: '辛伐他汀'),
        Prescription(time: '下午 4:00', medicine: '多种维生素'),
    ];
  }

  // 模拟获取服药记录
  Future<List<String>> getMedicationRecords() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      '2024-01-01 早上 8:00 服用：阿司匹林 - 已服',
      '2024-01-01 中午 12:00 服用：二甲双胍 - 已服',
      '2024-01-01 晚上 8:00 服用：辛伐他汀 - 未服',
      '2024-01-02 早上 8:00 服用：阿司匹林 - 未服',
      '2024-01-02 中午 12:00 服用：二甲双胍 - 已服',
    ];
  }

  // 模拟获取异常提醒
  Future<List<String>> getAbnormalReminders() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      '今天下午 6:00 未服药：辛伐他汀',
      '昨天晚上 8:00 未服药：阿司匹林',
      '2024-01-02 早上 8:00 未服药：阿司匹林'
    ];
  }

  // 模拟获取医疗提醒
  Future<List<String>> getMedicationReminders() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      '明天早上 8:00 服用：阿司匹林',
      '明天中午 12:00 服用：二甲双胍',
      '后天晚上 8:00 服用：辛伐他汀'
    ];
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.title, required this.content})
      : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
      ),
    );
  }
}

class Carousel extends StatelessWidget {
  const Carousel({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: const BoxDecoration(color: Colors.grey),
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dataService = DataService();
  late Future<Map<String, dynamic>> _homePageData;

  @override
  void initState() {
    super.initState();
    _homePageData = _dataService.getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _homePageData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 移除 SearchBar
                    //const SearchBar(),
                    //const SizedBox(height: 8),
                    Carousel(images: List<String>.from(data['carouselImages'])),
                    const SizedBox(height: 8),
                    InfoCard(title: '温馨提示', content: data['tips']),
                    const SizedBox(height: 8),
                    InfoCard(
                        title: '温湿度状态',
                        content:
                            '温度: ${data['temperature']}℃  湿度: ${data['humidity']}%'),
                    const SizedBox(height: 8),
                    InfoCard(
                        title: '超时未服提醒',
                        content: '最近超时未服药提醒：${data['lastMedicationReminder']}'),
                    const SizedBox(height: 8),
                    InfoCard(
                        title: '服药时间',
                        content: '下次服药时间：${data['nextMedicationTime']}'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class SmartPillboxPage extends StatelessWidget {
  const SmartPillboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('智能药盒')),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 3, // 每排 3 个模块
        children: <Widget>[
          _buildModule(context, Icons.assignment, '查看处方', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PrescriptionPageDartPad()), // DartPad 处方页
            );
          }),
          _buildModule(context, Icons.history, '查看服药记录', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MedicationRecordPageDartPad()), // DartPad 服药记录页
            );
          }),
          _buildModule(context, Icons.camera, '摄像头控制', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraControlPage()),
            );
          }),
          _buildModule(context, Icons.warning, '异常提醒', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AbnormalReminderPage()),
            );
          }),
          _buildModule(context, Icons.notifications, '医疗提醒', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MedicationReminderPage()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildModule(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40.0),
            const SizedBox(height: 8.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

//数据传递
ValueNotifier<String> selectedMenu = ValueNotifier('个人信息');

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: Row(
        children: [
          // 左侧菜单
          SizedBox(
            width: 200.0,
            child: Column(
              children: [
                ListTile(
                  selected: selectedMenu.value == '个人信息',
                  leading: const Icon(Icons.person),
                  title: const Text('个人信息'),
                  onTap: () {
                    selectedMenu.value = '个人信息';
                  },
                ),
                ListTile(
                  selected: selectedMenu.value == '修改密码',
                  leading: const Icon(Icons.lock),
                  title: const Text('修改密码'),
                  onTap: () {
                    selectedMenu.value = '修改密码';
                  },
                ),
                ListTile(
                  selected: selectedMenu.value == '摄像头管理',
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('摄像头管理'),
                  onTap: () {
                    selectedMenu.value = '摄像头管理';
                  },
                ),
                ListTile(
                  selected: selectedMenu.value == '我的提醒',
                  leading: const Icon(Icons.notifications_active),
                  title: const Text('我的提醒'),
                  onTap: () {
                    selectedMenu.value = '我的提醒';
                  },
                ),
                ListTile(
                  selected: selectedMenu.value == '购买记录',
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('购买记录'),
                  onTap: () {
                    selectedMenu.value = '购买记录';
                  },
                ),
                ListTile(
                  selected: selectedMenu.value == '联系我们',
                  leading: const Icon(Icons.phone),
                  title: const Text('联系我们'),
                  onTap: () {
                    selectedMenu.value = '联系我们';
                  },
                ),
              ],
            ),
          ),
          // 右侧内容区域
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: selectedMenu,
              builder: (context, value, child) {
                switch (value) {
                  case '个人信息':
                    return const PersonalInfoPage();
                  case '修改密码':
                    return const ChangePasswordPage();
                  case '摄像头管理':
                    return const CameraManagementPage();
                  case '我的提醒':
                    return const MyReminderPage();
                  case '购买记录':
                    return const PurchaseHistoryPage();
                  case '联系我们':
                    return const ContactUsPage(); // 新增联系我们页面
                  default:
                    return const Center(child: Text('请选择功能'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  // 模拟的个人信息数据
  String nickname = '用户123';
  String gender = '男';
  String age = '35';
  final String phone = '12345678901'; // 手机号不可编辑
  String email = 'user123@example.com';

  // 编辑状态
  bool isNicknameEditing = false;
  bool isGenderEditing = false;
  bool isAgeEditing = false;
  bool isEmailEditing = false;

  // TextEditingController
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nicknameController.text = nickname;
    _genderController.text = gender;
    _ageController.text = age;
    _emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildEditableRow('昵称', nickname, isNicknameEditing, _nicknameController, (newValue) {
              setState(() {
                nickname = newValue;
                isNicknameEditing = false;
              });
            }, () {
              setState(() {
                isNicknameEditing = true;
              });
            }),
            _buildEditableRow('性别', gender, isGenderEditing, _genderController, (newValue) {
              setState(() {
                gender = newValue;
                isGenderEditing = false;
              });
            }, () {
              setState(() {
                isGenderEditing = true;
              });
            }),
            _buildEditableRow('年龄', age, isAgeEditing, _ageController, (newValue) {
              setState(() {
                age = newValue;
                isAgeEditing = false;
              });
            }, () {
              setState(() {
                isAgeEditing = true;
              });
            }),
            ListTile(
              leading: const Text('手机号'),
              title: Text(phone),
            ),
            _buildEditableRow('邮箱', email, isEmailEditing, _emailController, (newValue) {
              setState(() {
                email = newValue;
                isEmailEditing = false;
              });
            }, () {
              setState(() {
                isEmailEditing = true;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableRow(String label, String value, bool isEditing, TextEditingController controller, Function(String) onSaved, VoidCallback onEdit) {
    return ListTile(
      leading: Text(label),
      title: isEditing
          ? Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  onSaved(controller.text);
                }
              },
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none, // 移除 TextField 的边框
                ),
              ),
            )
          : Text(value),
      trailing: isEditing
          ? null
          : IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '原密码',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '新密码',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '确认新密码',
                prefixIcon: Icon(Icons.lock_reset),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (_newPasswordController.text == _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('密码修改成功')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('两次密码不一致')));
                }
              },
              child: const Text('确认修改'),
            ),
          ],
        ),
      ),
    );
  }
}

// 用于存储摄像头信息 (由于 DartPad 限制，无法持久化)
String? rtspAddress;
String? rtspPassword;

class CameraManagementPage extends StatefulWidget {
  const CameraManagementPage({Key? key}) : super(key: key);

  @override
  _CameraManagementPageState createState() => _CameraManagementPageState();
}

class _CameraManagementPageState extends State<CameraManagementPage> {
  final _rtspAddressController = TextEditingController();
  final _rtspPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 初始化时读取已保存的摄像头信息
    _rtspAddressController.text = rtspAddress ?? '';
    _rtspPasswordController.text = rtspPassword ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _rtspAddressController,
              decoration: const InputDecoration(labelText: 'RTSP 地址'),
            ),
            TextField(
              controller: _rtspPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '密码 (可选)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // 保存摄像头信息到内存变量
                  rtspAddress = _rtspAddressController.text;
                  rtspPassword = _rtspPasswordController.text;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('摄像头信息已保存 (临时)')),
                );
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}

class CameraControlPage extends StatelessWidget {
  const CameraControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('摄像头控制')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '视频流 (DartPad 无法真正播放 RTSP)',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  rtspAddress != null
                      ? 'RTSP 地址: $rtspAddress'
                      : '未配置摄像头',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '摄像头控制 (占位按钮)',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('⬆️')),
                ElevatedButton(onPressed: () {}, child: const Text('⬇️')),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('⬅️')),
                ElevatedButton(onPressed: () {}, child: const Text('➡️')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SmartPillboxPage(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: '智能药盒',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: '搜索...',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}

class PrescriptionPageDartPad extends StatelessWidget { // DartPad 版本的处方页
  const PrescriptionPageDartPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('处方信息')),
      body: FutureBuilder<List<Prescription>>(
        future: DataService().getPrescriptions(), // 使用 DataService 获取 Mock 数据
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final prescriptions = snapshot.data!;
            return ListView.builder(
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                final prescription = prescriptions[index];
                return ExpansionTile( // 使用 ExpansionTile
                  title: Text('${prescription.medicine}'), // 药物名作为标题
                  subtitle: Text('服药时间: ${prescription.time}'), // 服药时间作为副标题
                  children: <Widget>[ // 展开后显示详细信息
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          '药物: ${prescription.medicine}\n时间: ${prescription.time}'), // 详细信息
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MedicationRecordPageDartPad extends StatelessWidget { // DartPad 版本的服药记录页
  const MedicationRecordPageDartPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('服药记录')),
      body: FutureBuilder<List<String>>(
        future: DataService().getMedicationRecords(), // 使用 DataService 获取 Mock 数据
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final records = snapshot.data!;
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                final parts = record.split(' - '); // 分割字符串
                final medicationInfo = parts[0];
                final status = parts[1];

                return Card( // 使用 Card 包裹
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(medicationInfo), // 药物信息作为标题
                    trailing: Text(status, style: TextStyle(fontWeight: FontWeight.bold, color: status == '已服' ? Colors.green : Colors.red)), // 服药状态
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class AbnormalReminderPage extends StatelessWidget {
  const AbnormalReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('异常提醒')),
      body: FutureBuilder<List<String>>(
        future: DataService().getAbnormalReminders(), // 使用 DataService 获取 Mock 数据
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final reminders = snapshot.data!;
            return ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(reminders[index]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MedicationReminderPage extends StatelessWidget {
  const MedicationReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('医疗提醒')),
      body: FutureBuilder<List<String>>(
        future: DataService().getMedicationReminders(), // 使用 DataService 获取 Mock 数据
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final reminders = snapshot.data!;
            return ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(reminders[index]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// 数据模型
class Prescription {
  final String time;
  final String medicine;

  Prescription({required this.time, required this.medicine});
}

// 模拟短信提醒次数数据 (临时存储)
class ReminderData {
  static int totalReminders = 100; // 假设总共 100 次
  static int usedReminders = 30;   // 假设已使用 30 次
  static int get remainingReminders => totalReminders - usedReminders;
  static List<PurchaseRecord> purchaseHistory = []; // 购买记录列表
}

class PurchaseRecord {
  final DateTime purchaseTime;
  final int reminderCount;
  final double amount;

  PurchaseRecord({required this.purchaseTime, required this.reminderCount, required this.amount});
}


class MyReminderPage extends StatefulWidget {
  const MyReminderPage({Key? key}) : super(key: key);

  @override
  _MyReminderPageState createState() => _MyReminderPageState();
}

class _MyReminderPageState extends State<MyReminderPage> {
  int? _selectedPackageCount; // 存储选中的套餐次数
  double? _selectedPackagePrice; // 存储选中的套餐价格
  bool _isPayButtonEnabled = false; // 控制去支付按钮是否可用

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的提醒')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InfoCard(
                title: '短信提醒次数',
                content: '共计 ${ReminderData.totalReminders} 次，已用 ${ReminderData.usedReminders} 次，剩余 ${ReminderData.remainingReminders} 次'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showPurchaseOptions(context);
              },
              child: const Text('购买加油包'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPurchaseOptions(BuildContext context) {
    setState(() { // 初始化时禁用按钮
      _isPayButtonEnabled = false;
      _selectedPackageCount = null;
      _selectedPackagePrice = null;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('购买短信加油包'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('100次/10元'),
                onTap: () {
                  setState(() {
                    _selectedPackageCount = 100;
                    _selectedPackagePrice = 10.0;
                    _isPayButtonEnabled = true; // 选中套餐后启用按钮
                  });
                },
                selected: _selectedPackageCount == 100, // 高亮选中项
                selectedTileColor: Colors.blue.shade100,
              ),
              ListTile(
                title: const Text('1000次/100元'),
                onTap: () {
                  setState(() {
                    _selectedPackageCount = 1000;
                    _selectedPackagePrice = 100.0;
                    _isPayButtonEnabled = true; // 选中套餐后启用按钮
                  });
                },
                selected: _selectedPackageCount == 1000, // 高亮选中项
                selectedTileColor: Colors.blue.shade100,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('关闭'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() { // 清空选择并禁用按钮
                  _selectedPackageCount = null;
                  _selectedPackagePrice = null;
                  _isPayButtonEnabled = false;
                });
              },
            ),
            ElevatedButton(
              onPressed: _isPayButtonEnabled ? () { // 使用 _isPayButtonEnabled 控制按钮状态
                Navigator.pop(context); // 关闭套餐选择弹窗
                _showAlipayQRCode(context, _selectedPackageCount!, _selectedPackagePrice!); // 显示支付二维码弹窗
              } : null, // 禁用状态
              child: const Text('去支付'),
            ),
          ],
        );
      },
    );
  }

  void _showAlipayQRCode(BuildContext context, int count, double price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('支付宝支付'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 模拟支付宝二维码，使用随机图片 URL
              Image.network(
                'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=mock_payment_data_${Random().nextInt(1000)}',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 10),
              Text('请使用支付宝扫码支付 ${price} 元'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消支付'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() { // 清空选择并禁用按钮
                  _selectedPackageCount = null;
                  _selectedPackagePrice = null;
                  _isPayButtonEnabled = false;
                });
              },
            ),
            ElevatedButton(
              child: const Text('确认支付'),
              onPressed: () {
                Navigator.of(context).pop(); // 关闭支付弹窗
                _purchasePackage(context, count, price); // 完成购买
                setState(() { // 清空选择并禁用按钮
                  _selectedPackageCount = null;
                  _selectedPackagePrice = null;
                  _isPayButtonEnabled = false;
                });
              },
            ),
          ],
        );
      },
    );
  }


  void _purchasePackage(BuildContext context, int count, double price) {
    setState(() {
      ReminderData.totalReminders += count;
      ReminderData.purchaseHistory.add(PurchaseRecord(
          purchaseTime: DateTime.now(), reminderCount: count, amount: price)); // 添加购买记录
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('成功购买 $count 次短信提醒')),
    );
  }
}


class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('购买记录')),
      body: ReminderData.purchaseHistory.isEmpty
          ? const Center(child: Text('暂无购买记录'))
          : ListView.builder(
              itemCount: ReminderData.purchaseHistory.length,
              itemBuilder: (context, index) {
                final record = ReminderData.purchaseHistory[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('购买时间: ${record.purchaseTime.toString()}'),
                        Text('购买次数: ${record.reminderCount} 次'),
                        Text('支付金额: ${record.amount} 元'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('联系我们')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // 关键: 使用 min 确保 Card 包裹内容
              children: [
                const Text('联系客服', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.blueGrey),
                    const SizedBox(width: 8.0),
                    SelectableText('12345678901', style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.email, color: Colors.blueGrey),
                    const SizedBox(width: 8.0),
                    SelectableText('service@example.com', style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text('工作时间：', style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('周一至周五 9:00 - 18:00'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
