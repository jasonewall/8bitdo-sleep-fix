.PHONY: install

install:
	sudo mkdir -p /usr/local/bin /etc/systemd/system
	sudo cp 8bitdo-sleep-fix /usr/local/bin/8bitdo-sleep-fix
	sudo cp 8bitdo-sleep-fix.service /etc/systemd/system/8bitdo-sleep-fix.service

	sudo systemctl enable 8bitdo-sleep-fix.service
	sudo systemctl daemon-reload

disable:
	sudo systemctl disable 8bitdo-sleep-fix.service
	sudo systemctl daemon-reload
