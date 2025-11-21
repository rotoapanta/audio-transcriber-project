<p align="right"><strong>English</strong> | <a href="README.md">English</a></p>

# <p align="center">Transcriptor de Audio con Whisper</p>

<p align="center">
    <a href="https://www.python.org/"><img src="https://img.shields.io/badge/Python-3.12-brightgreen" alt="Python"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/issues"><img src="https://img.shields.io/github/issues/rotoapanta/audio-transcriber-project" alt="GitHub issues"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project"><img src="https://img.shields.io/github/repo-size/rotoapanta/audio-transcriber-project" alt="GitHub repo size"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/commits"><img src="https://img.shields.io/github/last-commit/rotoapanta/audio-transcriber-project" alt="GitHub last commit"></a>
    <a href="https://www.docker.com/"><img src="https://img.shields.io/badge/Docker-Sí-brightgreen" alt="Docker"></a>
    <a href="https://www.linux.org/"><img src="https://img.shields.io/badge/Linux-Compatible-brightgreen" alt="Linux"></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/Licencia-MIT-blue.svg" alt="Licencia: MIT"></a>
    <a href="https://www.linkedin.com/in/roberto-carlos-toapanta-g/"><img src="https://img.shields.io/badge/Autor-Roberto%20Toapanta-brightgreen" alt="Autor"></a>
    <a href="#changelog"><img src="https://img.shields.io/badge/Versión-1.1.0-brightgreen" alt="Versión"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/fork"><img src="https://img.shields.io/github/forks/rotoapanta/audio-transcriber-project?style=social" alt="GitHub forks"></a>
</p>

Un script de Python que automatiza el proceso de transcribir archivos de audio a texto usando [Whisper de OpenAI](https://github.com/openai/whisper). Gestiona la instalación de dependencias y organiza los archivos de salida de forma ordenada.

---

## ✨ Características

-   **Basado en Python:** Más robusto, portable y fácil de mantener.
-   **Aceleración por GPU:** Usa CUDA automáticamente si está disponible para una transcripción más rápida.
-   **Gestión de Dependencias:** Instala las dependencias necesarias desde `requirements.txt`.
-   **Fácil de Usar:** Transcribe un archivo de audio con un solo comando.
-   **Flexible:** Permite especificar el archivo de audio, el modelo de Whisper y el idioma.
-   **Organizado:** Guarda las transcripciones en carpetas con la fecha del día.

## 🛠️ Requisitos del sistema

-   [Docker](https://www.docker.com/)

## 🗂️ Estructura del proyecto

```
audio-transcriber-project/
├── .gitignore
├── Dockerfile
├── LICENSE
├── README.es.md
├── README.md
├── requirements.txt
├── transcriber.py
├── audio_files/          # Coloca tus archivos de audio/video aquí
│   └── ejemplo.mp4
└── transcripciones/      # Directorio de salida para las transcripciones
    └── 2025-11-21/
```

## 🚀 Despliegue

El proceso de despliegue se realiza en dos pasos principales: construir la imagen de Docker y ejecutar el contenedor.

### 1. Construir la Imagen de Docker

Este comando empaqueta la aplicación y todas sus dependencias en una imagen portable llamada `whisper-transcriber`.

```bash
docker build -t whisper-transcriber .
```

### 2. Ejecutar la Transcripción

Para realizar una transcripción, usa el comando `docker run`. Esto creará un contenedor temporal a partir de la imagen para procesar tu archivo de audio.

-   `-v "$(pwd):/app"`: Esta es la parte más importante. Mapea tu directorio de proyecto actual (donde están tus archivos de audio) a la carpeta `/app` dentro del contenedor, permitiéndole acceder a ellos.

#### Limitación de Recursos (Crucial)

Para evitar que tu computador se congele, debes limitar los recursos que el contenedor puede usar.

-   `--cpus="1.5"`: Limita el contenedor a 1.5 núcleos de CPU.
-   `--memory="4g"`: Limita el contenedor a 4GB de RAM.

### Comando de Ejemplo

```bash
docker run --rm \
  --cpus="1.5" --memory="4g" \
  -v "$(pwd):/app" \
  whisper-transcriber \
  -i "audio_files/ejemplo.mp4" \
  -m "base" \
  --device "cpu"
```

*Nota: Ajusta los valores de `--cpus` y `--memory` según el hardware de tu sistema. Coloca tu archivo de audio (ej. `ejemplo.mp4`) dentro de la carpeta `audio_files` antes de ejecutar el comando.*

### Opciones

-   `-i, --input <archivo_audio>`: **(Obligatorio)** La ruta al archivo de audio o video a transcribir.
-   `-m, --model <modelo>`: **(Opcional)** El modelo de Whisper a utilizar. Por defecto es `base`.
-   `-l, --language <idioma>`: **(Opcional)** El código de dos letras para el idioma del audio. Por defecto es `es` (español).
-   `-o, --output_dir <directorio_salida>`: **(Opcional)** Directorio para guardar la transcripción. Por defecto es `transcripciones/YYYY-MM-DD`.
-   `--device <dispositivo>`: **(Opcional)** Dispositivo a usar para el cálculo (ej. 'cpu', 'cuda'). Por defecto es 'cuda' si está disponible, si no 'cpu'.

### Ejemplos

-   **Uso básico (especificando solo el archivo de entrada):**
    ```bash
    python transcriber.py -i audio_files/reunion.mp4
    ```

-   **Especificando un modelo e idioma:**
    ```bash
    python transcriber.py -i ./audio_files/podcast_ingles.mp3 -m large-v3 -l en
    ```

### Flujo de Trabajo del Script

1.  **Parsea los Argumentos:** Lee los argumentos de la línea de comandos.
2.  **Configura el Directorio de Salida:** Crea el directorio de salida si no existe.
3.  **Carga el Modelo:** Carga el modelo de Whisper especificado, usando GPU si está disponible.
4.  **Transcribe:** Ejecuta la transcripción.
5.  **Guarda el Resultado:** El archivo `.txt` resultante se guarda en el directorio de salida.

## 💬 Comentarios

Si tienes comentarios o sugerencias, contáctanos en robertocarlos.toapanta@gmail.com

## 🛟 Soporte

Para soporte, escribe a robertocarlos.toapanta@gmail.com o únete a nuestro canal de Discord.

## 📄 Licencia

[MIT](https://opensource.org/licenses/MIT)

## 👥 Autores

- [@rotoapanta](https://github.com/rotoapanta)

## 📜 Registro de cambios

Este proyecto sigue el formato Keep a Changelog y Semantic Versioning.

[Unreleased]
- 

- 1.0.0 – 2025-09-23
  - Lanzamiento estable: progreso “Paso X/Y”, guía multi-plataforma, sugerencias simplificadas y README reorganizado.

- 0.3.0 – 2025-09-23
  - Prelanzamiento con guía “Conectar un nuevo dispositivo” e integración iOS.

- 0.1.0 – 2025-09-23
  - Versión inicial del script.

## ℹ️ Más Información

Enlaces útiles:
- ZeroTier Central: https://my.zerotier.com
- Descargas ZeroTier: https://www.zerotier.com/download/
- Documentación CLI: https://docs.zerotier.com/zerotier/cli

## 🔗 Enlaces

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/roberto-carlos-toapanta-g/)

[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/rotoapanta)
