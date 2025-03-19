#!/bin/bash
# Script de instalación y configuración:
# - Verifica e instala Docker y Docker Compose si es necesario
# - Inicia los servicios de monitoreo

# Verificar si Docker está instalado
if ! command -v docker &>/dev/null; then
    echo "Instalando Docker..."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker $USER
    echo "Docker instalado. Por favor, cierra sesión y vuelve a iniciarla para aplicar cambios de grupo."
    exit 0
fi

# Verificar si Docker Compose está instalado
if ! command -v docker-compose &>/dev/null; then
    echo "Instalando Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Iniciar la pila de monitoreo
echo "Iniciando servicios de monitoreo..."
docker-compose down
docker-compose up -d

echo "Servicios iniciados:"
echo "- Grafana: http://localhost:3000 (usuario: admin, contraseña: admin)"
echo "- Prometheus: http://localhost:9090"
