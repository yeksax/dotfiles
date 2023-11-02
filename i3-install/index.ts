import * as p from "@clack/prompts"
import colors from "picocolors"
import fs from "fs"
const { exec } = require("child_process");

let configurations: {
  label: string,
  value: string
}[] = []

fs.readdir("../.config/", {
  withFileTypes: true
}, (_, files) => {
  configurations = files.map(f => ({label: f.name, value: f.name}))
})

function AURPackage(package_name: string){
  return `${package_name} ${colors.italic(colors.dim("(AUR)"))}`
}

p.intro("👋 Seja bem vindo ao script de instalação do huguinho s2")

const group = await p.group({
  browsers: () => p.multiselect({
    message: "Escolha quais navegadores você pretende utilizar",
    options: [
      { label: "Chromium", value: "chromium" },
      { label: "Firefox", value: "firefox" },
      { label: AURPackage("Brave"), value: "brave" },
    ],
    initialValues: ["chromium"],
    required: false
  }),

  text_editors: () => p.multiselect({
    message: "Escolha seus editores de texto favoritos",
    options: [
      { label: "Neovim", value: "neovim" },
      { label: AURPackage("Visual Studio Code"), value: "visual-studio-code-bin" },
      { label: "Vim", value: "vim" },
      { label: "Nano", value: "nano" },
    ],
    initialValues: ["neovim"],
    required: false
  }),

  media_players: () => p.multiselect({
    message: "Escolha seus apps relacionados a mídia",
    options: [
      { label: "VLC Media Player", value: "vlc" },
      { label: "OBS Studio", value: "obs-studio" },
      ],
    required: false
  }),

  configuration_files: async ({ results }) => p.multiselect({
    message: "Quais arquivos de configuração você deseja copiar?",
    options: configurations,
    initialValues: [
      results.text_editors!.includes("neovim") && "nvim",
    ]
  })
})

exec("sudo pacman -S --noconfirm --needed git", (error, stdout, stderr) => {
    if (error) {
        console.log(`error: ${error.message}`);
        return;
    }
    if (stderr) {
        console.log(`stderr: ${stderr}`);
        return;
    }
    console.log(`stdout: ${stdout}`);
});

let nextSteps = `${colors.yellow(`$`)} sudo systemctl start lightdm.service`

p.note(nextSteps, 'Next steps.');

