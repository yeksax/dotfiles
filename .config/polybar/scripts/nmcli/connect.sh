#!/bin/bash

# Função para checar se o SSID existe
check_ssid() {
  ssid_exists=$(nmcli -f SSID dev wifi list | grep -w "$1")
  if [ -n "$ssid_exists" ]; then
    return 0 # Retorna 0 se o SSID existir
  else
    return 1 # Retorna 1 se o SSID não existir
  fi
}

# Função para conectar à rede Wi-Fi
connect_to_wifi() {
  nmcli dev wifi con "$1" password "$2" &> /dev/null
}

# Pedir ao usuário o SSID da rede
get_ssid() {
  read -p "Digite o nome da rede Wi-Fi
> " ssid

  check_ssid $ssid

  if [ $? -ne 0 ]; then
    echo
    echo "Rede não encontrada."
    get_ssid
  fi

}

get_ssid

# Pedir ao usuário a senha da rede
attempt=0
while true
do
  if [ $attempt -lt 3 ]; then
    echo
    read -s -p "Digite a senha da rede Wi-Fi
> " password
    echo
  fi

  connect_to_wifi $ssid $password

  if [ $? -eq 0 ]; then
    echo
    echo
    echo "Conectado à rede com sucesso!"
    break

  else
    ((attempt++))

    if [ $attempt -ge 3 ]; then
      read -p "Digite a senha da rede Wi-Fi
> " password
    fi
  fi
done
