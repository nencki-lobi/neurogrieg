### SDL header part

scenario_type = fMRI;
pulses_per_scan = 1;
pulse_code = 111;

no_logfile = false;

response_matching = simple_matching;
active_buttons = 3;
button_codes = 11,12,13;

default_background_color = 68, 81, 95;
default_text_color = 68, 81, 95;
default_font_size = 42;
default_font = "Helvetica";

### SDL part

begin;

TEMPLATE "./cet/cet.tem";

# PCL part

begin_pcl;

input_file cet_file = new input_file;
cet_file.open("./cet/stimuli/cet.txt");
cet_file.set_delimiter('\t');

wait_for_scanner_trial.present();

include "./cet/cet.pcl";

the_end_trial.present();