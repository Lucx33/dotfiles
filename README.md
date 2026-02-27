# dotfiles

Configuração pessoal do meu ambiente Hyprland no Arch Linux.

---

## Ambiente

| Componente | Software |
|---|---|
| Compositor | [Hyprland](https://hyprland.org/) |
| Status bar | [Waybar](https://github.com/Alexays/Waybar) |
| Terminal | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| Launcher | [Rofi](https://github.com/davatorium/rofi) |
| Wallpaper | [swww](https://github.com/LGFae/swww) |
| Shell | Bash |
| Fetch | [Fastfetch](https://github.com/fastfetch-cli/fastfetch) |
| Fontes | JetBrainsMono Nerd Font, Symbols Nerd Font |

---

## Estrutura

```
~/.config/
├── hypr/
│   ├── hyprland.conf       # Config principal
│   ├── hyprpaper.conf      # Wallpaper ativo
│   └── theme-colors.conf   # Cores do tema ativo (gerado pelo switch)
├── waybar/
│   ├── config.jsonc        # Módulos e layout
│   └── style.css           # Estilo do tema ativo
├── kitty/
│   ├── kitty.conf          # Config principal
│   └── current-theme.conf  # Cores do tema ativo (gerado pelo switch)
├── rofi/
│   ├── config.rasi         # Config principal
│   └── current-theme.rasi  # Cores do tema ativo (gerado pelo switch)
├── fastfetch/
│   └── config.jsonc        # Config e cores do tema ativo
├── scripts/
│   ├── battery-bar.sh      # Widget de bateria com animação
│   ├── brightness-bar.sh   # Widget de brilho com ícone animado
│   └── sys-stats.sh        # Widget CPU + memória combinados
└── themes/
    ├── switch.sh           # Script de alternância de temas
    ├── nord/               # Tema azul (padrão)
    │   ├── colors.conf
    │   ├── waybar.css
    │   ├── kitty.conf
    │   ├── rofi.rasi
    │   ├── fastfetch.jsonc
    │   └── hyprpaper.conf
    └── lancer/             # Tema amarelo
        ├── colors.conf
        ├── waybar.css
        ├── kitty.conf
        ├── rofi.rasi
        ├── fastfetch.jsonc
        └── hyprpaper.conf
```

---

## Temas

Dois temas disponíveis, alternados com atalho ou script. Cada tema muda simultaneamente: wallpaper, waybar, kitty, rofi, fastfetch e bordas do Hyprland.

| | Nord | Lancer |
|---|---|---|
| Accent | `#77BDFD` | `#FFD700` |
| Background | `#1d2021` | `#0a0a0a` |
| Wallpaper | Mitsubishi Lancer Evo 9 | Lancer Evolution Black |

### Alternar temas

```bash
# Via script
~/.config/themes/switch.sh nord
~/.config/themes/switch.sh lancer

# Via atalho
Ctrl + Super + 1   # Nord
Ctrl + Super + 2   # Lancer
```

A transição do wallpaper usa animação `center` do swww.

---

## Waybar

Widgets customizados no lado direito:

| Widget | Descrição |
|---|---|
| `󰅶` Café | Idle inhibitor — ícone muda ao ativar/desativar |
| `` Volume | PulseAudio — clique abre pavucontrol |
| `󰖩` Rede | Sinal Wi-Fi — hover mostra SSID, IP, velocidade |
| `` Sistema | CPU + Memória combinados — hover mostra detalhes |
| `` Temperatura | Temperatura da CPU |
| `󰃠` Brilho | Barra com ícone animado — scroll para ajustar |
| `󰁹` Bateria | Barra com animação de carga — vermelho abaixo de 20% |

---

## Atalhos principais

| Atalho | Ação |
|---|---|
| `Super + T` | Terminal (Kitty) |
| `Super + R` | Launcher (Rofi) |
| `Super + B` | Navegador |
| `Super + E` | Gerenciador de arquivos |
| `Super + L` | Bloquear tela |
| `Super + C` | Fechar janela |
| `Super + V` | Floating toggle |
| `Super + 1-9` | Mudar workspace |
| `Super + Shift + 1-9` | Mover janela para workspace |
| `Ctrl + Super + 1` | Tema Nord |
| `Ctrl + Super + 2` | Tema Lancer |

---

## Instalação

```bash
# Clone como bare repo
git clone --bare https://github.com/Lucx33/dotfiles.git $HOME/.dotfiles

# Alias temporário
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Aplica os arquivos
dotfiles checkout

# Ignora arquivos não rastreados
dotfiles config status.showUntrackedFiles no
```

### Dependências

```bash
yay -S hyprland waybar kitty rofi-wayland swww \
       fastfetch brightnessctl pavucontrol \
       ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols \
       ttf-font-awesome
```
