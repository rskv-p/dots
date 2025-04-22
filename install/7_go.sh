#!/bin/bash

# Функция для вывода сообщений
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Проверка, установлен ли Go
if type go &> /dev/null; then
    echo_info "Go уже установлен, пропускаем установку."
    exit 0
fi

# Определяем платформу
OS=$(uname -s)
ARCH=$(uname -m)

# Скачиваем Go для соответствующей платформы
GO_VERSION="1.20.5"  # Укажите актуальную версию Go
if [ "$OS" == "Linux" ]; then
    if [ "$ARCH" == "x86_64" ]; then
        GO_URL="https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
    elif [ "$ARCH" == "arm64" ]; then
        GO_URL="https://golang.org/dl/go$GO_VERSION.linux-arm64.tar.gz"
    else
        echo_info "Поддержка для $ARCH не найдена."
        exit 1
    fi
elif [ "$OS" == "Darwin" ]; then
    GO_URL="https://golang.org/dl/go$GO_VERSION.darwin-amd64.tar.gz"
else
    echo_info "Поддержка для вашей ОС ($OS) не найдена."
    exit 1
fi

# Скачиваем и распаковываем Go
echo_info "Скачивание Go..."
curl -LO "$GO_URL"
tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"

# Настроим переменные окружения
echo_info "Настройка переменных окружения..."
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export GOBIN=$GOPATH/bin' >> ~/.bashrc
source ~/.bashrc

# Проверим установку Go
echo_info "Проверка установки Go..."
go version

# Уведомление о завершении установки
echo_info "Go успешно установлен и настроен!"
