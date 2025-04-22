#!/bin/bash

# Функция для вывода сообщений
function echo_info() {
    echo -e "\033[1;32m$1\033[0m"
}

# Устанавливаем Powerlevel10k
echo_info "Установка Powerlevel10k..."
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo_info "Powerlevel10k уже установлен."
fi

# Устанавливаем плагины для Zsh
echo_info "Установка плагинов для Zsh..."

# Плагины для автодополнений и синтаксического выделения
for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin" ]; then
        git clone https://github.com/zsh-users/$plugin ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin
    else
        echo_info "$plugin уже установлен."
    fi
done

# Плагины для Zsh
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)/' ~/.zshrc

# Устанавливаем шрифт Sarasa Mono TC Nerd Font
echo_info "Установка шрифта Sarasa Mono TC Nerd Font..."
FONT_DIR="${HOME}/.local/share/fonts"
mkdir -p $FONT_DIR

# Скачиваем шрифт с другого источника
FONT_ZIP="${FONT_DIR}/SarasaMono.zip"
curl -L -o "$FONT_ZIP" "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SarasaMono.zip"

# Проверим, что архив скачался корректно
if [ -f "$FONT_ZIP" ]; then
    unzip -o "$FONT_ZIP" -d $FONT_DIR
else
    echo_info "Ошибка при скачивании шрифта. Попробуйте еще раз."
    exit 1
fi

# Обновляем кеш шрифтов
fc-cache -r

# Настройка Zsh с Powerlevel10k
echo_info "Настройка Zsh с Powerlevel10k..."
sed -i 's|ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

# Перезагружаем конфигурацию Zsh
source ~/.zshrc

echo_info "Zsh настроен и готов к использованию! Пожалуйста, перезапустите терминал."
