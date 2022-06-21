delay = sample_duration(:loop_amen)
set :mainloop_on, true


live_loop :trigger_drums do
  sync "/osc*/trigger/mainloop"
  mainloop = get[:mainloop_on]
  set :mainloop_on, not(mainloop)
end



live_loop :drums do
  use_real_time
  mainloop = get[:mainloop_on]
  if mainloop == true
    sample :loop_amen
  end
  sleep delay
end

live_loop :burst_1 do
  use_real_time
  sync "/osc*/trigger/burst1"
  sample :sn_dolf , rate: 2, start: 0, finish: 0.25
  sleep 0.05*delay
  sample :sn_dolf , rate: 2, start: 0, finish: 0.25
  sleep 0.05*delay
  sample :sn_dolf , rate: 2, start: 0, finish: 0.25
end

live_loop :burst_2 do
  use_real_time
  sync "/osc*/trigger/burst2"
  sample :sn_dolf , rate: 1, start: 0, finish: 0.25
  sleep 0.05*delay
  sample :sn_dolf , rate: 1, start: 0, finish: 0.25
  5.times do
    sleep 0.1*delay
    sample :sn_dolf , rate: 1, start: 0, finish: 0.25
  end
end

live_loop :burst_3 do
  use_real_time
  sync "/osc*/trigger/burst3"
  synth :sine, amp: 0.3, note: :C4
  synth :square, amp: 0.3, note: :C4
  synth :sine, amp: 0.3, note: :G4
  synth :square, amp: 0.3, note: :G4
  synth :sine, amp: 0.3, note: :E4
  synth :square, amp: 0.3, note: :E4
end