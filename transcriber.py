import argparse
import datetime
import os
import whisper
import torch
from pathlib import Path
import time

def main():
    """Main function to transcribe audio files using Whisper."""
    parser = argparse.ArgumentParser(
        description="Transcribe audio to text using OpenAI's Whisper.",
        formatter_class=argparse.RawTextHelpFormatter
    )
    parser.add_argument(
        "-i", "--input",
        required=True,
        type=str,
        help="Path to the audio or video file to transcribe."
    )
    parser.add_argument(
        "-m", "--model",
        default="base",
        type=str,
        help="Whisper model to use (e.g., tiny, base, small, medium, large-v1, large-v2, large-v3). Default: base."
    )
    parser.add_argument(
        "-l", "--language",
        default="es",
        type=str,
        help="Language of the audio (two-letter code, e.g., en, es, fr)."
    )
    parser.add_argument(
        "-o", "--output_dir",
        default=None,
        type=str,
        help="Directory to save the transcription file. Defaults to 'transcripciones/YYYY-MM-DD'."
    )
    parser.add_argument(
        "--device",
        default="cuda" if torch.cuda.is_available() else "cpu",
        type=str,
        help="Device to use for computation (e.g., 'cpu', 'cuda'). Defaults to 'cuda' if available, otherwise 'cpu'."
    )

    args = parser.parse_args()

    # --- Input Validation ---
    input_path = Path(args.input)
    if not input_path.is_file():
        print(f"❌ Error: The file '{args.input}' does not exist.")
        return

    # --- Output Directory Setup ---
    if args.output_dir:
        output_path = Path(args.output_dir)
    else:
        today = datetime.date.today().strftime("%Y-%m-%d")
        # Assuming the script is run from the project root
        output_path = Path("transcripciones") / today
    
    output_path.mkdir(parents=True, exist_ok=True)

    # --- Transcription ---
    print("\n" + "-" * 50)
    print("🎧 Whisper Audio Transcriber")
    print("-" * 50)
    print(f"📝 Transcribing: {input_path.name}")
    print(f"🧠 Model: {args.model}")
    print(f"🗣 Language: {args.language}")
    print(f"📂 Output directory: {output_path}")
    print("-" * 50 + "\n")

    start_time = time.time()

    try:
        print(f"Running on device: {args.device}")

        model = whisper.load_model(args.model, device=args.device)
        
        # fp16 is only available for CUDA devices
        use_fp16 = (args.device == "cuda")

        result = model.transcribe(
            str(input_path),
            language=args.language,
            fp16=use_fp16
        )

        # --- Save Output ---
        output_filename = output_path / f"{input_path.stem}.txt"
        with open(output_filename, "w", encoding="utf-8") as f:
            f.write(result["text"])

        end_time = time.time()
        duration = end_time - start_time

        # --- Completion Message ---
        print("\a") # Bell sound
        print("-" * 50)
        print("🎉 TRANSCRIPTION COMPLETE")
        print(f"📄 File saved to: {output_filename}")
        print(f"⏱ Total duration: {duration:.2f} seconds")
        print("-" * 50)

    except Exception as e:
        print(f"❌ An error occurred: {e}")

if __name__ == "__main__":
    main()
