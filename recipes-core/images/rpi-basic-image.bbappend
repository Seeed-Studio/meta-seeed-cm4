INHERIT_append = " \
	populate_sdk_qt5 \
	"

IMAGE_INSTALL_append = " \
	kernel-module-mipi-dsi \
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
	reterminalqt5example \
	"

