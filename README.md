# ArquitecturaSFV-P1

# Evaluación Práctica - Ingeniería de Software V

## Información del Estudiante
- **Nombre:** Sara Lucia Diaz Puerta    
- **Código:** A00399799 
- **Fecha:** Agosto 6 de 2025

## Resumen de la Solución
Esta solución implementa una aplicación Node.js contenida en Docker, acompañada de un script de automatización que facilita la construcción, despliegue y verificación del servicio. El enfoque principal es garantizar la portabilidad, reproducibilidad y facilidad de despliegue, siguiendo buenas prácticas de DevOps.

## Dockerfile
Para la creación del Dockerfile se realizaron los siguientes pasos: 
1. Se utilizó la imagen base node:18-alpine
2. Se copiaron los archivos de dependencia y se realizó su respectiva instalación
3. Se copió el resto del código para que el contenedor tenga acceso a este
4. Se expuso la aplicación en el puerto 3000
5. Se definió el comando para iniciar la aplicación de acuerdo a package.json

## Script de Automatización
Para el script de automatización (`script.sh`) se realizaron las siguientes acciones:
1. Se verificó si Docker está instalado en el sistema.
2. Se construyó automáticamente la imagen Docker de la aplicación.
3. Se eliminó cualquier contenedor previo con el mismo nombre para evitar conflictos.
4. Se ejecutó el contenedor con las variables de entorno `PORT=3000` y `NODE_ENV=production`.
5. Se realizó una prueba básica usando `curl` para verificar que el servicio responde correctamente.
6. Se imprimió un resumen del estado, indicando si el proceso fue exitoso o si ocurrió algún error.

## Principios DevOps Aplicados
1. **Automatización:** El uso de scripts y contenedores permite automatizar el despliegue y pruebas, reduciendo errores manuales.
2. **Portabilidad:** Al contenerizar la aplicación, se garantiza que funcione igual en cualquier entorno compatible con Docker.
3. **Reproducibilidad:** El proceso de construcción y despliegue es consistente, asegurando que los resultados sean los mismos en cada ejecución.

## Captura de Pantalla
![Evidencia de la aplicación corriendo en Docker](./screenshot.png)

## Mejoras Futuras
1. Implementar pruebas automatizadas adicionales para validar endpoints y lógica de negocio.
2. Integrar el despliegue con un pipeline CI/CD para automatizar aún más el proceso.
3. Añadir soporte para múltiples entornos (desarrollo, pruebas, producción) mediante archivos de configuración o variables de entorno.

## Instrucciones para Ejecutar
1. Clona este repositorio en tu máquina local.
2. Asegúrate de tener Docker instalado y funcionando.
3. Da permisos de ejecución al script: `chmod +x script.sh`
4. Ejecuta el script de automatización: `./script.sh`
5. Verifica en la terminal el resumen del estado y accede a la aplicación en [http://localhost:3000](http://localhost:3000)