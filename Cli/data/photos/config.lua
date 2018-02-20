do local _ = {
  admins = {},
  disabled_channels = {},
  enabled_plugins = {
    "banhammer",
    "megaplus",
    "msg-checks",
    "plugins",
    "sudo",
    "fun-help",
    "rmsgfa",
    "rmsgen",
    "AddGP",
    "warn",
    "info",
    "rank",
    "ping"
  },
  info_text = "💥Radical Bot \n\n▪️Version:\n(TDBot v3.0)\n\n▫️GitHub™\n\nhttps://github.com\n\n》Admins\n》@SudoRadical ➣ Founder & Developer\n》@ ➣ Developer\n\n💥Our channel :\n》@RadicalBotTeam《\n",
  moderation = {
    data = "./data/moderation.json"
  },
  sudo_users = {
    516488530,
    517517253,
    436928411
  }
}
return _
end
