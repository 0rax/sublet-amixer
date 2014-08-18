# Amixer sublet file
# Created with sur-0.1
configure :amixer do |s| # {{{
  s.interval = s.config[:interval]      || 5
  s.device   = s.config[:device]        || "pulse"
  s.prefix   = s.config[:prefix]        || ""
  s.suffix   = s.config[:suffix]        || ""
  s.show_icon= s.config[:show_icon]     || true
  s.sound    = Subtlext::Icon.new("sound.xbm")
  s.mute     = Subtlext::Icon.new("mute.xbm")
end # }}}

helper do
  def get_dev(device="pulse", chan="Master")
    `amixer -D "#{device}" get "#{chan}"`
  end

  def toggle_mute(device="pulse", chan="Master")
    `amixer -D "#{device}" set "#{chan}" toggle`
  end

  def vol_minus(step=5, device="pulse", chan="Master")
    `amixer -D "#{device}" set "#{chan}" playback "#{step}%-"`
  end

  def vol_plus(step=5, device="pulse", chan="Master")
    `amixer -D "#{device}" set "#{chan}" playback "#{step}%+"`
  end

  def set_volume(vol)
    if vol
      vstr = "%3i%" % vol.to_s
      ic = self.sound
    else
      vstr = "mute"
      ic = self.mute
    end

    if self.show_icon == true
      self.data = ic + self.prefix + vstr + self.suffix
    else
      self.data = self.prefix + vstr + self.suffix
    end
  end

  def get_volume(devInfo)
    if not devInfo
      return
    end
    vol = devInfo.match(/\[([0-9]+)%\] \[(on|off)\]/)
    volume = vol.captures[0].to_i
    if vol.captures[1] == "on"
      volume
    else
      nil
    end
  end
end

on :run do |s| # {{{
  dev = get_dev(s.device, "Master")
  vol = get_volume(dev)

  set_volume(vol)
end # }}}

on :mouse_down do |s, x, y, button| # {{{
  if button == 3
    dev = toggle_mute(s.device)
  elsif button == 4
    dev = vol_plus(1, s.device)
  elsif button == 5
    dev = vol_minus(1, s.device)
  end
  vol = get_volume(dev)

  set_volume(vol)
end # }}}

# Grabs
grab :AudioRaise do |s| # {{{
  dev = vol_plus(s.step, s.device)
  vol = get_volume(dev)

  set_volume(vol)
end # }}}

grab :AudioLower do |s| # {{{
  dev = vol_minus(s.step, s.device)
  vol = get_volume(dev)

  set_volume(vol)
end # }}}

grab :AudioMute do |s| # {{{
  dev = toggle_mute(s.device)
  vol = get_volume(dev)

  set_volume(vol)
end # }}}
