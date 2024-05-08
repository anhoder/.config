git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew

BREW_TAPS="$(
	BREW_TAPS="$(brew tap 2>/dev/null)"
	echo -n "${BREW_TAPS//$'\n'/:}"
)"

for tap in core cask{,-fonts,-versions} command-not-found services; do
	if [[ ":${BREW_TAPS}:" == *":homebrew/${tap}:"* ]]; then # 只复原已安装的 Tap
		brew tap --custom-remote --force-auto-update "homebrew/${tap}" "https://github.com/Homebrew/homebrew-${tap}"
	fi
done

brew update
