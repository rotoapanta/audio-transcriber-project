<p align="right"><a href="README.es.md">Español</a></p>

# <p align="center">Whisper Audio Transcriber</p>

<p align="center">
    <a href="https://www.python.org/"><img src="https://img.shields.io/badge/Python-3.12-brightgreen" alt="Python"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/issues"><img src="https://img.shields.io/github/issues/rotoapanta/audio-transcriber-project" alt="GitHub issues"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project"><img src="https://img.shields.io/github/repo-size/rotoapanta/audio-transcriber-project" alt="GitHub repo size"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/commits"><img src="https://img.shields.io/github/last-commit/rotoapanta/audio-transcriber-project" alt="GitHub last commit"></a>
    <a href="https://www.docker.com/"><img src="https://img.shields.io/badge/Docker-Yes-brightgreen" alt="Docker"></a>
    <a href="https://www.linux.org/"><img src="https://img.shields.io/badge/Linux-Supported-brightgreen" alt="Linux"></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT"></a>
    <a href="https://www.linkedin.com/in/roberto-carlos-toapanta-g/"><img src="https://img.shields.io/badge/Author-Roberto%20Toapanta-brightgreen" alt="Author"></a>
    <a href="#changelog"><img src="https://img.shields.io/badge/Version-1.1.0-brightgreen" alt="Version"></a>
    <a href="https://github.com/rotoapanta/audio-transcriber-project/fork"><img src="https://img.shields.io/github/forks/rotoapanta/audio-transcriber-project?style=social" alt="GitHub forks"></a>
</p>

A Python script that automates the process of transcribing audio files to text using [OpenAI's Whisper](https://github.com/openai/whisper). It handles dependency installation, and neatly organizes the output files.

---

## ✨ Features

-   **Python-based:** More robust, portable, and easier to maintain.
-   **GPU Acceleration:** Automatically uses CUDA if available for faster transcription.
-   **Dependency Management:** Installs the required dependencies from `requirements.txt`.
-   **Easy to Use:** Transcribe an audio file with a single command.
-   **Flexible:** Allows specifying the audio file, Whisper model, and language.
-   **Organized:** Saves transcriptions into date-stamped folders.

## 🚀 Prerequisites

-   Python 3.x
-   `pip`

## 🔧 Installation

There are two ways to set up this project: using Docker (recommended for portability) or setting up a local Python environment.

### With Docker (Recommended)

1.  **Install [Docker](https://docs.docker.com/get-docker/).**

2.  **Clone the repository:**
    ```bash
    git clone https://github.com/rotoapanta/audio-transcriber-project.git
    cd audio-transcriber-project
    ```

3.  **Build the Docker image:**
    ```bash
    docker build -t whisper-transcriber .
    ```

### Local Python Environment

1.  **Clone the repository and navigate into it.**

2.  **Create and activate a virtual environment:**
    ```bash
    python3 -m venv whisper_env
    source whisper_env/bin/activate
    ```

3.  **Install the required dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

## Usage

### With Docker

To transcribe a file using Docker, you need to mount your local directories for input and output into the container.

-   `-v /path/to/your/audio:/app/audio`: Mounts your local audio directory to `/app/audio` inside the container.
-   `-v /path/to/your/transcriptions:/app/transcriptions`: Mounts your local transcriptions directory to `/app/transcriptions` inside the container.

```bash
docker run --rm \
  -v $(pwd)/audio_files:/app/audio \
  -v $(pwd)/transcripciones:/app/transcriptions \
  whisper-transcriber \
  -i /app/audio/your_audio.mp3 \
  -m large-v3 \
  -l en
```

*Note: Replace `$(pwd)/audio_files` and `$(pwd)/transcripciones` with the actual paths to your audio and output directories.*

### With Python

Run the script from the command line using flags to specify the input file and other options.

### Syntax

```bash
python transcriber.py -i <audio_file> [-m <model>] [-l <language>] [-o <output_dir>]
```

### Options

-   `-i, --input <audio_file>`: **(Required)** The path to the audio or video file to be transcribed.
-   `-m, --model <model>`: **(Optional)** The Whisper model to use. Defaults to `medium`.
-   `-l, --language <language>`: **(Optional)** The two-letter code for the audio language. Defaults to `es` (Spanish).
-   `-o, --output_dir <output_dir>`: **(Optional)** Directory to save the transcription. Defaults to `transcripciones/YYYY-MM-DD`.

### Examples

-   **Basic usage (specifying only the input file):**
    ```bash
    python transcriber.py -i meeting.mp4
    ```

-   **Specifying a model and language:**
    ```bash
    python transcriber.py -i ./audios/english_podcast.mp3 -m large-v3 -l en
    ```

### Script Workflow

1.  **Parses Arguments:** Reads the command-line arguments.
2.  **Sets Up Output Directory:** Creates the output directory if it doesn't exist.
3.  **Loads Model:** Loads the specified Whisper model, using GPU if available.
4.  **Transcribes:** Runs the transcription.
5.  **Saves Result:** The resulting `.txt` file is saved in the output directory.

## 📂 Project Structure

```
.
├── .gitignore          # Files to be ignored by Git
├── Dockerfile          # Instructions to build the Docker image
├── LICENSE             # Project License
├── README.md           # This file (English)
├── README.es.md        # Spanish Readme
├── requirements.txt    # Python dependencies
├── transcriber.py      # The main transcription script
└── transcripciones/    # Directory where transcriptions are saved
```
