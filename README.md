PinApp Technical Assessment
Esta aplicación fue desarrollada como solución a la prueba técnica para el puesto de Desarrollador
Mobile Flutter en PinApp.

Descripción
La aplicación permite visualizar un listado de publicaciones (Posts) obtenidas de la API pública de
JSONPlaceholder. Entre sus funcionalidades principales, se incluye la posibilidad de marcar los
posts como "Me gusta" y visualizar los comentarios asociados a cada publicación.

Funcionalidades
Listado de Posts
Los posts se obtienen a través del endpoint: https://jsonplaceholder.typicode.com/posts.

"Me gusta"
Cada post tiene un botón que permite marcarlo como "Me gusta". Esta preferencia se almacena en la
memoria local del dispositivo utilizando la librería Shared Preferences.

Visualización de Comentarios
Al hacer tap en un post, se despliega un modal con el listado de comentarios asociados. Estos
comentarios se obtienen del endpoint https://jsonplaceholder.typicode.com/comments, pasando el ID
del post como parámetro (postId).

Compatibilidad Multiplataforma
Android: La aplicación está diseñada para funcionar de manera óptima en dispositivos Android.
iOS: En dispositivos iOS, la solicitud para obtener los comentarios se realiza de forma nativa en
Swift.

Tecnologías y Librerías Utilizadas
Flutter: Versión 3.24.3. Framework principal para el desarrollo de la aplicación.
Shared Preferences: Para el almacenamiento local de preferencias y datos del usuario.
Swift (iOS): Código nativo en Swift para realizar las peticiones de comentarios en dispositivos iOS.
Librerías adicionales: Especificadas en pubspec.yaml y utilizadas para implementar una arquitectura
limpia y seguir buenas prácticas en el desarrollo de aplicaciones.


