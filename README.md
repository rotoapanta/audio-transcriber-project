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

## 🛠️ System requirements

-   [Docker](https://www.docker.com/)

## 🗂️ Project structure

```
audio-transcriber-project/
├── .gitignore
├── Dockerfile
├── LICENSE
├── README.es.md
├── README.md
├── requirements.txt
├── reunion_micro (Copiar).tsv
├── reunion_micro.mp4
├── transcriber.py
├── transcripciones/
│   ├── 2025-11-19/
│   ├── 2025-11-20/
│   └── 2025-11-21/
```

## 🚀 Deployment

The deployment process is done in two main steps: building the Docker image and running the container.

### 1. Build the Docker Image

This command packages the application and all its dependencies into a portable image named `whisper-transcriber`.

```bash
docker build -t whisper-transcriber .
```

### 2. Run the Transcription

To run a transcription, use the `docker run` command. This will create a temporary container from the image to process your audio file.

-   `-v "$(pwd):/app"`: This is the most important part. It maps your current project directory (where your audio files are) to the `/app` directory inside the container, allowing it to access them.

#### Resource Limiting (Crucial)

To prevent your computer from freezing, you must limit the resources the container can use.

-   `--cpus="1.5"`: Limits the container to 1.5 CPU cores.
-   `--memory="4g"`: Limits the container to 4GB of RAM.

### Example Command

```bash
docker run --rm \
  --cpus="1.5" --memory="4g" \
  -v "$(pwd):/app" \
  whisper-transcriber \
  -i "reunion_micro.mp4" \
  -m "base" \
  --device "cpu"
```

*Note: Adjust `--cpus` and `--memory` based on your system's hardware. Make sure the input file (e.g., `reunion_micro.mp4`) exists in your project directory.*

### Options

-   `-i, --input <audio_file>`: **(Required)** The path to the audio or video file to be transcribed.
-   `-m, --model <model>`: **(Optional)** The Whisper model to use. Defaults to `base`.
-   `-l, --language <language>`: **(Optional)** The two-letter code for the audio language. Defaults to `es` (Spanish).
-   `-o, --output_dir <output_dir>`: **(Optional)** Directory to save the transcription. Defaults to `transcripciones/YYYY-MM-DD`.
-   `--device <device>`: **(Optional)** Device to use for computation (e.g., 'cpu', 'cuda'). Defaults to 'cuda' if available, otherwise 'cpu'.

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

## 💬 Feedback

For comments or suggestions: robertocarlos.toapanta@gmail.com

## 🛟 Support

For support, email robertocarlos.toapanta@gmail.com or join our Discord channel.

## 📄 License

[MIT](https://opensource.org/licenses/MIT)

## 👥 Authors

- [@rotoapanta](https://github.com/rotoapanta)

## 📜 Changelog

This project follows Keep a Changelog and Semantic Versioning.

[Unreleased]
- 

- 1.0.0 – 2025-09-23
  - Stable release: step progress ("Step X/Y"), multi-platform connection guide, simplified suggestions, and reorganized README.

- 0.3.0 – 2025-09-23
  - Pre-release with "Connect a new device" guide and iOS integration.

- 0.1.0 – 2025-09-23
  - Initial version of the script.

## ℹ️ More information

Useful links:
- ZeroTier Central: https://my.zerotier.com
- ZeroTier downloads: https://www.zerotier.com/download/
- CLI documentation: https://docs.zerotier.com/zerotier/cli

## 🔗 Links

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/roberto-carlos-toapanta-g/)

[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/rotoapanta)
