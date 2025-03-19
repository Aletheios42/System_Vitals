# System Vitals: Monitoreo con Prometheus y Grafana

![Version](https://img.shields.io/badge/Version-1.0-green) ![Status](https://img.shields.io/badge/Status-Funcionando-success)

## Visión General

System Vitals es una solución de monitoreo moderna y eficiente construida con Prometheus y Grafana. Este sistema te permite visualizar y analizar métricas de rendimiento del sistema en tiempo real, establecer alertas y obtener insights sobre el comportamiento de tu infraestructura.

## Características

- **Métricas del Sistema** - CPU, memoria, disco y red
- **Alertas** - Notificaciones para condiciones críticas
- **Tiempo Real** - Actualizaciones en directo cada 5 segundos
- **Fácil de Configurar** - Despliegue con Docker Compose
- **CI/CD** - Flujo de trabajo de GitHub Actions para despliegue automático

## Tecnologías Utilizadas

- **Prometheus** - Almacenamiento y consulta de métricas
- **Grafana** - Visualización de datos y creación de dashboards
- **Node Exporter** - Recopilación de métricas del sistema
- **Docker & Docker Compose** - Contenedorización y orquestación
- **GitHub Actions** - CI/CD para despliegue automático

## Requisitos Previos

- Docker
- Docker Compose
- Git (opcional)

## Guía de Inicio Rápido

### Instalación Local

1. **Clonar el repositorio**

   ```bash
   git clone https://github.com/tu-usuario/System_Vitals.git
   cd System_Vitals
   ```

2. **Ejecutar el script de configuración**

   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Acceder a las interfaces**
   - Grafana: [http://localhost:3000](http://localhost:3000) (usuario: admin, contraseña: tucontraseñasegura)
   - Prometheus: [http://localhost:9090](http://localhost:9090)

### Despliegue Remoto

Para desplegar en un servidor remoto, configura los siguientes secretos en GitHub:

- `SSH_PRIVATE_KEY` - Tu clave SSH privada
- `SSH_USER` - Nombre de usuario en el servidor
- `SSH_HOST` - Dirección IP o dominio del servidor

Después, simplemente haz push a la rama master y GitHub Actions desplegará automáticamente.

## Estructura del Proyecto

```
System_Vitals/
├── .github/
│   └── workflows/
│       └── deploy.yml       # Configuración de GitHub Actions
├── grafana/
│   └── provisioning/        # Configuración automática de Grafana
│       ├── dashboards/      # Dashboards predefinidos
│       └── datasources/     # Fuentes de datos (Prometheus)
├── prometheus/
│   ├── alerts.yml           # Reglas de alertas
│   └── prometheus.yml       # Configuración de Prometheus
├── docker-compose.yml       # Definición de servicios
└── setup.sh                 # Script de instalación
```

## Cómo Usar

### Ver Métricas del Sistema

1. Accede a Grafana en [http://localhost:3000](http://localhost:3000)
2. Explora el dashboard predefinido "System Metrics"
3. Ajusta el rango de tiempo según necesites

### Consultar Métricas en Prometheus

1. Accede a Prometheus en [http://localhost:9090](http://localhost:9090)
2. Usa el explorador de métricas para construir consultas
3. Ejemplo: `100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)`

### Verificar Alertas

1. En Prometheus, ve a "Alerts" para ver las reglas configuradas
2. Las alertas activas aparecerán en el panel de alertas

## Personalización

### Modificar Alertas

Edita `prometheus/alerts.yml` para ajustar los umbrales:

```yaml
groups:
  - name: basic_alerts
    rules:
      - alert: HighCPULoad
        expr: 100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High CPU load"
          description: "CPU load is > 80%"
```

### Añadir Dashboards

Importa dashboards desde Grafana Dashboards o crea los tuyos propios.

## Solución de Problemas

### Los contenedores no inician

```bash
# Verificar el estado de los contenedores
docker-compose ps

# Ver logs para diagnosticar problemas
docker-compose logs
```

### No puedo acceder a Grafana

```bash
# Verificar que el puerto 3000 está abierto
curl http://localhost:3000

# Reiniciar el contenedor de Grafana
docker-compose restart grafana
```

## Próximas Mejoras

- Añadir cAdvisor para monitoreo de contenedores
- Implementar Loki para gestión de logs
- Expandir dashboards con más métricas
- Añadir Alertmanager para notificaciones

## Licencia

Este proyecto está bajo la Licencia MIT - consulta el archivo LICENSE para más detalles.

## Contribución

Las contribuciones son bienvenidas. Por favor, abre un issue o pull request para sugerencias o mejoras.

---

**Si te gusta este proyecto, no olvides darle una estrella!**
