# packer/scripts/bootstrap-winrm.ps1

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine -Force

winrm quickconfig -q

winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
winrm set winrm/config/winrs '@{MaxConcurrentUsers="100"}'

winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client '@{TrustedHosts="*"}'

netsh advfirewall firewall add rule name="Packer WinRM 5985" protocol=TCP dir=in localport=5985 action=allow

sc.exe config winrm start= auto
Restart-Service winrm