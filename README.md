# Descripción

Este repositorio tiene como objetivo mantener el script base de PowerShell para poder instalar y desinstalar servicios de windows creados a partir de un IHost de .Net Core.

# Configuración

Antes de poder ejecutar el script `InstallService.ps1` primero debe configurarse en un archivo JSON con la siguiente estructura:

```JSON
{
  "ServiceSettings": {
    "BinPath": "ruta_absoluta_exe",
    "DisplayName": "nombre_mostrar_servicio",
    "ServiceName": "nombre_clave_servicio"
  }
}
```

donde:

- *ruta_absoluta_exe* es la ruta absoluta donde se encuentra el ejecutable del servicio.
- *nombre_mostrar_servicio* es un nombre amigable que aparecerá en interfaces que muestran los servicios.
- *nombre_clave_servicio* es el nombre único para identificar el servicio al momento de registrarlo o desinstalarlo.

Se ha dejado un archivo llamado [appsettings.json](appsettings.json) a manera de ejemplo.

# Ejecución del script

Para ejecutar la ejecución del script se debe realizar desde PowerShell ejecutado como administrador de la siguiente manera:

```
InstallService.ps1 ruta_config_json accion
```

donde:

- *ruta_config_json* es la ruta absoluta donde se encuentra el archivo de [configuración](#Configuración) JSON.
- *accion* indica la acción que se desea realizar. Admite los valores: `install` y `uninstall`. El valor `install` es para cuando deseamos instalar el servicio, `uninstall` para desinstalarlo.

A continuación un ejemplo de ejecución:

```
.\InstallService.ps1 .\appsettings.json install
```

## Importante

Para poder ejecutar scripts de PowerShell es necesario modificar una política de ejecución de scripts que por seguridad es probable que en el equipo que se pretenda ejecutar no lo permita.

Primero debemos identificar qué política de ejecución manejamos en nuestro equipo, con el siguiente comando en PowerShell:

```
Get-ExecutionPolicy
```

Normalmente nos responderá `Restricted`, si es `Unrestricted` podremos ejecutar el script sin problemas, de lo contrario para permitir la ejecución de script de PowerShell se debe ejecutar el siguiente comando como administrador en PowerShell:

```
Set-ExecutionPolicy Unrestricted
```

Luego podremos ejecutar el script como lo necesitemos y finalmente puede dejarse en la política de ejcución de scripts como estaba originalmente.

# Más información

A continuación unos enlaces de interés que pueden interesar, donde algunos fueron base para la construcción de esta herramienta.

  - [sc.exe create](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/sc-create) Registro de un servicio
  - [sc.exe delete](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/sc-delete) Eliminación de un servicio
  - [Using JSON with PowerShell: A guide for IT professionals](https://techgenix.com/json-with-powershell/) Lectura de JSON en PowerShell
  - [Habilitar la ejecución de scripts para Powershell](https://www.alexmedina.net/habilitar-la-ejecucion-de-scripts-para-powershell/)