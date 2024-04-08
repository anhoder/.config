for tap in core cask{,-fonts,-versions} command-not-found services; do
	brew tap --custom-remote --force-auto-update "homebrew/${tap}" "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git"
done

brew update
