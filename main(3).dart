import 'dart:math';
import 'package:flutter/material.dart';
void main() {
  AppData.initialize();
  runApp(const ElectroShop());
}
class Product {
  String name;
  String category;
  double price;
  double oldPrice;
  String image;
  double rating;
  String description;
  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.oldPrice,
    required this.image,
    required this.rating,
    required this.description,
  });
}
class CartItem {
  Product product;
  int quantity;
  CartItem({
    required this.product,
    this.quantity = 1,
  });
  double get total => product.price * quantity;
}
class AppData {
  static List<CartItem> cart = [];
  static List<Product> favourites = [];
  static List<Map<String, dynamic>> orders = [];
  static String customerName = 'Vijay Prajapati';
  static String customerEmail = 'vijay@example.com';
  static List<Product> products = [
    Product(name: 'Apple iPhone 18 Pro', category: 'Mobiles', price: 164900, oldPrice: 169900, image: 'https://images.unsplash.com/photo-1592286927505-2fd0e2e3a5d0?w=600', rating: 4.8, description: 'Latest iPhone Pro with premium display and advanced cameras.'),
    Product(name: 'Samsung Galaxy S26 Ultra', category: 'Mobiles', price: 139999, oldPrice: 149999, image: 'https://images.unsplash.com/photo-1610945264803-c22b62d2a7b5?w=600', rating: 4.8, description: 'Samsung flagship with premium display and powerful performance.'),
    Product(name: 'Apple MacBook Air M4', category: 'Laptops', price: 89990, oldPrice: 99900, image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600', rating: 4.8, description: 'Thin and powerful laptop for study, coding and work.'),
    Product(name: 'ASUS ROG Gaming Laptop', category: 'Gaming', price: 99990, oldPrice: 109990, image: 'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=700', rating: 4.7, description: 'Gaming laptop with powerful performance and graphics.'),
    Product(name: 'Apple iPad 11th Gen', category: 'Tablets', price: 34900, oldPrice: 39900, image: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600', rating: 4.7, description: 'Versatile tablet for study, notes and entertainment.'),
    Product(name: 'Apple AirPods Pro 3', category: 'Audio', price: 24900, oldPrice: 26900, image: 'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600', rating: 4.7, description: 'Premium wireless earbuds with active noise cancellation.'),
    Product(name: 'Apple Watch Ultra 4', category: 'Wearables', price: 109900, oldPrice: 119900, image: 'https://images.unsplash.com/photo-1551816230-ef5deaed4a26?w=600', rating: 4.8, description: 'Premium smartwatch for fitness and everyday use.'),
    Product(name: 'Logitech MX Master 3S', category: 'Accessories', price: 7499, oldPrice: 8999, image: 'https://images.unsplash.com/photo-1527814050087-3793815479db?w=600', rating: 4.7, description: 'Premium wireless mouse for productivity.'),
    Product(name: 'Canon EOS Mirrorless Camera', category: 'Cameras', price: 69990, oldPrice: 74990, image: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=700', rating: 4.7, description: 'Mirrorless camera for photography and video.'),
    Product(name: 'Google Nest Smart Speaker', category: 'Smart Home', price: 6999, oldPrice: 7999, image: 'https://images.unsplash.com/photo-1558089687-f282ffcbc126?w=700', rating: 4.4, description: 'Smart speaker for music and connected home devices.'),
    Product(name: 'Sony Bravia 55 4K', category: 'TV', price: 64990, oldPrice: 74990, image: 'https://images.unsplash.com/photo-1593784991095-a205069470b6?w=800', rating: 4.5, description: '4K smart TV for movies, sports and entertainment.'),
  ];
  static List<String> categories = [
    'Mobiles', 'Laptops', 'Tablets', 'Audio', 'Wearables',
    'Accessories', 'Gaming', 'Cameras', 'Smart Home', 'TV',
  ];
  static List<Map<String, dynamic>> transactions = [];
  static bool _initialized = false;
  static void initialize() {
    if (_initialized) return;
    _initialized = true;
    for (final p in products) {
      if (p.image.trim().isEmpty || p.image.startsWith('assets/')) {
        p.image = localImageForCategory(p.category);
      }
      if (p.description.trim().isEmpty) {
        p.description = 'Quality ${p.category.toLowerCase()} product with reliable performance, modern design and excellent value for everyday use.';
      }
    }
    final names = <String, List<String>>{
      'Mobiles': ['Pixel Nova 10', 'Galaxy A77 5G', 'Moto Edge Neo', 'Redmi Turbo Max', 'Nothing Phone Pro'],
      'Laptops': ['HP Pavilion Plus', 'Lenovo ThinkBook 15', 'ASUS TUF A16', 'Acer Swift Go', 'MSI Modern 14'],
      'Tablets': ['Lenovo Tab M12', 'Redmi Pad Pro', 'Honor Pad X9', 'OnePlus Pad Go', 'Realme Pad 3'],
      'Audio': ['JBL Tune 780', 'boAt Airdopes 500', 'Sony WH-CH720N', 'Marshall Major V', 'JBL Live Buds 3'],
      'Wearables': ['Apple Watch SE', 'Galaxy Watch FE', 'CMF Watch 3', 'Amazfit Active 2', 'Fitbit Versa 5'],
      'Accessories': ['Belkin 65W Charger', 'Anker USB-C Hub', 'Logitech K380 Keyboard', 'HP Wireless Mouse', 'SanDisk 1TB SSD'],
      'Gaming': ['PlayStation 5 Slim', 'Xbox Series X', 'Nintendo Switch OLED', 'Razer BlackShark V2', 'SteelSeries Apex 5'],
      'Cameras': ['Sony Alpha A7 V', 'Canon EOS R8', 'Nikon Z6 III', 'Fujifilm X-T6', 'GoPro Hero 14'],
      'Smart Home': ['Echo Smart Speaker', 'Google Nest Hub', 'Philips Smart Bulb', 'TP-Link Smart Plug', 'Mi Smart Camera'],
      'TV': ['Sony Bravia 55 4K', 'Samsung Crystal 55', 'LG OLED 48', 'TCL QLED 65', 'OnePlus TV 55'],
    };
    int seed = 1;
    for (final entry in names.entries) {
      for (final name in entry.value) {
        if (products.any((p) => p.name == name)) continue;
        final price = 1499.0 + ((seed * 2713) % 120000);
        products.add(Product(
          name: name,
          category: entry.key,
          price: price,
          oldPrice: price * 1.12,
          image: localImageForCategory(entry.key),
          rating: 4.1 + ((seed % 9) / 10),
          description: '${name} is a reliable ${entry.key.toLowerCase()} product with modern features, premium build quality and smooth everyday performance. Ideal for home, study, office and entertainment.',
        ));
        seed++;
      }
    }
    while (products.length < 100) {
      final category = categories[products.length % categories.length];
      final n = products.length + 1;
      final price = 999.0 + ((n * 1837) % 90000);
      products.add(Product(
        name: 'ElectroShop ${category} ${n}',
        category: category,
        price: price,
        oldPrice: price * 1.15,
        image: localImageForCategory(category),
        rating: 4.2,
        description: 'ElectroShop ${category.toLowerCase()} product with dependable quality, modern design and excellent everyday performance.',
      ));
    }
  }
  static String localImageForCategory(String category) {
    switch (category) {
      case 'Mobiles':
        return 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800';
      case 'Laptops':
        return 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800';
      case 'Tablets':
        return 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=800';
      case 'Audio':
        return 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800';
      case 'Wearables':
        return 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800';
      case 'Accessories':
        return 'https://images.unsplash.com/photo-1527814050087-3793815479db?w=800';
      case 'Gaming':
        return 'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?w=800';
      case 'Cameras':
        return 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800';
      case 'Smart Home':
        return 'https://images.unsplash.com/photo-1558008258-3256797b43f3?w=800';
      case 'TV':
        return 'https://images.unsplash.com/photo-1593784991095-a205069470b6?w=800';
      default:
        return 'https://images.unsplash.com/photo-1557825835-70d97c4aa567?w=800';
    }
  }
  static double cartTotal() {
    double total = 0;
    for (final item in cart) total += item.total;
    return total;
  }
  static void addToCart(Product product) {
    for (final item in cart) {
      if (item.product.name == product.name) { item.quantity++; return; }
    }
    cart.add(CartItem(product: product));
  }
  static void removeFromCart(Product product) {
    cart.removeWhere((item) => item.product.name == product.name);
  }
  static void decreaseQuantity(Product product) {
    for (final item in cart) {
      if (item.product.name == product.name) {
        if (item.quantity > 1) item.quantity--; else cart.remove(item);
        return;
      }
    }
  }
  static bool isFavourite(Product product) => favourites.any((p) => p.name == product.name);
  static void toggleFavourite(Product product) {
    if (isFavourite(product)) favourites.removeWhere((p) => p.name == product.name);
    else favourites.add(product);
  }
  static bool canCancel(Map<String, dynamic> order) {
    final status = '${order['status']}';
    return status != 'Cancelled' && status != 'Delivered' && status != 'Out for Delivery';
  }
  static void cancelOrder(Map<String, dynamic> order, String reason) {
    order['status'] = 'Cancelled';
    order['cancelReason'] = reason;
    order['cancelledAt'] = DateTime.now().toString().substring(0, 16);
    transactions.insert(0, {
      'id': 'TXN-C${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      'orderId': order['id'],
      'type': 'Cancellation',
      'amount': order['total'],
      'payment': order['payment'],
      'status': 'Refund / Cancellation Recorded',
      'date': order['cancelledAt'],
    });
  }
}
const navy = Color(0xFF081B4B);
const blue = Color(0xFF2457E6);
const lightBlue = Color(0xFFEAF0FF);
const pageBg = Color(0xFFF5F7FC);
class ElectroShop extends StatelessWidget {
  const ElectroShop({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VES ELECTRONICS SHOP',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBg,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: navy,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
class ProductImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? radius;
  const ProductImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.radius,
  });
  @override
  Widget build(BuildContext context) {
    Widget image;
    if (url.startsWith('assets/')) {
      image = Image.asset(
        url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _fallback(),
      );
    } else {
      image = Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : SizedBox(width: width, height: height, child: const Center(child: CircularProgressIndicator(strokeWidth: 2))),
        errorBuilder: (_, __, ___) => _fallback(),
      );
    }
    if (radius != null) image = ClipRRect(borderRadius: radius!, child: image);
    return image;
  }
  Widget _fallback() => Container(
    width: width,
    height: height,
    color: const Color(0xFFF0F3FA),
    alignment: Alignment.center,
    child: const Icon(Icons.devices_other_rounded, size: 42, color: blue),
  );
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1300), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.shopping_cart_checkout_rounded,
                size: 52,
                color: blue,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'VES ELECTRONICS SHOP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'AAJ KHARIDO KAL PAISA DO',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 45),
            const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool adminLogin = false;
  bool obscure = true;
  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      _message('Enter email and password');
      return;
    }
    if (adminLogin) {
      if (email == 'admin@electroshop.com' && password == 'admin123') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminDashboard()),
        );
      } else {
        _message('Admin login: admin@electroshop.com / admin123');
      }
    } else {
      AppData.customerEmail = email;
      AppData.customerName =
      email.split('@').first.isEmpty ? 'Customer' : email.split('@').first;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }
  void _message(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
  void signup() {
    final name = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Create Customer Account'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Full name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (name.text.trim().isEmpty ||
                  email.text.trim().isEmpty ||
                  password.text.length < 6) {
                _message('Fill all details. Password must be 6+ characters.');
                return;
              }
              AppData.customerName = name.text.trim();
              AppData.customerEmail = email.text.trim();
              Navigator.pop(context);
              _message('Account created. You can login now.');
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 25, 22, 30),
            child: Column(
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: navy,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_checkout_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 5),
                const Text('Login to continue shopping'),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _loginTab(
                          'Customer',
                          !adminLogin,
                              () => setState(() => adminLogin = false),
                        ),
                      ),
                      Expanded(
                        child: _loginTab(
                          'Admin',
                          adminLogin,
                              () => setState(() => adminLogin = true),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: adminLogin ? 'Admin email' : 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: passwordController,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => obscure = !obscure),
                      icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _message('Password reset request created'),
                    child: const Text('Forgot Password?'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: login,
                    style: FilledButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      adminLogin ? 'ADMIN LOGIN' : 'LOGIN',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (!adminLogin) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: signup,
                      child: const Text('CREATE ACCOUNT'),
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                Text(
                  adminLogin
                      ? 'Admin access: manage products, prices and stock'
                      : 'Secure shopping experience',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _loginTab(String title, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? navy : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : navy,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String selectedCategory = 'All';
  String searchText = '';
  void addProduct(Product product) {
    setState(() => AppData.addToCart(product));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        action: SnackBarAction(
          label: 'VIEW CART',
          onPressed: () => setState(() => selectedIndex = 3),
        ),
      ),
    );
  }
  void toggleFavourite(Product product) {
    setState(() => AppData.toggleFavourite(product));
  }
  void openProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailsPage(
          product: product,
          onChanged: () => setState(() {}),
        ),
      ),
    );
  }
  List<Product> get filtered {
    return AppData.products.where((p) {
      final cat = selectedCategory == 'All' || p.category == selectedCategory;
      final search = p.name.toLowerCase().contains(searchText.toLowerCase());
      return cat && search;
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    final titles = ['VES ELECTRONICS SHOP', 'Categories', 'Favorites', 'My Cart', 'Profile'];
    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.shopping_cart_checkout_rounded, color: blue),
            const SizedBox(width: 8),
            Text(
              titles[selectedIndex],
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
        ),
        actions: [
          if (selectedIndex != 2)
            IconButton(
              tooltip: 'Favorites',
              onPressed: () => setState(() => selectedIndex = 2),
              icon: Badge(
                isLabelVisible: AppData.favourites.isNotEmpty,
                label: Text('${AppData.favourites.length}'),
                child: const Icon(Icons.favorite_border_rounded),
              ),
            ),
          IconButton(
            tooltip: 'Cart',
            onPressed: () => setState(() => selectedIndex = 3),
            icon: Badge(
              isLabelVisible: AppData.cart.isNotEmpty,
              label: Text('${AppData.cart.length}'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          homeBody(),
          categoriesBody(),
          favouritesBody(),
          cartBody(),
          profileBody(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
  Widget homeBody() {
    final products = filtered;
    return RefreshIndicator(
      onRefresh: () async => setState(() {}),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 25),
        children: [
          const Text(
            'Find your next favourite',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'PAISE NHI TOH EMI PE KHARIDE',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (v) => setState(() => searchText = v),
            decoration: const InputDecoration(
              hintText: 'Search for products...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          _heroBanner(),
          const SizedBox(height: 18),
          _sectionTitle('Categories', 'See All', () => setState(() => selectedIndex = 1)),
          const SizedBox(height: 10),
          SizedBox(
            height: 115,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                categoryCard('All', _categoryImage('Mobiles')),
                ...AppData.categories.map((c) => categoryCard(c, _categoryImage(c))),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _spinBanner(),
          const SizedBox(height: 20),
          _sectionTitle('Best Deals', '${products.length} items', null),
          const SizedBox(height: 10),
          if (products.isEmpty)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Center(child: Text('No products found')),
            ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: .58,
            ),
            itemBuilder: (_, i) => productCard(products[i]),
          ),
          const SizedBox(height: 30),
          _footer(),
        ],
      ),
    );
  }
  Widget _footer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 26),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 52, height: 52, decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.shopping_cart, color: Colors.white, size: 28)),
            const SizedBox(width: 12),
            const Text('VES ELECTRONICS SHOP', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800)),
          ]),
          const SizedBox(height: 12),
          const Text('PUSHPA MAAM IS THE BEST', style: TextStyle(color: Colors.white70, height: 1.4)),
          const SizedBox(height: 18),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          const Text('Quick Links', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Home  •  Categories  •  Favorites  •  Orders  •  Support', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 14),
          const Text('Secure payments  •  Easy returns  •  Fast delivery', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 10),
          const Text('© 2026 ElectroShop. All rights reserved.', style: TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }
  Widget _heroBanner() {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: navy,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'APNE PAISE UDANA KE SAMAY AA CHUKA HAI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'LE KAM DAAM SABSE SASTA YAHA MILEGA',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 15),
          Text(
            'SHOP NOW  →',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  Widget _spinBanner() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SpinWinPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [navy, blue]),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: Colors.white24,
              child: Icon(Icons.card_giftcard_rounded, color: Colors.white),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QUIZ & WIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Answer a question and unlock up to 20% OFF.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }
  Widget _sectionTitle(String title, String? right, VoidCallback? action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        if (right != null)
          TextButton(
            onPressed: action,
            child: Text(
              right,
              style: const TextStyle(
                color: blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
  String _categoryImage(String category) {
    for (final p in AppData.products) {
      if (p.category == category) return p.image;
    }
    return AppData.products.first.image;
  }
  Widget categoryCard(String name, String image) {
    final selected = selectedCategory == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = name;
          selectedIndex = 0;
        });
      },
      child: Container(
        width: 105,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? lightBlue : Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: selected ? blue : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ProductImage(
                url: image,
                width: 70,
                height: 65,
                fit: BoxFit.contain,
                radius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
  Widget productCard(Product product) {
    final discount = product.oldPrice > product.price
        ? ((product.oldPrice - product.price) / product.oldPrice * 100).round()
        : 0;
    final fav = AppData.isFavourite(product);
    return GestureDetector(
      onTap: () => openProduct(product),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 145,
                  width: double.infinity,
                  child: ProductImage(
                    url: product.image,
                    width: double.infinity,
                    height: 145,
                  ),
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => toggleFavourite(product),
                      icon: Icon(
                        fav ? Icons.favorite : Icons.favorite_border,
                        color: fav ? Colors.red : navy,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              '₹${product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
            Row(
              children: [
                Text(
                  '₹${product.oldPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '$discount% OFF',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.star, size: 15, color: Colors.orange),
                Text(' ${product.rating}', style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.25),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: FilledButton(
                onPressed: () => addProduct(product),
                style: FilledButton.styleFrom(
                  backgroundColor: blue,
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget categoriesBody() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Shop by Category',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        const SizedBox(height: 6),
        const Text('Real product images are used for category cards.'),
        const SizedBox(height: 18),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: AppData.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: .95,
          ),
          itemBuilder: (_, i) {
            final category = AppData.categories[i];
            final image = _categoryImage(category);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                  selectedIndex = 0;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ProductImage(
                        url: image,
                        width: double.infinity,
                        height: 110,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${AppData.products.where((p) => p.category == category).length} products',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
  Widget favouritesBody() {
    final favs = AppData.favourites;
    if (favs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border, size: 80, color: Colors.grey),
            const SizedBox(height: 12),
            const Text(
              'No favourites yet',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text('Tap the heart on a product to save it.'),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () => setState(() => selectedIndex = 0),
              child: const Text('Browse Products'),
            ),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'My Favourites',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: navy),
        ),
        const SizedBox(height: 14),
        ...favs.map(
              (product) => Card(
            color: Colors.white,
            elevation: 0,
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: ProductImage(
                url: product.image,
                width: 70,
                height: 70,
                radius: BorderRadius.circular(12),
              ),
              title: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('₹${product.price.toStringAsFixed(0)}'),
              trailing: IconButton(
                onPressed: () => setState(() => AppData.toggleFavourite(product)),
                icon: const Icon(Icons.favorite, color: Colors.red),
              ),
              onTap: () => openProduct(product),
            ),
          ),
        ),
      ],
    );
  }
  Widget cartBody() {
    if (AppData.cart.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag_outlined, size: 85, color: Colors.grey),
            const SizedBox(height: 12),
            const Text(
              'Your Cart is Empty',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => setState(() => selectedIndex = 0),
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(14),
            itemCount: AppData.cart.length,
            itemBuilder: (_, i) {
              final item = AppData.cart[i];
              return Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ProductImage(
                        url: item.product.image,
                        width: 85,
                        height: 85,
                        radius: BorderRadius.circular(12),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${item.product.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: navy,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => setState(
                                        () => AppData.decreaseQuantity(item.product),
                                  ),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  onPressed: () => setState(
                                        () => AppData.addToCart(item.product),
                                  ),
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '₹${item.total.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          IconButton(
                            onPressed: () => setState(
                                  () => AppData.removeFromCart(item.product),
                            ),
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    Text(
                      '₹${AppData.cartTotal().toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        color: navy,
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CheckoutPage()),
                  ).then((_) => setState(() {}));
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget profileBody() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 14),
        const CircleAvatar(
          radius: 52,
          backgroundColor: lightBlue,
          child: Icon(Icons.person, size: 62, color: blue),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            AppData.customerName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ),
        Center(child: Text(AppData.customerEmail)),
        const SizedBox(height: 25),
        profileTile(
          Icons.receipt_long_outlined,
          'My Orders',
              () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OrdersPage()),
          ),
        ),
        profileTile(
          Icons.favorite_border,
          'My Favourites',
              () => setState(() => selectedIndex = 2),
        ),
        profileTile(
          Icons.local_offer_outlined,
          'My Coupon',
              () => _message('Available coupon: WIN15'),
        ),
        profileTile(
          Icons.location_on_outlined,
          'Delivery Address',
              () => _message('Add your address during checkout'),
        ),
        profileTile(
          Icons.help_outline,
          'Help & Support',
              () => _message('Support: support@electroshop.com'),
        ),
        profileTile(
          Icons.logout,
          'Logout',
              () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
          ),
        ),
      ],
    );
  }
  Widget profileTile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: lightBlue,
          child: Icon(icon, color: blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final VoidCallback onChanged;
  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.onChanged,
  });
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}
class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool get favourite => AppData.isFavourite(widget.product);
  void addToCart() {
    setState(() => AppData.addToCart(widget.product));
    widget.onChanged();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product added to cart')),
    );
  }
  @override
  Widget build(BuildContext context) {
    final related = AppData.products
        .where(
          (p) =>
      p.category == widget.product.category &&
          p.name != widget.product.name,
    )
        .take(6)
        .toList();
    final discount = widget.product.oldPrice > widget.product.price
        ? ((widget.product.oldPrice - widget.product.price) /
        widget.product.oldPrice *
        100)
        .round()
        : 0;
    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => AppData.toggleFavourite(widget.product));
              widget.onChanged();
            },
            icon: Icon(
              favourite ? Icons.favorite : Icons.favorite_border,
              color: favourite ? Colors.red : navy,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckoutPage()),
            ),
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 25),
        children: [
          Container(
            height: 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ProductImage(
              url: widget.product.image,
              width: double.infinity,
              height: 270,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 19),
              Text(' ${widget.product.rating}  •  ${widget.product.category}'),
              const Spacer(),
              if (discount > 0)
                Text(
                  '$discount% OFF',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '₹${widget.product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  color: navy,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '₹${widget.product.oldPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'About this product',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 7),
          Text(
            widget.product.description,
            style: const TextStyle(height: 1.5, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() => AppData.toggleFavourite(widget.product));
                    widget.onChanged();
                  },
                  icon: Icon(
                    favourite ? Icons.favorite : Icons.favorite_border,
                    color: favourite ? Colors.red : navy,
                  ),
                  label: Text(favourite ? 'Saved' : 'Add to Favourite'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: addToCart,
                  child: const Text('Add to Cart'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () {
                    AppData.addToCart(widget.product);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutPage()));
                  },
                  child: const Text('Buy Now'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Related Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 225,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: related.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final p = related[i];
                return SizedBox(
                  width: 155,
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsPage(
                              product: p,
                              onChanged: widget.onChanged,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ProductImage(
                                url: p.image,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              p.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹${p.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: navy,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override State<AdminDashboard> createState() => _AdminDashboardState();
}
class _AdminDashboardState extends State<AdminDashboard> {
  int tab=0; String search=''; String category='All';
  List<Product> get visibleProducts=>AppData.products.where((p)=>(category=='All'||p.category==category)&&p.name.toLowerCase().contains(search.toLowerCase())).toList();
  void addProductDialog(){
    final name=TextEditingController(),cat=TextEditingController(text:'Accessories'),price=TextEditingController(),old=TextEditingController(),image=TextEditingController(),rating=TextEditingController(text:'4.5'),desc=TextEditingController();
    showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Add New Product'),content:SizedBox(width:430,child:SingleChildScrollView(child:Column(children:[_field(name,'Product name'),_field(cat,'Category'),_field(price,'Selling price'),_field(old,'Old price'),_field(image,'Image URL (optional)'),_field(rating,'Rating'),_field(desc,'Description',max:3)]))),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Cancel')),FilledButton(onPressed:(){if(name.text.trim().isEmpty||double.tryParse(price.text)==null){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Enter product name and valid price')));return;}final c=cat.text.trim().isEmpty?'Accessories':cat.text.trim();final p=Product(name:name.text.trim(),category:c,price:double.parse(price.text),oldPrice:double.tryParse(old.text)??double.parse(price.text)*1.12,image:image.text.trim().isEmpty?AppData.localImageForCategory(c):image.text.trim(),rating:double.tryParse(rating.text)??4.5,description:desc.text.trim().isEmpty?'Quality ${c.toLowerCase()} product with reliable performance and modern features.':desc.text.trim());setState((){AppData.products.add(p);if(!AppData.categories.contains(c))AppData.categories.add(c);});Navigator.pop(context);},child:const Text('ADD PRODUCT'))]));
  }
  void editProduct(Product p){final price=TextEditingController(text:p.price.toStringAsFixed(0)),old=TextEditingController(text:p.oldPrice.toStringAsFixed(0)),image=TextEditingController(text:p.image),desc=TextEditingController(text:p.description);showDialog(context:context,builder:(_)=>AlertDialog(title:Text('Edit ${p.name}'),content:SingleChildScrollView(child:Column(children:[_field(price,'Selling price'),_field(old,'Old price'),_field(image,'Image URL'),_field(desc,'Description',max:5)])),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Cancel')),FilledButton(onPressed:(){setState((){p.price=double.tryParse(price.text)??p.price;p.oldPrice=double.tryParse(old.text)??p.oldPrice;p.image=image.text.trim().isEmpty?AppData.localImageForCategory(p.category):image.text.trim();p.description=desc.text.trim().isEmpty?p.description:desc.text.trim();});Navigator.pop(context);},child:const Text('SAVE'))]));}
  void deleteProduct(Product p) async {
    final ok = await showDialog<bool>(context: context, builder: (_) => AlertDialog(title: const Text('Delete Product?'), content: Text('Remove ${p.name} from the catalogue?'), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete'))]));
    if (ok == true) { setState(() => AppData.products.remove(p)); }
  }
  Widget _field(TextEditingController c,String label,{int max=1})=>Padding(padding:const EdgeInsets.only(bottom:9),child:TextField(controller:c,maxLines:max,keyboardType:(label.contains('price')||label=='Rating')?TextInputType.number:TextInputType.text,decoration:InputDecoration(labelText:label)));
  void updateOrder(Map<String,dynamic> o,String status){setState((){o['status']=status;if(status=='Approved'){o['estimatedDelivery']=DateTime.now().add(const Duration(days:5)).toString().substring(0,10);}if(status=='Shipped'){o['estimatedDelivery']=DateTime.now().add(const Duration(days:3)).toString().substring(0,10);}AppData.transactions.insert(0,{'id':'TXN-S${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}','orderId':o['id'],'type':'Status Update','amount':o['total'],'payment':o['payment'],'status':status,'date':DateTime.now().toString().substring(0,16),'customer':o['customerName']});});}
  void adminCancel(Map<String,dynamic> o){if(!AppData.canCancel(o))return;setState(()=>AppData.cancelOrder(o,'Cancelled by admin'));}
  @override Widget build(BuildContext context){return Scaffold(backgroundColor:pageBg,appBar:AppBar(title:const Text('Admin Control Center',style:TextStyle(fontWeight:FontWeight.w800)),actions:[IconButton(onPressed:()=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>const LoginScreen()),(_)=>false),icon:const Icon(Icons.logout))]),body:IndexedStack(index:tab,children:[_productsTab(),_ordersTab(),_transactionsTab()]),bottomNavigationBar:NavigationBar(selectedIndex:tab,onDestinationSelected:(i)=>setState(()=>tab=i),destinations:const[NavigationDestination(icon:Icon(Icons.inventory_2_outlined),selectedIcon:Icon(Icons.inventory_2),label:'Products'),NavigationDestination(icon:Icon(Icons.receipt_long_outlined),selectedIcon:Icon(Icons.receipt_long),label:'Orders'),NavigationDestination(icon:Icon(Icons.account_balance_wallet_outlined),selectedIcon:Icon(Icons.account_balance_wallet),label:'Transactions')]),floatingActionButton:tab==0?FloatingActionButton.extended(onPressed:addProductDialog,backgroundColor:blue,foregroundColor:Colors.white,icon:const Icon(Icons.add),label:const Text('Add Product')):null);}
  Widget _productsTab() {
    final list = visibleProducts;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              Expanded(child: _stat('Products', '${AppData.products.length}', Icons.inventory_2)),
              Expanded(child: _stat('Categories', '${AppData.categories.length}', Icons.grid_view)),
              Expanded(child: _stat('Orders', '${AppData.orders.length}', Icons.receipt_long)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (v) => setState(() => search = v),
            decoration: const InputDecoration(hintText: 'Search products', prefixIcon: Icon(Icons.search)),
          ),
        ),
        SizedBox(
          height: 52,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: [_chip('All'), ...AppData.categories.map(_chip)],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 90),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final p = list[i];
              return Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 9),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(9),
                  leading: ProductImage(url: p.image, width: 65, height: 65, radius: BorderRadius.circular(10)),
                  title: Text(p.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${p.category}\n₹${p.price.toStringAsFixed(0)}  •  ${p.description}', maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(onPressed: () => editProduct(p), icon: const Icon(Icons.edit, color: blue)),
                    IconButton(onPressed: () => deleteProduct(p), icon: const Icon(Icons.delete_outline, color: Colors.red)),
                  ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  Widget _stat(String t, String v, IconData i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: Column(children: [
          Icon(i, color: blue),
          Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(t, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ]),
      ),
    );
  }
  Widget _chip(String v) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: ChoiceChip(label: Text(v), selected: category == v, onSelected: (_) => setState(() => category = v)),
    );
  }
  Widget _ordersTab() {
    if (AppData.orders.isEmpty) return const Center(child: Text('No customer orders yet'));
    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: AppData.orders.length,
      itemBuilder: (_, i) {
        final o = AppData.orders[i];
        return Card(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Icon(Icons.receipt_long, color: blue),
                  const SizedBox(width: 8),
                  Expanded(child: Text('${o['id']} • ${o['customerName']}', style: const TextStyle(fontWeight: FontWeight.bold))),
                  Text('₹${(o['total'] as double).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                ]),
                Text('${o['customerEmail']} • ${o['phone']}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 8),
                Text('Items: ${(o['items'] as List).length} • Payment: ${o['payment']}'),
                Text('Address: ${o['address']}', maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: '${o['status']}',
                  decoration: const InputDecoration(labelText: 'Order status'),
                  items: const ['Pending Approval', 'Approved', 'Packed', 'Shipped', 'Out for Delivery', 'Delivered', 'Cancelled']
                      .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    if (value == 'Cancelled') adminCancel(o); else updateOrder(o, value);
                  },
                ),
                const SizedBox(height: 6),
                Row(children: [
                  Text('Delivery: ${o['estimatedDelivery']}', style: const TextStyle(fontSize: 12)),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailsPage(order: o))),
                    child: const Text('View Bill / Details'),
                  ),
                ]),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _transactionsTab() {
    final list = AppData.transactions;
    if (list.isEmpty) return const Center(child: Text('No transactions yet'));
    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: list.length,
      itemBuilder: (_, i) {
        final t = list[i];
        final cancellation = '${t['type']}'.contains('Cancellation');
        return Card(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 9),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: cancellation ? Colors.red.shade50 : lightBlue,
              child: Icon(cancellation ? Icons.cancel_outlined : Icons.payments_outlined, color: cancellation ? Colors.red : blue),
            ),
            title: Text('${t['type']} • ${t['orderId']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${t['date']}\n${t['payment']} • ${t['status']} • ${t['customer'] ?? ''}'),
            trailing: Text('₹${(t['amount'] as double).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        );
      },
    );
  }
}
class CheckoutPage extends StatefulWidget {
  final String? initialCoupon;
  final int initialDiscountPercent;
  const CheckoutPage({
    super.key,
    this.initialCoupon,
    this.initialDiscountPercent = 0,
  });
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}
class _CheckoutPageState extends State<CheckoutPage> {
  final address = TextEditingController();
  final phone = TextEditingController();
  final coupon = TextEditingController();
  String payment = 'UPI';
  double discount = 0;
  @override
  void initState() {
    super.initState();
    if (widget.initialCoupon != null) {
      coupon.text = widget.initialCoupon!;
    }
    if (widget.initialDiscountPercent > 0) {
      discount = AppData.cartTotal() * widget.initialDiscountPercent / 100;
    }
  }
  void applyCoupon() {
    final value = coupon.text.trim().toUpperCase();
    final match = RegExp(r'^WIN(10|15|20)$').firstMatch(value);
    if (match != null) {
      final percent = int.parse(match.group(1)!);
      setState(() => discount = AppData.cartTotal() * percent / 100);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$value applied - $percent% OFF')),
      );
    } else {
      setState(() => discount = 0);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid coupon. Use WIN10, WIN15 or WIN20.')),
      );
    }
  }
  void placeOrder() {
    if (AppData.cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your cart is empty')));
      return;
    }
    if (address.text.trim().isEmpty || phone.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter delivery address and phone number')));
      return;
    }
    final subtotal = AppData.cartTotal();
    final total = subtotal - discount;
    final now = DateTime.now();
    final id = '#ES${now.millisecondsSinceEpoch.toString().substring(5)}';
    final delivery = now.add(const Duration(days: 5));
    final order = <String, dynamic>{
      'id': id,
      'date': now.toString().substring(0, 16),
      'createdAt': now,
      'total': total,
      'subtotal': subtotal,
      'discount': discount,
      'payment': payment,
      'address': address.text.trim(),
      'phone': phone.text.trim(),
      'status': 'Pending Approval',
      'estimatedDelivery': delivery.toString().substring(0, 10),
      'cancelReason': '',
      'customerName': AppData.customerName,
      'customerEmail': AppData.customerEmail,
      'items': AppData.cart.map((e) => {
        'name': e.product.name,
        'price': e.product.price,
        'quantity': e.quantity,
        'image': e.product.image,
      }).toList(),
    };
    AppData.orders.insert(0, order);
    AppData.transactions.insert(0, {
      'id': 'TXN-${now.millisecondsSinceEpoch.toString().substring(5)}',
      'orderId': id,
      'type': 'Purchase',
      'amount': total,
      'payment': payment,
      'status': 'Order Placed',
      'date': now.toString().substring(0, 16),
      'customer': AppData.customerName,
    });
    final purchasedNames = AppData.cart.map((e) => e.product.name).toSet();
    AppData.favourites.removeWhere((p) => purchasedNames.contains(p.name));
    AppData.cart.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OrderConfirmedPage(order: order)));
  }
  @override
  void dispose() { address.dispose(); phone.dispose(); coupon.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final subtotal = AppData.cartTotal();
    final total = subtotal - discount;
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section('Delivery Address', Icons.location_on_outlined),
          TextField(controller: address, maxLines: 3, decoration: const InputDecoration(hintText: 'House, street, city, pincode', prefixIcon: Icon(Icons.location_on_outlined))),
          const SizedBox(height: 10),
          TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(hintText: 'Phone number', prefixIcon: Icon(Icons.phone_outlined))),
          const SizedBox(height: 20),
          _section('Payment Method', Icons.payment_outlined),
          ...['UPI', 'Credit / Debit Card', 'Cash on Delivery', 'Net Banking'].map((method) => RadioListTile<String>(value: method, groupValue: payment, onChanged: (v) => setState(() => payment = v!), title: Text(method), contentPadding: EdgeInsets.zero)),
          const SizedBox(height: 12),
          _section('Apply Coupon', Icons.local_offer_outlined),
          Row(children: [Expanded(child: TextField(controller: coupon, decoration: const InputDecoration(hintText: 'Enter WIN15'))), const SizedBox(width: 8), FilledButton(onPressed: applyCoupon, child: const Text('Apply'))]),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              _priceRow('Subtotal', subtotal),
              if (discount > 0) _priceRow('Coupon discount', -discount),
              const Divider(height: 25),
              _priceRow('Total Amount', total, bold: true),
            ]),
          ),
          const SizedBox(height: 16),
          SizedBox(height: 54, child: FilledButton(onPressed: placeOrder, child: const Text('PLACE ORDER'))),
        ],
      ),
    );
  }
  Widget _section(String title, IconData icon) => Row(children: [Icon(icon, color: blue), const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))]);
  Widget _priceRow(String label, double value, {bool bold = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)), Text('₹${value.toStringAsFixed(0)}', style: TextStyle(fontSize: bold ? 21 : 15, fontWeight: bold ? FontWeight.w800 : FontWeight.w500, color: value < 0 ? Colors.green : navy))]),
  );
}
class OrderConfirmedPage extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderConfirmedPage({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFF5),
      body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const CircleAvatar(radius: 48, backgroundColor: Colors.green, child: Icon(Icons.check, color: Colors.white, size: 55)),
        const SizedBox(height: 20),
        const Text('Order Confirmed!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text('Your order has been sent to the admin for approval.', textAlign: TextAlign.center),
        const SizedBox(height: 20),
        Container(width: double.infinity, padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)), child: Column(children: [const Text('Order ID'), Text('${order['id']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text('Total: ₹${(order['total'] as double).toStringAsFixed(0)}'), const SizedBox(height: 5), Text('Delivery by: ${order['estimatedDelivery']}')])) ,
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, height: 50, child: FilledButton(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomePage()), (_) => false), child: const Text('CONTINUE SHOPPING'))),
        const SizedBox(height: 10),
        SizedBox(width: double.infinity, height: 50, child: OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailsPage(order: order))), child: const Text('VIEW ORDER'))),
      ]))),
    );
  }
}
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});
  @override State<OrdersPage> createState() => _OrdersPageState();
}
class _OrdersPageState extends State<OrdersPage> {
  Color statusColor(String status) {
    if (status == 'Delivered') return Colors.green;
    if (status == 'Cancelled') return Colors.red;
    if (status == 'Shipped' || status == 'Out for Delivery') return Colors.orange;
    if (status == 'Approved' || status == 'Packed') return blue;
    return Colors.deepOrange;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: AppData.orders.isEmpty ? const Center(child: Text('No orders yet')) : ListView.builder(
        padding: const EdgeInsets.all(14), itemCount: AppData.orders.length,
        itemBuilder: (_, i) {
          final o = AppData.orders[i]; final status = '${o['status']}';
          return Card(color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 12), child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailsPage(order: o))).then((_) => setState(() {})),
            child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [const Icon(Icons.receipt_long, color: blue), const SizedBox(width: 8), Expanded(child: Text('${o['id']}', style: const TextStyle(fontWeight: FontWeight.bold))), Text('₹${(o['total'] as double).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800))]),
              const SizedBox(height: 8),
              Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: statusColor(status).withOpacity(.12), borderRadius: BorderRadius.circular(20)), child: Text(status, style: TextStyle(color: statusColor(status), fontWeight: FontWeight.bold, fontSize: 12))), const Spacer(), Text('Delivery: ${o['estimatedDelivery']}', style: const TextStyle(fontSize: 12, color: Colors.black54))]),
              const SizedBox(height: 6), Text('${(o['items'] as List).length} item type(s) • ${o['payment']} • ${o['date']}', style: const TextStyle(color: Colors.black54, fontSize: 12)),
              if (AppData.canCancel(o)) Align(alignment: Alignment.centerRight, child: TextButton.icon(onPressed: () => _cancel(o), icon: const Icon(Icons.cancel_outlined, color: Colors.red), label: const Text('Cancel Order', style: TextStyle(color: Colors.red)))),
            ])),
          ));
        },
      ),
    );
  }
  void _cancel(Map<String, dynamic> order) async {
    final reason = TextEditingController();
    final ok = await showDialog<bool>(context: context, builder: (_) => AlertDialog(title: const Text('Cancel Order?'), content: TextField(controller: reason, maxLines: 2, decoration: const InputDecoration(labelText: 'Reason (optional)')), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Keep Order')), FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Cancel Order'))]));
    if (ok == true) { setState(() => AppData.cancelOrder(order, reason.text.trim().isEmpty ? 'Cancelled by customer' : reason.text.trim())); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order cancelled and cancellation record created'))); }
  }
}
class OrderDetailsPage extends StatefulWidget {
  final Map<String, dynamic> order;
  const OrderDetailsPage({super.key, required this.order});
  @override State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}
class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final o = widget.order;
    final items = (o['items'] as List).cast<Map<String, dynamic>>();
    final status = '${o['status']}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        actions: [
          IconButton(onPressed: () => _showBill(context), icon: const Icon(Icons.receipt_long)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: navy, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${o['id']}', style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
                const SizedBox(height: 7),
                Text('${o['date']}', style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 12),
                Row(children: [
                  const Text('STATUS  ', style: TextStyle(color: Colors.white70)),
                  Text(status, style: TextStyle(color: status == 'Cancelled' ? Colors.redAccent : Colors.lightGreenAccent, fontWeight: FontWeight.bold)),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _card('Delivery Tracking', [
            const ListTile(leading: Icon(Icons.fact_check, color: blue), title: Text('Order placed'), trailing: Icon(Icons.check_circle, color: Colors.green)),
            ListTile(leading: const Icon(Icons.admin_panel_settings, color: blue), title: const Text('Admin approval'), subtitle: Text(status)),
            ListTile(leading: const Icon(Icons.local_shipping_outlined, color: blue), title: const Text('Estimated delivery'), subtitle: Text('${o['estimatedDelivery']}')),
          ]),
          const SizedBox(height: 12),
          _card('Items', items.map((item) {
            final price = item['price'] as double;
            final qty = item['quantity'] as int;
            return ListTile(
              leading: ProductImage(url: '${item['image']}', width: 52, height: 52),
              title: Text('${item['name']}'),
              subtitle: Text('Qty $qty × ₹${price.toStringAsFixed(0)}'),
              trailing: Text('₹${(price * qty).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            );
          }).toList()),
          const SizedBox(height: 12),
          _card('Delivery & Payment', [
            ListTile(leading: const Icon(Icons.location_on_outlined), title: const Text('Address'), subtitle: Text('${o['address']}\nPhone: ${o['phone']}')),
            ListTile(leading: const Icon(Icons.payment_outlined), title: const Text('Payment'), subtitle: Text('${o['payment']}')),
          ]),
          const SizedBox(height: 12),
          _billCard(o),
          if (AppData.canCancel(o)) ...[
            const SizedBox(height: 14),
            SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _cancel,
                icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                label: const Text('CANCEL ORDER', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
          if (status == 'Cancelled') ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(15)),
              child: Text('Cancellation reason: ${o['cancelReason']}'),
            ),
          ],
        ],
      ),
    );
  }
  Widget _card(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.fromLTRB(15, 8, 15, 4), child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800))),
          ...children,
        ],
      ),
    );
  }
  Widget _billCard(Map<String, dynamic> o) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(children: [
        const Align(alignment: Alignment.centerLeft, child: Text('PRICE DETAILS', style: TextStyle(fontWeight: FontWeight.w800))),
        const SizedBox(height: 10),
        _row('Subtotal', o['subtotal'] as double),
        _row('Discount', -(o['discount'] as double)),
        const Divider(),
        _row('Total Paid', o['total'] as double, bold: true),
      ]),
    );
  }
  Widget _row(String a, double b, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(a, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text('₹${b.toStringAsFixed(0)}', style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.normal, color: b < 0 ? Colors.green : navy)),
      ]),
    );
  }
  void _showBill(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BillPage(order: widget.order)));
  }
  Future<void> _cancel() async {
    final controller = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel Order?'),
        content: TextField(controller: controller, decoration: const InputDecoration(labelText: 'Reason')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Keep')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Cancel')),
        ],
      ),
    );
    if (ok == true) {
      setState(() => AppData.cancelOrder(widget.order, controller.text.trim().isEmpty ? 'Cancelled by customer' : controller.text.trim()));
    }
  }
}
class BillPage extends StatelessWidget {
  final Map<String, dynamic> order;
  const BillPage({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    final items = (order['items'] as List).cast<Map<String, dynamic>>();
    return Scaffold(
      appBar: AppBar(title: const Text('Invoice / Bill')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Text('VES ELECTRONICS SHOP', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: navy))),
                const Center(child: Text('Tax Invoice / Order Bill')),
                const Divider(height: 30),
                Text('Order ID: ${order['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Date: ${order['date']}'),
                Text('Customer: ${order['customerName']}'),
                Text('Phone: ${order['phone']}'),
                const SizedBox(height: 16),
                const Text('ITEMS', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...items.map((item) {
                  final price = item['price'] as double;
                  final qty = item['quantity'] as int;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(children: [
                      Expanded(child: Text('${item['name']}\nQty: $qty')),
                      Text('₹${(price * qty).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ]),
                  );
                }),
                const Divider(height: 25),
                _row('Subtotal', order['subtotal'] as double),
                _row('Discount', -(order['discount'] as double)),
                const Divider(),
                _row('TOTAL', order['total'] as double, bold: true),
                const SizedBox(height: 14),
                Text('Payment: ${order['payment']}'),
                Text('Delivery: ${order['address']}'),
                Text('Expected delivery: ${order['estimatedDelivery']}'),
                const SizedBox(height: 20),
                const Center(child: Text('Thank you for shopping with ElectroShop', style: TextStyle(color: Colors.black54))),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _row(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text('₹${value.toStringAsFixed(0)}', style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.normal, color: value < 0 ? Colors.green : navy)),
      ]),
    );
  }
}
class SpinWinPage extends StatefulWidget {
  const SpinWinPage({super.key});

  @override
  State<SpinWinPage> createState() => _SpinWinPageState();
}

class _SpinWinPageState extends State<SpinWinPage>
    with SingleTickerProviderStateMixin {
  final answer = TextEditingController();

  final List<String> friendImages = [
    'assets/friends/friend1.jpeg',
    'assets/friends/friend3.jpeg',
    'assets/friends/friend4.jpeg',
    'assets/friends/friend5.jpeg',
  ];

  final List<String> funnyMessages = [
    'Bro calculated the discount himself.',
    'Certified back customer.',
    'This customer definitely read the terms and conditions.',
    'Happy Customer',
  ];

  late final AnimationController _spinController;
  bool answered = false;
  bool spun = false;
  bool spinning = false;
  int discount = 0;
  int selectedFriend = 0;
  double rotationTurns = 0;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
  }

  void checkAnswer() {
    if (answer.text.trim() == '9') {
      setState(() => answered = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correct! Now spin the wheel.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ASMIT KO KITNI BACKS AAYI THI??')),
      );
    }
  }

  Future<void> spin() async {
    if (!answered || spinning) return;

    final values = [10, 15, 20];
    final random = Random();
    final won = values[random.nextInt(values.length)];
    final friend = random.nextInt(friendImages.length);

    setState(() {
      spinning = true;
      spun = false;
      discount = won;
      selectedFriend = friend;
      rotationTurns += 5 + random.nextInt(4);
    });

    await _spinController.forward(from: 0);

    if (!mounted) return;

    setState(() {
      spinning = false;
      spun = true;
    });

    _showFunnyResult();
  }

  void _showFunnyResult() {
    if (!mounted || !spun) return;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('YOU WON!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  friendImages[selectedFriend],
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 180,
                    height: 180,
                    color: lightBlue,
                    alignment: Alignment.center,
                    child: const Icon(Icons.person, size: 70, color: blue),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${funnyMessages[selectedFriend]}\n\n$discount% OFF',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your coupon: WIN$discount',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('CLOSE'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                if (AppData.cart.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add a product to your cart first.'),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutPage(
                      initialCoupon: 'WIN$discount',
                      initialDiscountPercent: discount,
                    ),
                  ),
                );
              },
              child: const Text('CLAIM & CHECKOUT'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    answer.dispose();
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navy,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: const Text('Spin & Win'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Answer correctly and unlock your discount',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          const SizedBox(height: 22),
          AnimatedBuilder(
            animation: _spinController,
            builder: (context, child) {
              final angle = rotationTurns * 2 * pi * _spinController.value;
              return Transform.rotate(
                angle: angle,
                child: child,
              );
            },
            child: Center(
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const SweepGradient(
                    colors: [
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.red,
                      Colors.blue,
                    ],
                  ),
                  border: Border.all(color: Colors.white, width: 8),
                ),
                child: Center(
                  child: Container(
                    width: 95,
                    height: 95,
                    decoration: const BoxDecoration(
                      color: navy,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      spun ? '$discount% OFF' : 'SPIN',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'Quiz Time!',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Text('ASMIT KO KITNI BACKS AAYI THI??'),
                const SizedBox(height: 12),
                TextField(
                  controller: answer,
                  enabled: !answered && !spinning,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Your answer',
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: answered || spinning ? null : checkAnswer,
                    child: const Text('CHECK ANSWER'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: answered && !spinning ? spin : null,
              child: Text(spinning ? 'SPINNING...' : 'SPIN AND WIN'),
            ),
          ),
          if (spun) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Text(
                    'Congratulations! You won $discount% OFF.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Coupon: WIN$discount',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      if (AppData.cart.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Add a product to your cart first.'),
                          ),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutPage(
                            initialCoupon: 'WIN$discount',
                            initialDiscountPercent: discount,
                          ),
                        ),
                      );
                    },
                    child: const Text('CLAIM DISCOUNT & CHECKOUT'),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
