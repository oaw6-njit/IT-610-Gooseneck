# Gooseneck Student Container
This README was created using Microsoft Copilot.

Gooseneck is a lightweight student lab environment packaged in a container and accessed through a VNC viewer.

## Quick start

1. Open a terminal and go to the `student_container` directory.
2. Build the container:

```bash
cd student_container
bash build_gooseneck.sh
```

3. Start the container. When prompted, enter your UCID:

```bash
bash run_gooseneck.sh
```

4. Connect with a VNC client and log in using the credentials below.

## Connect using VNC

Open a VNC session with [MobaXterm](https://mobaxterm.mobatek.net/), [TigerVNC](https://tigervnc.org/), or another compatible VNC viewer. Use the connection details for your running container.

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

The container must be stopped before it can be deleted. This script can also remove associated volumes; deleting volumes removes any stored data.

```bash
bash delete_gooseneck.sh
```

## Installed programs

The list of installed applications and versions is still being documented. Add the software list here as it is finalized.

## Planned updates

- Document installed programs and versions.
- Add container-specific VNC connection details.
- Include troubleshooting guidance.

## Change log

- Initial README created with build, run, VNC access, stop, and deletion instructions.
