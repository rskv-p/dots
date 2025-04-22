#!/bin/bash

# Функция для вывода сообщений
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Установка драйверов NVIDIA
echo_info "Проверка установки драйвера NVIDIA..."
if ! type nvidia-smi &> /dev/null; then
    echo_info "Драйвер NVIDIA не установлен. Устанавливаем драйвер..."

    # Проверяем пакетный менеджер и устанавливаем драйвер
    if type apt-get &> /dev/null; then
        # Ubuntu / Debian
        sudo apt update
        sudo apt install -y nvidia-driver nvidia-cuda-toolkit
    elif type pacman &> /dev/null; then
        # Arch Linux / Manjaro
        sudo pacman -Syu --noconfirm nvidia nvidia-utils
    elif type dnf &> /dev/null; then
        # Fedora
        sudo dnf install -y akmod-nvidia nvidia-driver
    else
        echo_info "Поддержка установки драйвера для данной ОС не найдена."
        exit 1
    fi

    # Перезагрузим систему для применения изменений
    echo_info "Драйвер NVIDIA установлен. Требуется перезагрузка для применения изменений."
    read -p "Перезагрузить систему? [y/N]: " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        sudo reboot
    fi
else
    echo_info "Драйвер NVIDIA уже установлен."
fi

# Установка CUDA
echo_info "Проверка установки CUDA..."
if ! type nvcc &> /dev/null; then
    echo_info "CUDA не установлена. Устанавливаем CUDA..."

    # Установка CUDA
    if type apt-get &> /dev/null; then
        # Ubuntu / Debian
        sudo apt update
        sudo apt install -y nvidia-cuda-toolkit
    elif type pacman &> /dev/null; then
        # Arch Linux / Manjaro
        sudo pacman -Syu --noconfirm cuda
    elif type dnf &> /dev/null; then
        # Fedora
        sudo dnf install -y cuda
    else
        echo_info "Поддержка установки CUDA для данной ОС не найдена."
        exit 1
    fi

    # Перезагрузим систему для применения изменений
    echo_info "CUDA установлена. Требуется перезагрузка для применения изменений."
    read -p "Перезагрузить систему? [y/N]: " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        sudo reboot
    fi
else
    echo_info "CUDA уже установлена."
fi

# Установка переменных окружения для CUDA
echo_info "Настройка переменных окружения для CUDA..."
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc

# Применение изменений в текущей сессии
source ~/.bashrc

# Проверка успешности установки
echo_info "Проверяем установку NVIDIA и CUDA..."

# Проверка драйвера NVIDIA
nvidia-smi

# Проверка CUDA
nvcc --version

echo_info "Установка NVIDIA и CUDA завершена!"
