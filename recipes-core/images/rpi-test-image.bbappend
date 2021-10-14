INHERIT:append = " \
	populate_sdk_qt5 \
	"

SPLASH = "psplash-raspberrypi"

IMAGE_FEATURES:append = " \
	ssh-server-dropbear \
	splash \
	"

IMAGE_INSTALL:append = " \
	kernel-modules \
	seeed-linux-dtoverlays \
	qtbase \
	qtbase-plugins \
	qtbase-tools  \
	qtquickcontrols-qmlplugins \
	qtgraphicaleffects-qmlplugins \
	qtquickcontrols2 \
	ttf-dejavu-sans ttf-dejavu-sans-mono ttf-dejavu-sans-condensed \
	ttf-dejavu-serif ttf-dejavu-serif-condensed ttf-dejavu-common \
	qtcharts \
	qtquicktimeline \
	qtquickdesigner-components \
	python3-pyqt5 \
	python3-logging \
	python3-psutil \
	python3-evdev \
	evtest \
	reterminalqt5example \
	lvgl \
	iperf3 \
	i2c-tools \
	util-linux \
	e2fsprogs-resize2fs \
	parted \
	glibc \
	v4l2-test-git \
	python3-pip \
	spidev-test \
	"

