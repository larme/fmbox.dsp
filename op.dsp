import("stdfaust.lib");
consts = library("consts.lib");
params = library("params.lib");
utils = library("utils.lib");

// input modulation, gate
// out audio
op(preader, op_num, my_op_idx, mod_in, gate) = audio_out, mod_out
with {
  main_freq = preader(0, params.main_freq);
  audio_out = main_freq * 0.001;
  mod_out = 0.0;
};

test_preset_waveform = waveform{440.0, 1};
test_preset_tbl = rdtable(test_preset_waveform);
test_preader = utils.param_reader(test_preset_tbl, 0);

process = op(test_preader, 0, 1, 1) : _, !;
