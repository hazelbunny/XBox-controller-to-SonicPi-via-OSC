# Welcome to Sonic Pi

define :custchord do |ch, amp|
  use_synth :prophet
  play ch, release: amp
end

live_loop :topleft do
  use_real_time
  amp = sync "/osc*/trigger/topleft"
  custchord chord(:A3, :minor), amp[1]
end

live_loop :top do
  use_real_time
  amp = sync "/osc*/trigger/top"
  custchord chord(:D3, :minor7), amp[1]
end

live_loop :topright do
  use_real_time
  amp = sync "/osc*/trigger/topright"
  custchord chord(:G3, "7"), amp[1]
end

live_loop :right do
  use_real_time
  amp = sync "/osc*/trigger/right"
  custchord chord(:C3, :major7), amp[1]
end

live_loop :left do
  use_real_time
  amp = sync "/osc*/trigger/left"
  custchord chord(:E3, "7"), amp[1]
end

live_loop :bottomleft do
  use_real_time
  amp = sync "/osc*/trigger/bottomleft"
  custchord chord(:A3, :minor7), amp[1]
end

live_loop :bottom do
  use_real_time
  amp = sync "/osc*/trigger/bottom"
  custchord chord(:A3, "minor7"), amp[1]
end

live_loop :bottomright do
  use_real_time
  amp = sync "/osc*/trigger/bottomright"
  custchord chord(:G2, :m11), amp[1]
end