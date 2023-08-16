DEF_FALLBACK_NTP_SERVERS ?= "ntp.ntsc.ac.cn pool.ntp.org"
EXTRA_OEMESON += ' \
	-Dntp-servers="${DEF_FALLBACK_NTP_SERVERS}" \
'

