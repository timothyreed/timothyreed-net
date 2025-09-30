# Docker Setup for timothyreed.net

This project includes Docker configuration for easy local development and deployment.

## Prerequisites

- Docker installed on your system
- Docker Compose installed on your system

## Building the Image

To build the Docker image:

```bash
docker-compose build
```

Or build directly with Docker:

```bash
docker build -t timothyreed-web .
```

## Running Locally with Docker Compose

Start the container:

```bash
docker-compose up
```

Run in detached mode (background):

```bash
docker-compose up -d
```

## Accessing the Site

Once the container is running, access the site at:

**http://localhost:8080**

## Live Reload During Development

The docker-compose configuration includes a volume mount that maps your local directory to the nginx html directory. Any changes you make to your files locally will be immediately reflected in the running container.

## Stopping the Container

Stop the running container:

```bash
docker-compose down
```

Or if running in the foreground, press `Ctrl+C`.

## Useful Commands

View container logs:
```bash
docker-compose logs -f
```

Restart the container:
```bash
docker-compose restart
```

Remove the container and image:
```bash
docker-compose down --rmi all
```
