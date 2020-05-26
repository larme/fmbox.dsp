import("stdfaust.lib");
consts = library("consts.lib");
params = library("params.lib");
utils = library("utils.lib");

// input modulation, gate
// out audio
op(preader, op_num, my_op_idx, mod_in, gate) = audio_out, par(i, op_num, out_to_op(i+1))
with {
  main_freq = preader(0, params.main_freq);
  harmony_ratio = preader(my_op_idx, params.harmony_ratio);
  freq = harmony_ratio * main_freq;
  amp_mi_factor = preader(my_op_idx, amp_mi_factor);

  get_out_amp(idx) = preader(my_op_idx, idx);
  audio_out = os.osc(freq + mod_in) * amp_mi_factor * get_out_amp(0);
  out_to_op(idx) = audio_out * freq * idx * get_out_amp(idx);
};

test_preset_waveform = waveform{440.0, 0, 0, 0, 0,
				1.0, 1.0, 0.5, 0.0, 0.0,
				2.0, 2.0, 0.0, 1.0, 0.0
			       };

test_preset_tbl = rdtable(test_preset_waveform);
test_preset_size = 15;
test_op_param_size = 5;
test_preader = utils.param_reader(test_preset_tbl,
				  test_preset_size,
				  test_op_param_size,
				  0);

process = op(test_preader, 2, 2, 0.0, 0) :> _ ;
