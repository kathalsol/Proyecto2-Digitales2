/* Generated by Yosys 0.9 (git sha1 1979e0b) */

(* dynports =  1  *)
(* top =  1  *)
(* src = "contador_sint.v:1" *)
module contador_sint(clk, reset, req, idx, IDLE, pop_0, pop_1, pop_2, pop_3, cuenta_sint, valid_sint);
  (* src = "contador_sint.v:26" *)
  wire [4:0] _000_;
  (* src = "contador_sint.v:26" *)
  wire [4:0] _001_;
  (* src = "contador_sint.v:26" *)
  wire [4:0] _002_;
  (* src = "contador_sint.v:26" *)
  wire [4:0] _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _084_;
  wire _085_;
  wire _086_;
  wire _087_;
  wire _088_;
  wire _089_;
  wire _090_;
  wire _091_;
  wire _092_;
  wire _093_;
  wire _094_;
  wire _095_;
  wire _096_;
  wire _097_;
  wire _098_;
  wire _099_;
  wire _100_;
  wire _101_;
  wire _102_;
  wire _103_;
  wire _104_;
  wire _105_;
  wire _106_;
  wire _107_;
  wire _108_;
  wire _109_;
  wire _110_;
  wire _111_;
  wire _112_;
  wire _113_;
  wire _114_;
  wire _115_;
  wire _116_;
  wire _117_;
  wire _118_;
  wire _119_;
  wire _120_;
  wire _121_;
  wire _122_;
  wire _123_;
  wire _124_;
  wire _125_;
  wire _126_;
  wire _127_;
  wire _128_;
  wire _129_;
  wire _130_;
  wire _131_;
  wire _132_;
  wire _133_;
  wire _134_;
  wire _135_;
  wire _136_;
  wire _137_;
  wire _138_;
  wire _139_;
  wire _140_;
  wire _141_;
  wire _142_;
  wire _143_;
  wire _144_;
  wire _145_;
  (* src = "contador_sint.v:12" *)
  input IDLE;
  (* src = "contador_sint.v:8" *)
  input clk;
  (* src = "contador_sint.v:21" *)
  wire [4:0] counter_0;
  (* src = "contador_sint.v:22" *)
  wire [4:0] counter_1;
  (* src = "contador_sint.v:23" *)
  wire [4:0] counter_2;
  (* src = "contador_sint.v:24" *)
  wire [4:0] counter_3;
  (* src = "contador_sint.v:17" *)
  output [4:0] cuenta_sint;
  (* src = "contador_sint.v:11" *)
  input [1:0] idx;
  (* src = "contador_sint.v:13" *)
  input pop_0;
  (* src = "contador_sint.v:14" *)
  input pop_1;
  (* src = "contador_sint.v:15" *)
  input pop_2;
  (* src = "contador_sint.v:16" *)
  input pop_3;
  (* src = "contador_sint.v:10" *)
  input req;
  (* src = "contador_sint.v:9" *)
  input reset;
  (* src = "contador_sint.v:18" *)
  output valid_sint;
  NOT _146_ (
    .A(idx[0]),
    .Y(_105_)
  );
  NOT _147_ (
    .A(idx[1]),
    .Y(_106_)
  );
  NOT _148_ (
    .A(counter_3[0]),
    .Y(_107_)
  );
  NOT _149_ (
    .A(pop_3),
    .Y(_108_)
  );
  NOT _150_ (
    .A(counter_3[1]),
    .Y(_109_)
  );
  NOT _151_ (
    .A(counter_3[2]),
    .Y(_110_)
  );
  NOT _152_ (
    .A(counter_3[4]),
    .Y(_111_)
  );
  NOT _153_ (
    .A(counter_1[0]),
    .Y(_112_)
  );
  NOT _154_ (
    .A(pop_1),
    .Y(_113_)
  );
  NOT _155_ (
    .A(counter_1[1]),
    .Y(_114_)
  );
  NOT _156_ (
    .A(counter_1[2]),
    .Y(_115_)
  );
  NOT _157_ (
    .A(counter_1[4]),
    .Y(_116_)
  );
  NOT _158_ (
    .A(counter_2[0]),
    .Y(_117_)
  );
  NOT _159_ (
    .A(pop_2),
    .Y(_118_)
  );
  NOT _160_ (
    .A(counter_2[1]),
    .Y(_119_)
  );
  NOT _161_ (
    .A(counter_2[2]),
    .Y(_120_)
  );
  NOT _162_ (
    .A(counter_2[4]),
    .Y(_121_)
  );
  NOT _163_ (
    .A(counter_0[0]),
    .Y(_122_)
  );
  NOT _164_ (
    .A(pop_0),
    .Y(_123_)
  );
  NOT _165_ (
    .A(counter_0[1]),
    .Y(_124_)
  );
  NOT _166_ (
    .A(counter_0[2]),
    .Y(_125_)
  );
  NOT _167_ (
    .A(counter_0[4]),
    .Y(_126_)
  );
  NAND _168_ (
    .A(IDLE),
    .B(req),
    .Y(_127_)
  );
  NOT _169_ (
    .A(_127_),
    .Y(valid_sint)
  );
  NOR _170_ (
    .A(_105_),
    .B(idx[1]),
    .Y(_128_)
  );
  NAND _171_ (
    .A(counter_1[0]),
    .B(_128_),
    .Y(_129_)
  );
  NOR _172_ (
    .A(_105_),
    .B(_106_),
    .Y(_130_)
  );
  NAND _173_ (
    .A(counter_3[0]),
    .B(_130_),
    .Y(_131_)
  );
  NAND _174_ (
    .A(_129_),
    .B(_131_),
    .Y(_132_)
  );
  NOR _175_ (
    .A(idx[0]),
    .B(_106_),
    .Y(_133_)
  );
  NAND _176_ (
    .A(counter_2[0]),
    .B(_133_),
    .Y(_134_)
  );
  NOR _177_ (
    .A(idx[0]),
    .B(idx[1]),
    .Y(_135_)
  );
  NAND _178_ (
    .A(counter_0[0]),
    .B(_135_),
    .Y(_136_)
  );
  NAND _179_ (
    .A(_134_),
    .B(_136_),
    .Y(_137_)
  );
  NOR _180_ (
    .A(_132_),
    .B(_137_),
    .Y(_138_)
  );
  NOR _181_ (
    .A(_127_),
    .B(_138_),
    .Y(cuenta_sint[0])
  );
  NAND _182_ (
    .A(counter_1[1]),
    .B(_128_),
    .Y(_139_)
  );
  NAND _183_ (
    .A(counter_3[1]),
    .B(_130_),
    .Y(_140_)
  );
  NAND _184_ (
    .A(_139_),
    .B(_140_),
    .Y(_141_)
  );
  NAND _185_ (
    .A(counter_2[1]),
    .B(_133_),
    .Y(_142_)
  );
  NAND _186_ (
    .A(counter_0[1]),
    .B(_135_),
    .Y(_143_)
  );
  NAND _187_ (
    .A(_142_),
    .B(_143_),
    .Y(_144_)
  );
  NOR _188_ (
    .A(_141_),
    .B(_144_),
    .Y(_145_)
  );
  NOR _189_ (
    .A(_127_),
    .B(_145_),
    .Y(cuenta_sint[1])
  );
  NAND _190_ (
    .A(counter_1[2]),
    .B(_128_),
    .Y(_004_)
  );
  NAND _191_ (
    .A(counter_3[2]),
    .B(_130_),
    .Y(_005_)
  );
  NAND _192_ (
    .A(_004_),
    .B(_005_),
    .Y(_006_)
  );
  NAND _193_ (
    .A(counter_2[2]),
    .B(_133_),
    .Y(_007_)
  );
  NAND _194_ (
    .A(counter_0[2]),
    .B(_135_),
    .Y(_008_)
  );
  NAND _195_ (
    .A(_007_),
    .B(_008_),
    .Y(_009_)
  );
  NOR _196_ (
    .A(_006_),
    .B(_009_),
    .Y(_010_)
  );
  NOR _197_ (
    .A(_127_),
    .B(_010_),
    .Y(cuenta_sint[2])
  );
  NAND _198_ (
    .A(counter_1[3]),
    .B(_128_),
    .Y(_011_)
  );
  NAND _199_ (
    .A(counter_3[3]),
    .B(_130_),
    .Y(_012_)
  );
  NAND _200_ (
    .A(_011_),
    .B(_012_),
    .Y(_013_)
  );
  NAND _201_ (
    .A(counter_2[3]),
    .B(_133_),
    .Y(_014_)
  );
  NAND _202_ (
    .A(counter_0[3]),
    .B(_135_),
    .Y(_015_)
  );
  NAND _203_ (
    .A(_014_),
    .B(_015_),
    .Y(_016_)
  );
  NOR _204_ (
    .A(_013_),
    .B(_016_),
    .Y(_017_)
  );
  NOR _205_ (
    .A(_127_),
    .B(_017_),
    .Y(cuenta_sint[3])
  );
  NAND _206_ (
    .A(counter_1[4]),
    .B(_128_),
    .Y(_018_)
  );
  NAND _207_ (
    .A(counter_3[4]),
    .B(_130_),
    .Y(_019_)
  );
  NAND _208_ (
    .A(_018_),
    .B(_019_),
    .Y(_020_)
  );
  NAND _209_ (
    .A(counter_2[4]),
    .B(_133_),
    .Y(_021_)
  );
  NAND _210_ (
    .A(counter_0[4]),
    .B(_135_),
    .Y(_022_)
  );
  NAND _211_ (
    .A(_021_),
    .B(_022_),
    .Y(_023_)
  );
  NOR _212_ (
    .A(_020_),
    .B(_023_),
    .Y(_024_)
  );
  NOR _213_ (
    .A(_127_),
    .B(_024_),
    .Y(cuenta_sint[4])
  );
  NOR _214_ (
    .A(_107_),
    .B(_108_),
    .Y(_025_)
  );
  NAND _215_ (
    .A(counter_3[0]),
    .B(pop_3),
    .Y(_026_)
  );
  NOR _216_ (
    .A(counter_3[0]),
    .B(pop_3),
    .Y(_027_)
  );
  NOT _217_ (
    .A(_027_),
    .Y(_028_)
  );
  NAND _218_ (
    .A(reset),
    .B(_028_),
    .Y(_029_)
  );
  NOR _219_ (
    .A(_025_),
    .B(_029_),
    .Y(_003_[0])
  );
  NOR _220_ (
    .A(_109_),
    .B(_026_),
    .Y(_030_)
  );
  NAND _221_ (
    .A(counter_3[1]),
    .B(_025_),
    .Y(_031_)
  );
  NAND _222_ (
    .A(_109_),
    .B(_026_),
    .Y(_032_)
  );
  NAND _223_ (
    .A(reset),
    .B(_032_),
    .Y(_033_)
  );
  NOR _224_ (
    .A(_030_),
    .B(_033_),
    .Y(_003_[1])
  );
  NOR _225_ (
    .A(_110_),
    .B(_031_),
    .Y(_034_)
  );
  NAND _226_ (
    .A(_110_),
    .B(_031_),
    .Y(_035_)
  );
  NAND _227_ (
    .A(reset),
    .B(_035_),
    .Y(_036_)
  );
  NOR _228_ (
    .A(_034_),
    .B(_036_),
    .Y(_003_[2])
  );
  NAND _229_ (
    .A(counter_3[3]),
    .B(_034_),
    .Y(_037_)
  );
  NOT _230_ (
    .A(_037_),
    .Y(_038_)
  );
  NOR _231_ (
    .A(counter_3[3]),
    .B(_034_),
    .Y(_039_)
  );
  NOT _232_ (
    .A(_039_),
    .Y(_040_)
  );
  NAND _233_ (
    .A(reset),
    .B(_040_),
    .Y(_041_)
  );
  NOR _234_ (
    .A(_038_),
    .B(_041_),
    .Y(_003_[3])
  );
  NOR _235_ (
    .A(_111_),
    .B(_037_),
    .Y(_042_)
  );
  NAND _236_ (
    .A(_111_),
    .B(_037_),
    .Y(_043_)
  );
  NAND _237_ (
    .A(reset),
    .B(_043_),
    .Y(_044_)
  );
  NOR _238_ (
    .A(_042_),
    .B(_044_),
    .Y(_003_[4])
  );
  NOR _239_ (
    .A(_117_),
    .B(_118_),
    .Y(_045_)
  );
  NAND _240_ (
    .A(counter_2[0]),
    .B(pop_2),
    .Y(_046_)
  );
  NOR _241_ (
    .A(counter_2[0]),
    .B(pop_2),
    .Y(_047_)
  );
  NOT _242_ (
    .A(_047_),
    .Y(_048_)
  );
  NAND _243_ (
    .A(reset),
    .B(_048_),
    .Y(_049_)
  );
  NOR _244_ (
    .A(_045_),
    .B(_049_),
    .Y(_002_[0])
  );
  NOR _245_ (
    .A(_119_),
    .B(_046_),
    .Y(_050_)
  );
  NAND _246_ (
    .A(counter_2[1]),
    .B(_045_),
    .Y(_051_)
  );
  NAND _247_ (
    .A(_119_),
    .B(_046_),
    .Y(_052_)
  );
  NAND _248_ (
    .A(reset),
    .B(_052_),
    .Y(_053_)
  );
  NOR _249_ (
    .A(_050_),
    .B(_053_),
    .Y(_002_[1])
  );
  NOR _250_ (
    .A(_120_),
    .B(_051_),
    .Y(_054_)
  );
  NAND _251_ (
    .A(_120_),
    .B(_051_),
    .Y(_055_)
  );
  NAND _252_ (
    .A(reset),
    .B(_055_),
    .Y(_056_)
  );
  NOR _253_ (
    .A(_054_),
    .B(_056_),
    .Y(_002_[2])
  );
  NAND _254_ (
    .A(counter_2[3]),
    .B(_054_),
    .Y(_057_)
  );
  NOT _255_ (
    .A(_057_),
    .Y(_058_)
  );
  NOR _256_ (
    .A(counter_2[3]),
    .B(_054_),
    .Y(_059_)
  );
  NOT _257_ (
    .A(_059_),
    .Y(_060_)
  );
  NAND _258_ (
    .A(reset),
    .B(_060_),
    .Y(_061_)
  );
  NOR _259_ (
    .A(_058_),
    .B(_061_),
    .Y(_002_[3])
  );
  NOR _260_ (
    .A(_121_),
    .B(_057_),
    .Y(_062_)
  );
  NAND _261_ (
    .A(_121_),
    .B(_057_),
    .Y(_063_)
  );
  NAND _262_ (
    .A(reset),
    .B(_063_),
    .Y(_064_)
  );
  NOR _263_ (
    .A(_062_),
    .B(_064_),
    .Y(_002_[4])
  );
  NOR _264_ (
    .A(_112_),
    .B(_113_),
    .Y(_065_)
  );
  NAND _265_ (
    .A(counter_1[0]),
    .B(pop_1),
    .Y(_066_)
  );
  NOR _266_ (
    .A(counter_1[0]),
    .B(pop_1),
    .Y(_067_)
  );
  NOT _267_ (
    .A(_067_),
    .Y(_068_)
  );
  NAND _268_ (
    .A(reset),
    .B(_068_),
    .Y(_069_)
  );
  NOR _269_ (
    .A(_065_),
    .B(_069_),
    .Y(_001_[0])
  );
  NOR _270_ (
    .A(_114_),
    .B(_066_),
    .Y(_070_)
  );
  NAND _271_ (
    .A(counter_1[1]),
    .B(_065_),
    .Y(_071_)
  );
  NAND _272_ (
    .A(_114_),
    .B(_066_),
    .Y(_072_)
  );
  NAND _273_ (
    .A(reset),
    .B(_072_),
    .Y(_073_)
  );
  NOR _274_ (
    .A(_070_),
    .B(_073_),
    .Y(_001_[1])
  );
  NOR _275_ (
    .A(_115_),
    .B(_071_),
    .Y(_074_)
  );
  NAND _276_ (
    .A(_115_),
    .B(_071_),
    .Y(_075_)
  );
  NAND _277_ (
    .A(reset),
    .B(_075_),
    .Y(_076_)
  );
  NOR _278_ (
    .A(_074_),
    .B(_076_),
    .Y(_001_[2])
  );
  NAND _279_ (
    .A(counter_1[3]),
    .B(_074_),
    .Y(_077_)
  );
  NOT _280_ (
    .A(_077_),
    .Y(_078_)
  );
  NOR _281_ (
    .A(counter_1[3]),
    .B(_074_),
    .Y(_079_)
  );
  NOT _282_ (
    .A(_079_),
    .Y(_080_)
  );
  NAND _283_ (
    .A(reset),
    .B(_080_),
    .Y(_081_)
  );
  NOR _284_ (
    .A(_078_),
    .B(_081_),
    .Y(_001_[3])
  );
  NOR _285_ (
    .A(_116_),
    .B(_077_),
    .Y(_082_)
  );
  NAND _286_ (
    .A(_116_),
    .B(_077_),
    .Y(_083_)
  );
  NAND _287_ (
    .A(reset),
    .B(_083_),
    .Y(_084_)
  );
  NOR _288_ (
    .A(_082_),
    .B(_084_),
    .Y(_001_[4])
  );
  NOR _289_ (
    .A(_122_),
    .B(_123_),
    .Y(_085_)
  );
  NAND _290_ (
    .A(counter_0[0]),
    .B(pop_0),
    .Y(_086_)
  );
  NOR _291_ (
    .A(counter_0[0]),
    .B(pop_0),
    .Y(_087_)
  );
  NOT _292_ (
    .A(_087_),
    .Y(_088_)
  );
  NAND _293_ (
    .A(reset),
    .B(_088_),
    .Y(_089_)
  );
  NOR _294_ (
    .A(_085_),
    .B(_089_),
    .Y(_000_[0])
  );
  NOR _295_ (
    .A(_124_),
    .B(_086_),
    .Y(_090_)
  );
  NAND _296_ (
    .A(counter_0[1]),
    .B(_085_),
    .Y(_091_)
  );
  NAND _297_ (
    .A(_124_),
    .B(_086_),
    .Y(_092_)
  );
  NAND _298_ (
    .A(reset),
    .B(_092_),
    .Y(_093_)
  );
  NOR _299_ (
    .A(_090_),
    .B(_093_),
    .Y(_000_[1])
  );
  NOR _300_ (
    .A(_125_),
    .B(_091_),
    .Y(_094_)
  );
  NAND _301_ (
    .A(_125_),
    .B(_091_),
    .Y(_095_)
  );
  NAND _302_ (
    .A(reset),
    .B(_095_),
    .Y(_096_)
  );
  NOR _303_ (
    .A(_094_),
    .B(_096_),
    .Y(_000_[2])
  );
  NAND _304_ (
    .A(counter_0[3]),
    .B(_094_),
    .Y(_097_)
  );
  NOT _305_ (
    .A(_097_),
    .Y(_098_)
  );
  NOR _306_ (
    .A(counter_0[3]),
    .B(_094_),
    .Y(_099_)
  );
  NOT _307_ (
    .A(_099_),
    .Y(_100_)
  );
  NAND _308_ (
    .A(reset),
    .B(_100_),
    .Y(_101_)
  );
  NOR _309_ (
    .A(_098_),
    .B(_101_),
    .Y(_000_[3])
  );
  NOR _310_ (
    .A(_126_),
    .B(_097_),
    .Y(_102_)
  );
  NAND _311_ (
    .A(_126_),
    .B(_097_),
    .Y(_103_)
  );
  NAND _312_ (
    .A(reset),
    .B(_103_),
    .Y(_104_)
  );
  NOR _313_ (
    .A(_102_),
    .B(_104_),
    .Y(_000_[4])
  );
  (* src = "contador_sint.v:26" *)
  DFF _314_ (
    .C(clk),
    .D(_000_[0]),
    .Q(counter_0[0])
  );
  (* src = "contador_sint.v:26" *)
  DFF _315_ (
    .C(clk),
    .D(_000_[1]),
    .Q(counter_0[1])
  );
  (* src = "contador_sint.v:26" *)
  DFF _316_ (
    .C(clk),
    .D(_000_[2]),
    .Q(counter_0[2])
  );
  (* src = "contador_sint.v:26" *)
  DFF _317_ (
    .C(clk),
    .D(_000_[3]),
    .Q(counter_0[3])
  );
  (* src = "contador_sint.v:26" *)
  DFF _318_ (
    .C(clk),
    .D(_000_[4]),
    .Q(counter_0[4])
  );
  (* src = "contador_sint.v:26" *)
  DFF _319_ (
    .C(clk),
    .D(_001_[0]),
    .Q(counter_1[0])
  );
  (* src = "contador_sint.v:26" *)
  DFF _320_ (
    .C(clk),
    .D(_001_[1]),
    .Q(counter_1[1])
  );
  (* src = "contador_sint.v:26" *)
  DFF _321_ (
    .C(clk),
    .D(_001_[2]),
    .Q(counter_1[2])
  );
  (* src = "contador_sint.v:26" *)
  DFF _322_ (
    .C(clk),
    .D(_001_[3]),
    .Q(counter_1[3])
  );
  (* src = "contador_sint.v:26" *)
  DFF _323_ (
    .C(clk),
    .D(_001_[4]),
    .Q(counter_1[4])
  );
  (* src = "contador_sint.v:26" *)
  DFF _324_ (
    .C(clk),
    .D(_002_[0]),
    .Q(counter_2[0])
  );
  (* src = "contador_sint.v:26" *)
  DFF _325_ (
    .C(clk),
    .D(_002_[1]),
    .Q(counter_2[1])
  );
  (* src = "contador_sint.v:26" *)
  DFF _326_ (
    .C(clk),
    .D(_002_[2]),
    .Q(counter_2[2])
  );
  (* src = "contador_sint.v:26" *)
  DFF _327_ (
    .C(clk),
    .D(_002_[3]),
    .Q(counter_2[3])
  );
  (* src = "contador_sint.v:26" *)
  DFF _328_ (
    .C(clk),
    .D(_002_[4]),
    .Q(counter_2[4])
  );
  (* src = "contador_sint.v:26" *)
  DFF _329_ (
    .C(clk),
    .D(_003_[0]),
    .Q(counter_3[0])
  );
  (* src = "contador_sint.v:26" *)
  DFF _330_ (
    .C(clk),
    .D(_003_[1]),
    .Q(counter_3[1])
  );
  (* src = "contador_sint.v:26" *)
  DFF _331_ (
    .C(clk),
    .D(_003_[2]),
    .Q(counter_3[2])
  );
  (* src = "contador_sint.v:26" *)
  DFF _332_ (
    .C(clk),
    .D(_003_[3]),
    .Q(counter_3[3])
  );
  (* src = "contador_sint.v:26" *)
  DFF _333_ (
    .C(clk),
    .D(_003_[4]),
    .Q(counter_3[4])
  );
endmodule