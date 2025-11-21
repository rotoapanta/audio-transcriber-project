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

## 🚀 Prerrequisitos

-   Python 3.x
-   `pip`

## 🔧 Instalación

Hay dos formas de configurar este proyecto: usando Docker (recomendado por su portabilidad) o configurando un entorno de Python local.

### Con Docker (Recomendado)

1.  **Instala [Docker](https://docs.docker.com/get-docker/).**

2.  **Clona el repositorio:**
    ```bash
    git clone https://github.com/rotoapanta/audio-transcriber-project.git
    cd audio-transcriber-project
    ```

3.  **Construye la imagen de Docker:**
    ```bash
    docker build -t whisper-transcriber .
    ```

### Entorno Local de Python

1.  **Clona el repositorio y navega hacia él.**

2.  **Crea y activa un entorno virtual:**
    ```bash
    python3 -m venv whisper_env
    source whisper_env/bin/activate
    ```

3.  **Instala las dependencias necesarias:**
    ```bash
    pip install -r requirements.txt
    ```

## Uso

### Con Docker

Para transcribir un archivo usando Docker, necesitas montar tus directorios locales de entrada y salida en el contenedor.

-   `-v /ruta/a/tus/audios:/app/audio`: Monta tu directorio local de audios en `/app/audio` dentro del contenedor.
-   `-v /ruta/a/tus/transcripciones:/app/transcripciones`: Monta tu directorio local de transcripciones en `/app/transcripciones` dentro del contenedor.

```bash
docker run --rm \
  -v $(pwd)/archivos_de_audio:/app/audio \
  -v $(pwd)/transcripciones:/app/transcriptions \
  whisper-transcriber \
  -i /app/audio/tu_audio.mp3 \
  -m large-v3 \
  -l es
```

*Nota: Reemplaza `$(pwd)/archivos_de_audio` y `$(pwd)/transcripciones` con las rutas reales a tus directorios de audio y salida.*

### Con Python

Ejecuta el script desde la línea de comandos usando flags para especificar el archivo de entrada y otras opciones.

### Sintaxis

```bash
python transcriber.py -i <archivo_audio> [-m <modelo>] [-l <idioma>] [-o <directorio_salida>]
```

### Opciones

-   `-i, --input <archivo_audio>`: **(Obligatorio)** La ruta al archivo de audio o video a transcribir.
-   `-m, --model <modelo>`: **(Opcional)** El modelo de Whisper a utilizar. Por defecto es `medium`.
-   `-l, --language <idioma>`: **(Opcional)** El código de dos letras para el idioma del audio. Por defecto es `es` (español).
-   `-o, --output_dir <directorio_salida>`: **(Opcional)** Directorio para guardar la transcripción. Por defecto es `transcripciones/YYYY-MM-DD`.

### Ejemplos

-   **Uso básico (especificando solo el archivo de entrada):**
    ```bash
    python transcriber.py -i reunion.mp4
    ```

-   **Especificando un modelo e idioma:**
    ```bash
    python transcriber.py -i ./audios/podcast_ingles.mp3 -m large-v3 -l en
    ```

### Flujo de Trabajo del Script

1.  **Parsea los Argumentos:** Lee los argumentos de la línea de comandos.
2.  **Configura el Directorio de Salida:** Crea el directorio de salida si no existe.
3.  **Carga el Modelo:** Carga el modelo de Whisper especificado, usando GPU si está disponible.
4.  **Transcribe:** Ejecuta la transcripción.
5.  **Guarda el Resultado:** El archivo `.txt` resultante se guarda en el directorio de salida.

## 📂 Estructura del Proyecto

```
.
├── .gitignore          # Archivos a ignorar por Git
├── Dockerfile          # Instrucciones para construir la imagen de Docker
├── LICENSE             # Licencia del Proyecto
├── README.md           # Este archivo (Inglés)
├── README.es.md        # Readme en Español
├── requirements.txt    # Dependencias de Python
├── transcriber.py      # El script principal de transcripción
└── transcripciones/    # Directorio donde se guardan las transcripciones
```
