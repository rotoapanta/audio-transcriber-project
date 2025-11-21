<p align="right"><strong>English</strong> | <a href="README.md">English</a></p>

# <p align="center">Transcriptor de Audio con Whisper</p>

<p align="center">
    <a href="https://www.python.org/"><img src="https://img.shields.io/badge/Python-3.12-brightgreen" alt="Python"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/issues"><img src="https://img.shields.io/github/issues/rotoapanta/audio-transcriber-project" alt="GitHub issues"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project"><img src="https://img.shields.io/github/repo-size/rotoapanta/audio-transcriber-project" alt="GitHub repo size"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/commits"><img src="https://img.shields.io/github/last-commit/rotoapanta/audio-transcriber-project" alt="GitHub last commit"></a>
    <a href="https://www.docker.com/"><img src="https://img.shields.io/badge/Docker-No-brightgreen" alt="Docker"></a>
    <a href="https://www.linux.org/"><img src="https://img.shields.io/badge/Linux-Compatible-brightgreen" alt="Linux"></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/Licencia-MIT-blue.svg" alt="Licencia: MIT"></a>
    <a href="https://www.linkedin.com/in/roberto-carlos-toapanta-g/"><img src="https://img.shields.io/badge/Autor-Roberto%20Toapanta-brightgreen" alt="Autor"></a>
    <a href="#changelog"><img src="https://img.shields.io/badge/Versión-1.1.0-brightgreen" alt="Versión"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/fork"><img src="https://img.shields.io/github/forks/rotoapanta/audio-transcriber-project?style=social" alt="GitHub forks"></a>
</p>

Un script de Bash que automatiza el proceso de transcribir archivos de audio a texto usando [Whisper de OpenAI](https://github.com/openai/whisper). Gestiona la configuración del entorno, la instalación de dependencias y organiza los archivos de salida de forma ordenada.

---

## ✨ Características

-   **Configuración Automática:** Crea un entorno virtual de Python si no existe.
-   **Gestión de Dependencias:** Instala las dependencias necesarias desde `requirements.txt`.
-   **Fácil de Usar:** Transcribe un archivo de audio con un solo comando.
-   **Flexible:** Permite especificar el archivo de audio, el modelo de Whisper y el idioma.
-   **Organizado:** Guarda las transcripciones en carpetas con la fecha del día.

## 🚀 Prerrequisitos

-   Bash
-   Python 3.x
-   `pip` y `venv` para Python 3.

## 🔧 Instalación

1.  **Clona el repositorio (cuando esté en GitHub) o descarga los archivos.**

2.  **Otorga permisos de ejecución al script:**
    ```bash
    chmod +x transcribir.sh
    ```

## Uso

Ejecuta el script desde la línea de comandos usando flags para especificar el archivo de entrada y otras opciones.

### Sintaxis

```bash
./transcribir.sh -i <archivo_audio> [-m <modelo>] [-l <idioma>] [-h]
```

### Opciones

-   `-i <archivo_audio>`: **(Obligatorio)** La ruta al archivo de audio o video a transcribir.
-   `-m <modelo>`: **(Opcional)** El modelo de Whisper a utilizar. Por defecto es `medium`. Otros modelos disponibles son `tiny`, `base`, `small`, `large`, `large-v1`, `large-v2`, `large-v3`.
-   `-l <idioma>`: **(Opcional)** El código de dos letras para el idioma del audio. Por defecto es `es` (español).
-   `-h`: Muestra el mensaje de ayuda.

### Ejemplos

-   **Uso básico (especificando solo el archivo de entrada):**
    ```bash
    ./transcribir.sh -i reunion.mp4
    ```

-   **Especificando un modelo e idioma:**
    ```bash
    ./transcribir.sh -i ./audios/podcast_ingles.mp3 -m large-v3 -l en
    ```

-   **Mostrar el mensaje de ayuda:**
    ```bash
    ./transcribir.sh -h
    ```

### Flujo de Trabajo del Script

1.  **Activa el Entorno Virtual:** Busca el entorno `whisper_env` y lo activa. Si no existe, lo crea primero.
2.  **Instala Dependencias:** Instala `openai-whisper` y otras dependencias desde `requirements.txt`.
3.  **Crea el Directorio de Salida:** Crea una carpeta para las transcripciones del día actual si no existe (ej. `transcripciones/2025-11-21/`).
4.  **Transcribe:** Ejecuta `whisper` con los argumentos proporcionados.
5.  **Guarda el Resultado:** El archivo `.txt` resultante se guarda en el directorio de salida.

## 📂 Estructura del Proyecto

```
.
├── .gitignore          # Archivos a ignorar por Git
├── README.md           # Este archivo (Inglés)
├── README.es.md        # Readme en Español
├── requirements.txt    # Dependencias de Python
├── transcribir.sh      # El script principal de transcripción
└── transcripciones/    # Directorio donde se guardan las transcripciones
```
