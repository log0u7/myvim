# Smoke test against the LIVE install (assumes ~/.vim is set up).
.PHONY: smoke
smoke:
	vim -N -u ~/.vim/vimrc --not-a-term -S tests/smoke.vim