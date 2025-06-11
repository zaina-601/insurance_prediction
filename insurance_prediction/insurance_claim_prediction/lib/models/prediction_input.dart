class PredictionInput {
  double psInd01;
  double psCar15;
  double psInd17Bin;
  double psReg03;
  double psCar12;
  double psInd06Bin;
  double psInd03;
  double psReg01;
  double psCar02Cat;
  double psInd05Cat;
  double psInd02Cat;
  double psCar13;
  double psReg02;
  double psInd07Bin;
  double psCar04Cat;
  double psInd16Bin;
  double psCar03Cat;
  double psCar07Cat;

  PredictionInput({
    required this.psInd01,
    required this.psCar15,
    required this.psInd17Bin,
    required this.psReg03,
    required this.psCar12,
    required this.psInd06Bin,
    required this.psInd03,
    required this.psReg01,
    required this.psCar02Cat,
    required this.psInd05Cat,
    required this.psInd02Cat,
    required this.psCar13,
    required this.psReg02,
    required this.psInd07Bin,
    required this.psCar04Cat,
    required this.psInd16Bin,
    required this.psCar03Cat,
    required this.psCar07Cat,
  });

  Map<String, dynamic> toJson() {
    return {
      'ps_ind_01': psInd01,
      'ps_car_15': psCar15,
      'ps_ind_17_bin': psInd17Bin,
      'ps_reg_03': psReg03,
      'ps_car_12': psCar12,
      'ps_ind_06_bin': psInd06Bin,
      'ps_ind_03': psInd03,
      'ps_reg_01': psReg01,
      'ps_car_02_cat': psCar02Cat,
      'ps_ind_05_cat': psInd05Cat,
      'ps_ind_02_cat': psInd02Cat,
      'ps_car_13': psCar13,
      'ps_reg_02': psReg02,
      'ps_ind_07_bin': psInd07Bin,
      'ps_car_04_cat': psCar04Cat,
      'ps_ind_16_bin': psInd16Bin,
      'ps_car_03_cat': psCar03Cat,
      'ps_car_07_cat': psCar07Cat,
    };
  }
}