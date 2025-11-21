# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Install ffmpeg, a dependency for Whisper
RUN apt-get update && apt-get install -y ffmpeg

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
# We use --no-cache-dir to keep the image size down
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code into the container at /app
COPY . .

# Define the entry point for the container.
# This is the command that will be run when the container starts.
ENTRYPOINT ["python", "transcriber.py"]

# Set default command to show help message if no arguments are provided
CMD ["-h"]
