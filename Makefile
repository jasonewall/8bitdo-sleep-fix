
.PHONY: detect
detect:
	chmod +x detect.sh
	./detect.sh
	sudo mkdir -p /etc/default
	sudo install -m 0644 8bitdo-sleep-fix.env /etc/default/8bitdo-sleep-fix

.PHONY: install
install: detect
	sudo mkdir -p /etc/scripts
	$(MAKE) copy
	$(MAKE) enable

.PHONY: copy
copy:
	sudo cp 8bitdo-sleep-fix /etc/scripts/8bitdo-sleep-fix
	sudo chmod +x /etc/scripts/8bitdo-sleep-fix
	sudo cp 8bitdo-sleep-fix.service /etc/systemd/system/8bitdo-sleep-fix.service

.PHONY: update
update: copy

	sudo systemctl reenable 8bitdo-sleep-fix.service
	sudo systemctl daemon-reload

.PHONY: enable
enable:
	sudo systemctl enable 8bitdo-sleep-fix.service
	sudo systemctl daemon-reload

.PHONY: disable
disable:
	sudo systemctl disable 8bitdo-sleep-fix.service
	sudo systemctl daemon-reload

.PHONY: uninstall
uninstall: disable
	sudo rm -f /etc/scripts/8bitdo-sleep-fix
	sudo rm -f /etc/systemd/system/8bitdo-sleep-fix.service

.PHONY: dump
dump:
	sudo systemctl status 8bitdo-sleep-fix.service
	sudo journalctl -u 8bitdo-sleep-fix.service -n 50 --no-pager
	cat /etc/default/8bitdo-sleep-fix
