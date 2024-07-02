# Requirements

* Nerd Font as your terminal font.
    + Make sure the nerd font you set doesn't end with Mono to prevent small icons for best result.
* Ripgrep.
* GCC, Windows users must have mingw installed and set on path.
* Make, Windows users must have GnuWin32 installed and set on path.
* NPM
* Python3, pip

# Install

<details><summary>Unix</summary>

```
git clone https://github.com/Oniup/nvim ~/.config/nvim && nvim
```

</details> <!-- Unix -->
<details><summary>Windows</summary>

___Install required packages either through___

chocolatey:
```
winget install --accept-source-agreements chocolatey.chocolatey
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```

OR WSL:

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```

> <details><summary>Command Prompted (CMD)</summary>
> 
> ```
> git clone https://github.com/Oniup/nvim  %USERPROFILE%\AppData\Local\nvim && nvim
> ```
> 
> </details> <!-- Command Prompted -->
> <details><summary>PowerShell</summary>
> 
> ```
> git clone https://github.com/Oniup/nvim $ENV:USERPROFILE\AppData\Local\nvim && nvim
> ```
> 
> </details> <!-- PowerShell -->
</details> <!-- Windows -->

# Uninstall

<details><summary>Unix</summary>

```
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```

</details> <!-- Unix -->
<details><summary>Command Prompted (CMD)</summary>

```
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data
```

</details> <!-- Command Prompted -->
<details><summary>PowerShell</summary>

```
rm -Force ~\AppData\Local\nvim
rm -Force ~\AppData\Local\nvim-data
```

</details> <!-- PowerShell -->
