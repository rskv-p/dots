#!/bin/bash

# Установка KVM и QEMU
echo "Устанавливаю KVM и QEMU..."

# Установка зависимостей
sudo apt update
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

# Проверка поддержки виртуализации
if ! egrep -c '(vmx|svm)' /proc/cpuinfo; then
  echo "Ваш процессор не поддерживает виртуализацию. Прерываю установку."
  exit 1
fi

# Добавление пользователя в группу libvirt для управления виртуальными машинами без sudo
sudo usermod -aG libvirt $USER

# Перезапуск системы для применения изменений в группах
echo "Для применения изменений в группах перезагрузите систему или выполните команду: newgrp libvirt"

# Установка Virt-Manager
echo "Устанавливаю Virt-Manager..."

# Установка Virt-Manager для графического интерфейса управления виртуальными машинами
sudo apt install -y virt-manager

# Проверка установки
if type "virt-manager" &>/dev/null; then
  echo "Virt-Manager установлен успешно."
else
  echo "Не удалось установить Virt-Manager."
  exit 1
fi

echo "KVM + QEMU установлены. Для управления виртуальными машинами используйте Virt-Manager или команды virsh."

# Завершаем установку
echo "Готово! Теперь можно создавать и управлять виртуальными машинами через Virt-Manager."
