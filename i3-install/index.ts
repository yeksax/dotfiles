import * as p from "@clack/prompts";
import colors from "picocolors";
import fs from "fs/promises";
import { execSync as exec } from "child_process";
import { homedir, userInfo } from "os";

function getIntersection<T>(a: T[], b: T[]) {
  return a.filter((value) => b.includes(value));
}

p.intro("👋 Seja bem vindo ao script de instalação do huguinho s2");

const HOME_DIR = homedir();

if (HOME_DIR === "/root" || userInfo().uid === 0) {
  p.cancel("Este script não pode ser executado em root");
  process.exit(1);
}
const spinner = p.spinner();

const AUR_MAP: Record<string, string> = {
  spotify: "https://aur.archlinux.org/spotify.git",
  brave: "https://aur.archlinux.org/brave.git",
  "google-chrome": "https://aur.archlinux.org/google-chrome.git",
  "microsoft-edge-stable-bin":
    "https://aur.archlinux.org/microsoft-edge-stable-bin.git",
  "gnome-terminal-transparency":
    "https://aur.archlinux.org/gnome-terminal-transparency.git",
  "visual-studio-code-bin":
    "https://aur.archlinux.org/visual-studio-code-bin.git",
  "yay-bin": "https://aur.archlinux.org/yay-bin.git",
};

interface Directories {
  label: string;
  value: string;
}

let configurations: Directories[] = [];
let home: Directories[] = [];

configurations = (
  await fs.readdir("./.config/", {
    withFileTypes: true,
  })
).map((f) => ({ label: f.name, value: f.name }));

home = (
  await fs.readdir("./home/", {
    withFileTypes: true,
  })
).map((f) => ({ label: f.name, value: f.name }));

function AURPackage(package_name: string) {
  return `${package_name} ${colors.italic(colors.dim("(AUR)"))}`;
}

let sudo_pass: string;

function sudo(command: string) {
  return `echo ${sudo_pass.toString()} | sudo -S -k ${command}`;
}

const group = await p.group(
  {
    sudo_pass: () =>
      p.password({
        message: "Qual a senha para execução de comandos que requerem sudo?",
        mask: "*",
      }),

    browsers: () =>
      p.multiselect({
        message: "Escolha quais navegadores você pretende utilizar",
        options: [
          { label: "Chromium", value: "chromium" },
          { label: "Firefox", value: "firefox" },
          { label: AURPackage("Google Chrome"), value: "google-chrome" },
          {
            label: AURPackage("Microsoft Edge"),
            value: "microsoft-edge-stable-bin",
          },
          { label: AURPackage("Brave"), value: "brave" },
        ],
        initialValues: ["chromium"],
        required: false,
      }),

    text_editors: () =>
      p.multiselect({
        message: "Escolha seus editores de texto favoritos",
        options: [
          { label: "Neovim", value: "neovim" },
          {
            label: AURPackage("Visual Studio Code"),
            value: "visual-studio-code-bin",
          },
          { label: "Vim", value: "vim" },
          { label: "Nano", value: "nano" },
        ],
        initialValues: ["neovim"],
        required: false,
      }),

    terminal: () =>
      p.multiselect({
        message: "Escolha qual será seu terminal",
        options: [
          { label: "Terminator", value: "terminator" },
          { label: "XTerm", value: "xterm" },
          { label: "Gnome Terminal", value: "gnome-terminal" },
          { label: "Gnome Console", value: "gnome-console" },
          {
            label: AURPackage("Gnome Terminal Transparency"),
            value: "gnome-terminal-transparency",
          },
        ],
        initialValues: ["terminator"],
      }),

    shell: () =>
      p.select({
        message: "Escolha o seu shell padrão",
        options: [
          // @ts-ignore
          { label: "bash", value: "bash" },
          // @ts-ignore
          { label: "zsh", value: "zsh" },
        ],
        initialValue: "zsh",
      }),

    optional: () =>
      p.multiselect({
        message: "Escolha alguns outros apps",
        options: [
          { label: "Discord", value: "discord" },
          { label: `Nautilus`, value: "nautilus" },
          { label: "OBS Studio", value: "obs-studio" },
          { label: "GitHub CLI", value: "github-cli" },
          { label: "qBittorrent", value: "qbittorrent" },
          { label: "yay", value: "yay-bin" },
          { label: "VLC Media Player", value: "vlc" },
          { label: AURPackage("Spotify"), value: "spotify" },
        ],
        initialValues: ["yay-bin"],
        required: false,
      }),

    configuration_files: ({ results }) =>
      p.multiselect({
        message: "Quais arquivos de configuração você deseja copiar?",
        options: configurations,
        initialValues: [
          "i3",
          "dconf",
          "gtk-3.0",
          "polybar",
          "greenclip.toml",
          "picom",
          "rofi",
          results.text_editors!.includes("neovim") && "nvim",
          results.optional!.includes("yay-bin") && "yay",
          results.terminal!.includes("terminator") && "terminator",
        ] as string[],
      }),
  },
  {
    // On Cancel callback that wraps the group
    // So if the user cancels one of the prompts in the group this function will be called
    onCancel: ({ results }) => {
      p.cancel("Operação cancelada.");
      process.exit(0);
    },
  },
);

sudo_pass = group.sudo_pass;

let aur_packages: {
  repo: string;
  name: string;
}[] = [];

let packages = [
  ...group.browsers,
  ...group.optional,
  ...group.terminal,
  ...group.text_editors,
];

for (const pkg of packages as string[]) {
  if (Object.keys(AUR_MAP).includes(pkg)) {
    aur_packages.push({ repo: AUR_MAP[pkg], name: pkg });
    packages = packages.filter((p) => p != pkg);
  }
}

const overwritten_configs = getIntersection(
  (
    await fs.readdir(`${HOME_DIR}/.config`, {
      withFileTypes: true,
    })
  ).map((f) => f.name),
  group.configuration_files as string[],
);

if (overwritten_configs.length > 0)
  p.note(
    "~/.config/" + overwritten_configs.join("\n~/.config/"),
    "Os seguintes diretórios serão sobrescritos",
  );

const create_backup = await p.confirm({
  message:
    "Deseja criar uma pasta de backup para as configurações pré-existentes?",
  initialValue: true,
});

spinner.start("Linkando arquivos /etc/pacman.conf e /etc/systemd/logind.conf");

exec(sudo("rm -f /etc/pacman.conf"));
exec(sudo("rm -f /etc/systemd/logind.conf"));
exec(sudo("ln -s $(pwd)/system/pacman.conf /etc/pacman.conf"));
exec(sudo("ln -s $(pwd)/system/logind.conf /etc/systemd/logind.conf"));

spinner.stop("Arquivos linkados com sucesso!");

if (group.shell === "zsh") {
  spinner.start("Instalando zsh e definindo como shell padrão");
  exec(sudo(`pacman -S --needed --noconfirm zsh`));
  exec(sudo("chsh $USER -s $(which zsh)"));
  spinner.stop("zsh instalado com sucesso!");
}

if (create_backup) {
  spinner.start("Criando backup das configurações pré-existentes");

  if (!fs.exists("backup")) {
    await fs.mkdir("backup", {
      mode: "",
    });
  }

  for (const dir of overwritten_configs) {
    await fs.cp(`${HOME_DIR}/.config/${dir}`, `backup/${dir}`, {
      dereference: true,
      recursive: true,
      force: true,
    });
  }

  spinner.stop("Backup criado!");
}

spinner.start("Instalando pacotes essenciais");
exec(
  sudo(
    "pacman -S --needed --noconfirm git base-devel tldr wget feh dconf xorg lightdm lightdm-gtk-greeter i3-wm i3lock picom nodejs npm unzip neofetch scrot alsa-utils rofi noto-fonts noto-fonts-emoji noto-fonts-extra light bc jq xautomation playerctl ttf-font-awesome polybar ffmpeg ffmpegthumbnailer p7zip xclip",
  ),
);
spinner.stop("Pacotes instalados com sucesso!");

spinner.start("Instalando pacotes adicionais");
exec(sudo(`pacman -S --needed --noconfirm ${packages.join(" ")}`));
spinner.stop("Pacotes instalados com sucesso!");

const aur_errors: typeof AUR_MAP = {};

async function installPackage({ name, repo }: { name: string; repo: string }) {
  const installSpinner = p.spinner();

  installSpinner.start(`Clonando ${name} do AUR`);
  exec(`git clone ${repo}`);
  installSpinner.stop(`${name} clonado`);

  installSpinner.start(`Instalando ${name}`);
  try {
    process.on("SIGINT", () => {
      console.log("ignore :)");
    });

    exec(`cd ${name} && makepkg -si --noconfirm --clean --skippgpcheck`);
  } catch (e) {
    aur_errors[name] = e as string;
  }
  installSpinner.stop(`${name} instalado!`);

  installSpinner.start("Limpando arquivos residuais");
  await fs.rm(`${name}`, {
    force: true,
    recursive: true,
  });
  installSpinner.stop(`Arquivos residuais de ${name} foram deletados`);
}

if (aur_packages.length > 0) {
  for (const pkg of aur_packages) {
    await installPackage(pkg);
  }
}

if (Object.keys(aur_errors).length > 0) {
  const entries = Object.entries(aur_errors);

  p.note(
    entries.map((e) => `${e[0]}: ${e[1]}`).join("\n"),
    colors.red("Houveram erros !"),
  );
}

for (const config of group.configuration_files as string[]) {
  spinner.start("Linkando arquivos de configuração");
  exec(sudo(`ln -s $(pwd)/.config/${config} $HOME/.config/`));
  spinner.stop("Arquivos de configuração linkados com sucesso!");
}

spinner.start("Linkando arquivos da home");
exec(sudo(`ln -s $(pwd)/home/* $HOME/`));
spinner.stop("Arquivos da home linkados com sucesso!");

const auto_start = await p.confirm({
  message: "Tudo pronto! Deseja iniciar seu i3 agora?",
  initialValue: true,
});

let nextSteps = `Sinta-se livre para realizar qualquer outra configuração
${colors.yellow(`$`)} sudo systemctl start lightdm.service`;
if (!auto_start) p.note(nextSteps, "Tudo prontinho!");
else exec(sudo("systemctl start lightdm.service"));

p.outro("bye bye");
