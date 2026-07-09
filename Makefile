.PHONY: install

install:
	sudo mkdir -p /usr/bin/local /etc/systemd/system
	sudo cp 8bitdo-sleep-fix /usr/bin/local/8bitdo-sleep-fix
	sudo cp 8bitdo-sleep-fix.service /etc/systemd/system/8bitdo-sleep-fix.service

	sudo systemctl enable 8bitdo-sleep-fix.service
	sudo systemctl daemon-reload

disable:
	sudo systemctl disable 8bitdo-sleep-fix.service
	sudo systemctl daemon-reload
