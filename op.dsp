import("stdfaust.lib");
consts = library("consts.lib");
params = library("params.lib");
utils = library("utils.lib");

// input modulation, gate
// out audio
op(preader, op_num, my_op_idx, mod_in, gate) = audio_out, par(i, op_num, out_to_op(i+1))
with {
  main_freq = preader(0, params.main_freq);
  audio_out = main_freq * 0.0001;
  out_to_op(idx) = idx * main_freq * 0.0001;
};

test_preset_waveform = waveform{440.0, 0, 0, 0, 0,
				1.0, 1.0, 0.5, 0.0, 0.0,
				2.0, 2.0, 0.0, 1.0, 0.0
			       };

test_preset_tbl = rdtable(test_preset_waveform);
test_preset_size = 20;
test_op_param_size = 5;
test_preader = utils.param_reader(test_preset_tbl,
				  test_preset_size,
				  test_op_param_size,
				  0);

process = op(test_preader, 2, 1, 1) :> _ ;
