class AppConstants {
  // App info
  static const String appName = 'CodeMexDevs';
  static const String appTagline = 'Experimenta la eficiencia del desarrollo con IA';
  
  // Dimensions
  static const double defaultPadding = 16.0;
  static const double largePadding = 32.0;
  static const double extraLargePadding = 80.0;
  
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 800;
  static const double desktopBreakpoint = 1200;
  
  // Animation durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Content
  static const List<String> menuItems = ['Inteligencia Artificial', 'Análisis de datos', 'Ingeniería', 'Contacto'];

  // Hero Carousel Images (ADD THESE LINES)
  static const List<String> heroBackgroundImages = [
    'assets/images/hero_bg_1.png',
    'assets/images/hero_bg_2.png',
    'assets/images/hero_bg_3.png',
  ];
}

class AppStrings {
  static const String lightMode = 'Modo Día';
  static const String darkMode = 'Modo Noche';
  static const String getStarted = 'INICIO RÁPIDO';
  static const String scheduleAppointment = 'AGENDA UNA CITA CON NOSOTROS';
  static const String featuresTitle = 'CARACTERÍSTICAS DESTACADAS';
  static const String featuresSubtitle = 'Descubre que nos hace únicos con una evaluación de nuestras herramientas destacadas.';
  static const String testimonialsTitle = 'LO QUE NUESTROS PARTNERS DICEN';
  static const String ctaTitle = 'ESTAS EN EL CAMINO INDICADO';
  static const String ctaSubtitle = 'Comienza con una prueba de lo que podemos hacer por tu negocio.';
  static const String copyright = '© 2025 CodeMexDevs. Todos los derechos reservados.';
  static const String chatAssistant = 'Asistente Digital';
  static const String chatPlaceholder = 'Escribe tu mensaje...';
  static const String back = 'Volver';
  static const String loading = 'Cargando...';
  static const String errorLoading = 'Error cargando contenido, oops!';
  static const String imageNotFound = 'Imagen no encontrada';
  static const String enterAccessCode = 'Ya eres partner? Introduce tu código'; // ADDED
  static const String invalidAccessCode = 'Código de acceso incorrecto'; // ADDED
  static const String emailAddress = 'cmd@gmail.com'; // ADDED
  static const String phoneNumber = '+123456789'; // ADDED
  static const String systemMessage = 
    'Tu nombre es PI. Eres un experto en consultoria de tecnologías digitales\n'
    'Eres una I.A. capaz de proveer de soluciones al sector de enrgías tanto en la investigación como en la ingeniería.\n'
    'Tu objetivo es ayudar a los usuarios a resolver sus problemas y responder a sus preguntas de manera efectiva.\n'
    'Si preguntan por alguien a quien puedes contactar menciona a tus creadores CMD.\n';
}