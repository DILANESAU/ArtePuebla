import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 86, 7, 12), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Crea una cuenta',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: '¿Ya tienes una cuenta? ',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.0,
                      ),
                      children: [
                        TextSpan(
                          text: 'Inicia sesión aquí',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          )
                        )
                      ]
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32.0,),
                _buildInputField(label: 'Nombre', hintText: 'Ingresa tu nombre completo'),
                const SizedBox(height: 16.0,),
                _buildInputField(label: 'Email', hintText: 'Ingresa tu email', keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16.0,),
                _buildInputField(label: 'Contraseña', hintText: 'Crea una contraseña', obscureText: true),
                const SizedBox(height: 32.0,),
                ElevatedButton(onPressed: () {
                  //logica de registro
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A90E2),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                 child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                 ),),
                 const SizedBox(height: 16.0,),
                 TextButton(onPressed: () {
                  //Logica para ayuda o mas informacion
                 }, child: const Text('¿Necesitas ayuda?', style: TextStyle(color: Colors.black54, fontSize: 14.0),))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildInputField({
    required String label,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0,),
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.white.withOpacity(0.15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 16.0
            ),
          ),
          style: const TextStyle(color:Colors.white),
        ),
      ],
    );
  }
}