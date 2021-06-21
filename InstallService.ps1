param ($jsonPath, $action="install")

if ($null -eq $jsonPath) {
    Write-Error "No se proporcionó valor para jsonPath. Por favor indique la ubicación del archivo JSON con la configuración del servicio."
    return
}

if ($null -eq $action) {
    Write-Error "No se proporcionó valor para action. Por favor indique la acción a realizar con el servicio."
    return
}

$posiblesAcciones = "install", "uninstall"

if (!$posiblesAcciones.Contains($action)) {
    Write-Error "La acción que intenta realizar no es soportada por el script, las acciones posibles son: $posiblesAcciones}"
    return
}

Write-Information "Leyendo configuración en archivo JSON"

$json = Get-Content -Encoding UTF8 -Raw -Path $jsonPath | ConvertFrom-Json

Write-Information "Configuración en archivo JSON leida"

$json = $json.ServiceSettings
$serviceName = $json.ServiceName
$binPath = $json.BinPath
$displayName = $json.DisplayName

if ($action -eq "install") {
    Write-Host "Se procede a instalar el servicio '$serviceName'"
    sc.exe create $serviceName start="delayed-auto" binpath=$binPath displayname=$displayName
} else {
    Write-Host "Se procede a desinstalar el servicio '$serviceName'"
    sc.exe delete $json.ServiceName
}
