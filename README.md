<p align="right"><a href="README.es.md">Español</a></p>

# <p align="center">Whisper Audio Transcriber</p>

<p align="center">
    <a href="https://www.python.org/"><img src="https://img.shields.io/badge/Python-3.12-brightgreen" alt="Python"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/issues"><img src="https://img.shields.io/github/issues/rotoapanta/audio-transcriber-project" alt="GitHub issues"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project"><img src="https://img.shields.io/github/repo-size/rotoapanta/audio-transcriber-project" alt="GitHub repo size"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/commits"><img src="https://img.shields.io/github/last-commit/rotoapanta/audio-transcriber-project" alt="GitHub last commit"></a>
    <a href="https://www.docker.com/"><img src="https://img.shields.io/badge/Docker-No-brightgreen" alt="Docker"></a>
    <a href="https://www.linux.org/"><img src="https://img.shields.io/badge/Linux-Supported-brightgreen" alt="Linux"></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT"></a>
    <a href="https://www.linkedin.com/in/roberto-carlos-toapanta-g/"><img src="https://img.shields.io/badge/Author-Roberto%20Toapanta-brightgreen" alt="Author"></a>
    <a href="#changelog"><img src="https://img.shields.io/badge/Version-1.1.0-brightgreen" alt="Version"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/fork"><img src="https://img.shields.io/github/forks/rotoapanta/audio-transcriber-project?style=social" alt="GitHub forks"></a>
</p>

A Bash script that automates the process of transcribing audio files to text using [OpenAI's Whisper](https://github.com/openai/whisper). It handles environment setup, dependency installation, and neatly organizes the output files.

---

## ✨ Features

-   **Automatic Setup:** Creates a Python virtual environment if it doesn't exist.
-   **Dependency Management:** Installs the required dependencies from `requirements.txt`.
-   **Easy to Use:** Transcribe an audio file with a single command.
-   **Flexible:** Allows specifying the audio file, Whisper model, and language.
-   **Organized:** Saves transcriptions into date-stamped folders.

## 🚀 Prerequisites

-   Bash
-   Python 3.x
-   `pip` and `venv` for Python 3.

## 🔧 Installation

1.  **Clone the repository (once on GitHub) or download the files.**

2.  **Grant execution permissions to the script:**
    ```bash
    chmod +x transcribir.sh
    ```

## Usage

Run the script from the command line, providing the path to the audio file you want to transcribe. You can also optionally specify the Whisper model and language.

### Syntax

```bash
./transcribir.sh path/to/audio.[mp3|wav|m4a|etc] [model] [language]
```

### Arguments

-   `path/to/audio`: **(Required)** The path to the audio or video file to be transcribed.
-   `[model]`: **(Optional)** The Whisper model to use. Defaults to `medium`. Other available models include `tiny`, `base`, `small`, `large`, `large-v1`, `large-v2`, `large-v3`.
-   `[language]`: **(Optional)** The two-letter code for the audio language. Defaults to `es` (Spanish).

### Examples

-   **Basic usage (default model `medium`, language `Spanish`):**
    ```bash
    ./transcribir.sh meeting.mp4
    ```

-   **Specifying a model and language:**
    ```bash
    ./transcribir.sh ./audios/english_podcast.mp3 large-v3 en
    ```

### Script Workflow

1.  **Activate Virtual Environment:** It looks for the `whisper_env` environment and activates it. If it doesn't exist, it creates it first.
2.  **Install Dependencies:** Installs `openai-whisper` and other dependencies from `requirements.txt`.
3.  **Create Output Directory:** Creates a folder for the current day's transcriptions if it doesn't exist (e.g., `transcripciones/2025-11-21/`).
4.  **Transcribe:** Runs `whisper` with the provided arguments.
5.  **Save Result:** The resulting `.txt` file is saved in the output directory.

## 📂 Project Structure

```
.
├── .gitignore          # Files to be ignored by Git
├── README.md           # This file (English)
├── README.es.md        # Spanish Readme
├── requirements.txt    # Python dependencies
├── transcribir.sh      # The main transcription script
└── transcripciones/    # Directory where transcriptions are saved
```
