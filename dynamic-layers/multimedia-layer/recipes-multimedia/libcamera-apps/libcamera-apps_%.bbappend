# meta-raspberrypi pins libcamera-apps at the v1.9.0 release (eca9928b),
# which predates upstream f3011b5f "core: Switch libcamera string controls
# to use std::string_view" - exactly the gcc15 string_view-to-string
# conversion failures this image hit on core/rpicam_app.cpp and
# core/options.cpp. The fix is already upstream, so move the pin past it
# instead of carrying local patches. Drop this override once
# meta-raspberrypi bumps its SRCREV past f3011b5f.
SRCREV = "f3011b5fae183a463630b4168626dfefe9b4c74e"
