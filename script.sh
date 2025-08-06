# --- Config ---
IMAGE_NAME=devops-evaluation-image
CONTAINER_NAME=devop-evaluation-app
PORT=3000
NODE_ENV=production
HEALTH_URL="http://localhost:${PORT}"
MAX_RETRIES=30
SLEEP_SECS=1

if ! command -v docker >/dev/null 2>&1; then
  echo "ERROR: Docker no está instalado o no está en el PATH."
  echo "Descarga e instala Docker Desktop/Engine e inténtalo de nuevo."
  exit 1
fi

echo "Docker encontrado: $(docker --version)"

echo "Construyendo imagen: ${IMAGE_NAME}"
docker build -t "${IMAGE_NAME}" .

if docker ps -a --format '{{.Names}}' | grep -qx "${CONTAINER_NAME}"; then
  echo "Eliminando contenedor previo: ${CONTAINER_NAME}"
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
fi

echo "Ejecutando contenedor: ${CONTAINER_NAME}"
docker run -d --name "${CONTAINER_NAME}" \
  -e PORT="${PORT}" \
  -e NODE_ENV="${NODE_ENV}" \
  -p "${PORT}:${PORT}" \
  "${IMAGE_NAME}" >/dev/null

echo "Esperando a que el servicio responda en ${HEALTH_URL} ..."
ok=false
for i in $(seq 1 "${MAX_RETRIES}"); do
  if curl -fsS "${HEALTH_URL}" >/dev/null 2>&1; then
    ok=true
    break
  fi
  sleep "${SLEEP_SECS}"
done

echo "----------------------------------------"
if [ "${ok}" = true ]; then
  echo "ÉXITO"
  echo "Imagen:     ${IMAGE_NAME}"
  echo "Contenedor: ${CONTAINER_NAME}"
  echo "Puerto:     ${PORT} (host) -> ${PORT} (container)"
  echo "URL:        ${HEALTH_URL}"
  echo "Estado:     $(docker ps --filter name=${CONTAINER_NAME} --format '{{.Status}}')"
  exit 0
else
  echo "ERROR: El servicio no respondió tras $((MAX_RETRIES * SLEEP_SECS))s."
  echo "Logs del contenedor (últimas líneas):"
  docker logs --tail 100 "${CONTAINER_NAME}" || true
  exit 2
fi
