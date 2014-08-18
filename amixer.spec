# AMixer specification file
# Created with sur-0.2.143
Sur::Specification.new do |s|
  s.name        = "AMixer"
  s.authors     = [ "0rax" ]
  s.contact     = "roemer.jp@gmail.com"
  s.date        = "Tue Aug  5 11:44:23 2014"
  s.description = "Display and control the volume of an ALSA device"
  s.notes       = <<NOTES
This sublet brings you AlsaMixer to subtle.
It shows the volume of a specific ALSA device.
If the device is availlable in AlsaMixer/Amixer, you can control it with this sublet.
You only need to have alsa-utils installed.

Bindings:
Left click toggles mute, mouse wheel up and down changes the volume.
NOTES
  s.config = [
    {
	:name        => "step",
	:type        => "integer",
	:description => "Volume increase/decrease steps",
	:def_value   => "5"
    },
    {
	:name        => "device",
	:type        => "string",
	:description => "Device to get/set volume from/to",
	:def_value   => "pulse"
    },
    {
	:name        => "prefix",
	:type        => "string",
	:description => "Prefix",
	:def_value   => ""
    },
    {
	:name        => "suffix",
	:type        => "string",
	:description => "Suffix",
	:def_value   => ""
    },
    {
	:name        => "show_icon",
	:type        => "bool",
	:description => "Show icon",
	:def_value   => true
    }
  ]
  s.version     = "0.2"
  s.tags        = [ "Amixer", "Volume", "Linux", "Config", "Grabs", "AlsaMixer", "MouseWheel" ]
  s.files       = [ "amixer.rb" ]
  s.icons    = [ "sound.xbm", "mute.xbm" ]
  s.grabs = {
      :AudioRaise  => "Increase volume",
      :AudioLower  => "Decrease volume",
      :AudioMute   => "Toggle mute"
  }
end
