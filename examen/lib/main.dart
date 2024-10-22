import 'package:flutter/material.dart';

class Usuario {
  final String nombre;
  final String login;
  final String password;
  final String email;

  Usuario({
    required this.nombre,
    required this.login,
    required this.password,
    required this.email,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _intentos = 0;

  
  final List<Usuario> _usuarios = [
    Usuario(
      nombre: "Julio Anguiano",
      login: "Janguiano",
      password: "123456",
     email: "janguiano25@ucol.mx",
    ),
    Usuario(
      nombre: "Gael Espindola",
      login: "Gespindola",
      password: "654321",
      email: "Gespindola25@ucol.mx",
    ),
  ];

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _intentos++;
      });

      
      Usuario? usuarioEncontrado = _usuarios.firstWhere(
        (usuario) =>
            usuario.login == _loginController.text &&
            usuario.password == _passwordController.text,
        orElse: () => Usuario(
          nombre: "",
          login: "",
          password: "",
          email: "",
        ),
      );

      if (usuarioEncontrado.nombre.isNotEmpty) {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(usuario: usuarioEncontrado),
          ),
        );
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuario o contraseña incorrectos'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda parcial Examen'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Inicio de sesión',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(
                  labelText: 'Login',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su login';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Entrar'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Intentos: $_intentos'),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final Usuario usuario;

  const WelcomeScreen({
    super.key,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del usuario'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Login del usuario: ${usuario.login}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Nombre completo: ${usuario.nombre}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}