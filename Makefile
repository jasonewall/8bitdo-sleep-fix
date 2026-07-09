.PHONY: install

install:
	sudo mkdir -p /etc/scripts
	sudo cp 8bitdo-sleep-fix /etc/scripts/8bitdo-sleep-fix
	sudo cp 8bitdo-sleep-fix.service /etc/systemd/system/8bitdo-sleep-fix.service

	sudo systemctl enable 8bitdo-sleep-fix.service
	sudo systemctl daemon-reload

disable:
	sudo systemctl disable 8bitdo-sleep-fix.service
	sudo systemctl daemon-reload
