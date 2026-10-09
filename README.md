# Gooseneck Student Container

This README was created using Microsoft Copilot.

Gooseneck is a lightweight student lab environment packaged in a container and accessed through a VNC viewer.

## Overview

This project provides a containerized student workspace that can be built, launched, and connected to remotely. It is designed for a classroom or lab environment where students need a consistent desktop environment with preconfigured access.

## Prerequisites

Before getting started, make sure you have:

- A Linux-based environment or compatible shell
- Access to a VNC client such as [MobaXterm](https://mobaxterm.mobatek.net/) or [TigerVNC](https://tigervnc.org/)
- Docker or the project’s required container tooling available on your system

## Quick start

1. Open a terminal and navigate to the `student_container` directory.
2. Build the container:

```bash
cd student_container
bash build_gooseneck.sh
```

3. Start the container. When prompted, enter your UCID:

```bash
bash run_gooseneck.sh
```

4. Connect to the container using your VNC client.

## Connect with VNC

Use a VNC viewer such as [MobaXterm](https://mobaxterm.mobatek.net/), [TigerVNC](https://tigervnc.org/), or another compatible client. Connect using the connection details shown for your running container.

### Default credentials

| Account | Username | Password |
| --- | --- | --- |
| Student | `student` | `studentpass` |
| Admin | `admin` | `adminpass` |
| Root | `root` | `rootpass` |

## Stop the container

To stop an existing container, run:

```bash
bash stop_gooseneck.sh
```

## Delete the container

The container must be stopped before it can be deleted. This script can also remove associated volumes; deleting those volumes removes stored data.

```bash
bash delete_gooseneck.sh
```

## Installed programs

The list of installed applications and versions is still being documented. Add the software list here once it is finalized.

## Planned updates

- Document installed programs and versions
- Add container-specific VNC connection details
- Include troubleshooting guidance

## Change log

- Initial README created with build, run, VNC access, stop, and deletion instructions
