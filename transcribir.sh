#!/bin/bash

echo "--------------------------------------------------"
echo "     🎧 Script Profesional de Transcripción       "
echo "--------------------------------------------------"

# ------------------------------------------------------------------------------
# CONFIGURACIÓN Y VARIABLES GLOBALES
# ------------------------------------------------------------------------------

# Obtiene la ruta absoluta del script para que funcione independientemente desde dónde se llame.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Directorio raíz del proyecto (donde se encuentra este script).
PROJECT_DIR="$SCRIPT_DIR"

# Ruta al entorno virtual de Python.
ENV_PATH="$PROJECT_DIR/whisper_env"

# Directorio base donde se guardarán todas las transcripciones.
OUTPUT_BASE="$PROJECT_DIR/transcripciones"

# Valores por defecto para el modelo y el idioma.
# Estos pueden ser sobrescritos por los argumentos de la línea de comandos.
MODEL="medium"
LANG="es"

# ------------------------------------------------------------------------------
# PROCESAMIENTO DE ARGUMENTOS DE LÍNEA DE COMANDOS
# ------------------------------------------------------------------------------

# Función para mostrar el modo de uso del script.
usage() {
    echo "Uso: $0 -i <archivo_audio> [-m <modelo>] [-l <idioma>] [-h]"
    echo "  -i <archivo_audio>: Archivo de audio a transcribir (obligatorio)."
    echo "  -m <modelo>:          Modelo de Whisper a usar (opcional, por defecto: $MODEL)."
    echo "  -l <idioma>:          Idioma del audio (opcional, por defecto: $LANG)."
    echo "  -h:                   Muestra este mensaje de ayuda."
    exit 1
}

# Si no se proporcionan argumentos, muestra la ayuda.
if [ $# -eq 0 ]; then
    usage
fi

AUDIO=""

# Procesa las opciones de la línea de comandos con getopts.
while getopts ":i:m:l:h" opt; do
  case ${opt} in
    i)
      AUDIO=$OPTARG
      ;;
    m)
      MODEL=$OPTARG
      ;;
    l)
      LANG=$OPTARG
      ;;
    h)
      usage
      ;;
    \?)
      echo "Opción inválida: -$OPTARG" 1>&2
      usage
      ;;
    :)
      echo "La opción -$OPTARG requiere un argumento." 1>&2
      usage
      ;;
  esac
done
shift $((OPTIND -1))

# Valida que se haya proporcionado un archivo de entrada.
if [ -z "$AUDIO" ]; then
    echo "❌ Error: El archivo de entrada es obligatorio (-i)."
    usage
fi

# Verifica si el archivo de audio realmente existe.
if [ ! -f "$AUDIO" ]; then
    echo "❌ Error: el archivo '$AUDIO' no existe."
    exit 1
fi

# ------------------------------------------------------------------------------
# GESTIÓN DEL ENTORNO VIRTUAL DE PYTHON
# ------------------------------------------------------------------------------

# Si el directorio del entorno virtual no existe, lo crea.
if [ ! -d "$ENV_PATH" ]; then
    echo "⚠️  No existe el entorno. Creando entorno virtual en '$ENV_PATH'..."
    python3 -m venv "$ENV_PATH"
    if [ $? -ne 0 ]; then
        echo "❌ Error: no se pudo crear el entorno virtual."
        exit 1
    fi
    echo "✔ Entorno creado."
fi

# Activa el entorno virtual. Esto es necesario para usar `pip` y `whisper`.
echo "🔄 Activando entorno virtual..."
source "$ENV_PATH/bin/activate"
echo "✔ Entorno activado."

# ------------------------------------------------------------------------------
# INSTALACIÓN DE DEPENDENCIAS
# ------------------------------------------------------------------------------

# Comprueba si existe un archivo requirements.txt y, si es así, instala las dependencias.
if [ -f "$PROJECT_DIR/requirements.txt" ]; then
    echo "🐍 Instalando/verificando dependencias desde requirements.txt..."
    # Se usa --quiet para una salida más limpia, pero se podría quitar para depurar.
    pip install --quiet -r "$PROJECT_DIR/requirements.txt"
    if [ $? -ne 0 ]; then
        echo "❌ Error: no se pudieron instalar las dependencias."
        exit 1
    fi
    echo "✔ Dependencias listas."
else
    echo "⚠️  Advertencia: no se encontró el archivo requirements.txt."
fi

# ------------------------------------------------------------------------------
# PREPARACIÓN PARA LA TRANSCRIPCIÓN
# ------------------------------------------------------------------------------

# Crea el directorio de salida basado en la fecha actual.
FECHA=$(date +%Y-%m-%d)
OUTPUT_DIR="$OUTPUT_BASE/$FECHA"
mkdir -p "$OUTPUT_DIR" # La opción -p evita errores si el directorio ya existe.

# Extrae el nombre del archivo sin la extensión para usarlo en el archivo de salida.
NOMBRE=$(basename "$AUDIO")
NOMBRE_SIN_EXT="${NOMBRE%.*}"

echo ""
echo "📝 Transcribiendo: $AUDIO"
echo "🗣 Idioma: $LANG"
echo "🧠 Modelo: $MODEL"
echo "📂 Guardando en: $OUTPUT_DIR"
echo ""

# Guarda el tiempo de inicio para calcular la duración.
START_TIME=$(date +%s)

# ------------------------------------------------------------------------------
# EJECUCIÓN DE WHISPER
# ------------------------------------------------------------------------------

# Llama al comando whisper con todos los parámetros.
# --output_dir: Especifica dónde guardar los archivos de salida.
# --output_format: Limita la salida solo a archivos .txt.
# --fp16 False: Puede ser necesario en algunas GPUs. Considera quitarlo si tienes una GPU compatible.
whisper "$AUDIO" --model "$MODEL" --language "$LANG" --output_dir "$OUTPUT_DIR" --output_format txt --fp16 False

# Comprueba si el comando anterior falló.
if [ $? -ne 0 ]; then
    echo "❌ Error: la transcripción ha fallado."
    # Desactiva el entorno virtual antes de salir.
    deactivate
    exit 1
fi

# Calcula la duración total de la transcripción.
END_TIME=$(date +%s)
DURATION=$(( END_TIME - START_TIME ))

# ------------------------------------------------------------------------------
# FINALIZACIÓN
# ------------------------------------------------------------------------------

# Emite un sonido de campana para notificar que el proceso ha terminado.
echo -e "\a"

# Muestra un resumen de la operación.
echo "--------------------------------------------------"
echo "🎉 TRANSCRIPCIÓN COMPLETADA"
echo "📄 Archivo generado:"
echo "   $OUTPUT_DIR/${NOMBRE_SIN_EXT}.txt"
echo "⏱ Duración total: $DURATION segundos"
echo "--------------------------------------------------"

# Desactiva el entorno virtual.
deactivate
