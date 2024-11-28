# Configuración Personal de la Terminal en macOS

Este documento describe los pasos necesarios para configurar una terminal en macOS con iTerm2, Neovim y varias otras herramientas esenciales para el desarrollo. La configuración está diseñada para ser fácil de seguir y personalizar. Puedes copiar y pegar los comandos para simplificar la instalación.

## 1. Instalar Homebrew
Homebrew es un administrador de paquetes que hace fácil instalar herramientas en macOS. Abre la terminal e instala Homebrew ejecutando el siguiente comando:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Despues de instalar Homebrew, asegúrate de agregarlo a tu PATH ejecutando:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$($(brew --prefix)/bin/brew shellenv)"
```

## 2. Instalar iTerm2
Instala iTerm2 usando Homebrew:

```bash
brew install --cask iterm2
```

## 3. Importar los ajustes de iTerm2
Importar el archivo con las configuraciones personalizadas para iTerm2, impórtalo desde la aplicación:

1. Abre iTerm2.
2. Ve a **Preferences > General > Preferences**.
3. Selecciona **Load preferences from a custom folder or URL** y elige la ubicación de tu archivo de configuración.

## 4. Instalar Oh My Zsh
Oh My Zsh es un marco de trabajo para gestionar la configuración de Zsh. Instálalo ejecutando:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 5. Instalar Powerlevel10k
Powerlevel10k es un tema para Zsh que hace que la terminal sea más informativa y atractiva. Instálalo con el siguiente comando:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k
```

Luego, edita tu archivo `.zshrc` para usar Powerlevel10k:

```bash
sed -i '' 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
source ~/.zshrc
```

## 6. Instalar Neovim
Instala Neovim con Homebrew ejecutando:

```bash
brew install neovim
```

## 7. Configurar `.zshrc`
Para personalizar tu archivo `.zshrc` y asegurarte de que todas las herramientas funcionen correctamente, abre `.zshrc` y agrega las siguientes líneas si es necesario:

```bash
# Agregar Homebrew al PATH
export PATH="/opt/homebrew/bin:$PATH"

# Alias para abrir Neovim
alias vim="nvim"

# Inicializar Powerlevel10k si no está ya inicializado
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Agregar otras personalizaciones...
```

Despues de editar `.zshrc`, ejecuta:

```bash
source ~/.zshrc
```

## 8. Configurar Neovim
Para configurar Neovim con tu configuración personalizada, clona el repositorio de tu configuración en el directorio adecuado:

```bash
git clone https://github.com/DavidPerezA12/nvim ~/.config/nvim
```

Esto colocará tus archivos de configuración en la ubicación que Neovim espera por defecto.

## 9. Listo
Tu terminal ahora está configurada con iTerm2, Oh My Zsh, Powerlevel10k y Neovim. Puedes personalizar la configuración según tus preferencias editando los archivos relevantes.

¡Disfruta tu nueva configuración de desarrollo!

