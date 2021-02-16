program MeArm10v3;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  ArduinoTools,
  ServoTimer;

begin
  //ArduinoInit;
  //UARTInit;

  // Подключаем 9,10,11,12 пин ардуино, B1-B4 для Atmega328p.
  PinMode(PIN_PORT1, avrmOutput);
  PinMode(PIN_PORT2, avrmOutput);
  PinMode(PIN_PORT3, avrmOutput);
  PinMode(PIN_PORT4, avrmOutput);

	InterruptsEnable;
  repeat
    //UARTWriteLn(IntToStr(ServoTakt));
    //Sleep10ms(100)
  until False;
end.
