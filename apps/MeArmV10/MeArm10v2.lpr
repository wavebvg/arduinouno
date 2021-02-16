program MeArm10v2;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  UIRRemote,
  ServoTimerISR,
  ArduinoTools,
  ServoTimer;

const
  PIN_PORT1 = 11;
  PIN_PORT2 = 12;

  FULL_CIRCLE = 1250;

var
  VServo1, VServo2: TTimerServo;
  ActiveServo: PCustomServo;
  c: char;
  i: byte;

begin
  UARTInit;

  // TCCR1A - регистр управления A.
  TCCR1A := 0;

  // TCCR1B - регистр управления B.
  TCCR1B := 0;

  // TCCR1A - регистр управления A.
  // TCCR1B - регистр управления B.
  // Биты WGM13 (4) , WGM12 (3) регистра TCCR1B и биты WGM11 (1) , WGM10 (0) регистра TCCR1A устанавливают режим работы таймера/счетчика T1:
  // 0000 - обычный режим
  // 0001 - коррекция фазы PWM, 8-бит
  // 0010 - коррекция фазы PWM, 9-бит
  // 0011 - коррекция фазы PWM, 10-бит
  // 0100 - режим счета импульсов (OCR1A) (сброс при совпадении)
  // 0101 - PWM, 8-бит
  // 0110 - PWM, 9-бит
  // 0111 - PWM, 10-бит
  // 1000 - коррекция фазы и частоты PWM (ICR1)
  // 1001 - коррекция фазы и частоты PWM (OCR1A)
  // 1010 - коррекция фазы PWM (ICR1)
  // 1011 - коррекция фазы и частоты PWM (OCR1A)
  // 1100 - режим счета импульсов (ICR1) (сброс при совпадении)
  // 1101 - резерв
  // 1110 - PWM (ICR1)
  // 1111 - PWM (OCR1A)

  // 0100 - режим счета импульсов (OCR1A) (сброс при совпадении)
  TCCR1A := TCCR1A or (0 shl WGM11) or (0 shl WGM10);

  TCCR1B := TCCR1B or (1 shl WGM12) or (0 shl WGM13);

  // TCCR1A - регистр управления A.
  // Биты COM1A1 (7) и COM1A0 (6) влияют на то, какой сигнал появится на выводе OC1A (15 ножка) при совпадении с A (совпадение значения счетного регистра TCNT1 со значением регистра сравнения OCR1A):
    (* 1. Обычный режим
    00 - вывод OC1A не функционирует
    01 - изменение состояния вывода OC1A на противоположное при совпадении с A
    10 - сброс вывода OC1A в 0 при совпадении с A
    11 - установка вывода OC1A в 1 при совпадении с A
        2. Режим ШИМ
    00 - вывод OC1A не функционирует
    01 - если биты WGM13 - WGM10 установлены в (0000 - 1101), вывод OC1A не функционирует
    01 - если биты WGM13 - WGM10 установлены в 1110 или 1111, изменение состояния вывода OC0A на противоположное при совпадении с A
    10 - сброс вывода OC1A в 0 при совпадении с A, установка  вывода OC1A в 1 если регистр TCNT1 принимает значение 0x00 (неинверсный режим)
    11 - установка вывода OC1A в 1 при совпадении с A, установка  вывода OC1A в 0 если регистр TCNT1 принимает значение 0x00  (инверсный режим)
        3. Режим коррекции фазы ШИМ
    00 - вывод OC1A не функционирует
    01 - если биты WGM13 - WGM10 установлены в (0000 - 1100, 1010, 1100 - 1111), вывод OC1A не функционирует
    01 - если биты WGM13 - WGM10 установлены в 1101 или 1011, изменение состояния вывода OC1A на противоположное при совпадении с A
    10 - сброс вывода OC1A в 0 при совпадении с A во время увеличения значения счетчика, установка  вывода OC1A в 1  при совпадении с A во время уменьшения значения счетчика
    11 - установка вывода OC1A в 1 при совпадении с A во время увеличения значения счетчика, сброс  вывода OC1A в 0  при совпадении с A во время уменьшения значения счетчика
    *)
  TCCR1A := TCCR1A or (0 shl COM1A1) or (0 shl COM1A0);

  // Разрешают прерывания при совпадении с A.
  TIMSK1 := TIMSK1 or (1 shl OCIE1A);

  // TCCR1B - регистр управления B.
  // Биты CS12 (2), CS11 (1), CS10 (0) регистра TCCR1B устанавливают режим тактирования и предделителя тактовой частоты таймера/счетчика T1:
  // 000 - таймер/счетчик T1 остановлен
  // 001 - тактовый генератор CLK
  // 010 - CLK/8
  // 011 - CLK/64
  // 100 - CLK/256
  // 101 - CLK/1024
  // 110 - внешний источник на выводе T1 (11 ножка) по спаду сигнала
  // 111 - внешний источник на выводе T1 (11 ножка) по возрастанию сигнала
  // 011 - CLK/64
  TCCR1B := TCCR1B or (0 shl CS12) or (1 shl CS11) or (1 shl CS10);

  VServo1.Init(PIN_PORT1);
  VServo1.Angle := 150;
  VServo2.Init(PIN_PORT2);
  VServo2.Angle := 450;
  ActiveServo := @VServo1;
  InterruptsEnable;
  repeat
    //Sleep10ms(100);
    UARTWrite('MAX_SERVO_COUNT = ');
    UARTWriteLn(IntToStr(MAX_SERVO_COUNT));
    for i := 0 to MAX_SERVO_COUNT - 1 do
    begin
      if ServoInfos[i].Active then
        UARTWrite('1 (')
      else
        UARTWrite('0 (');
      UARTWrite(IntToStr(ServoInfos[i].Angle));
      UARTWrite('/');
      UARTWrite(IntToStr(ServoInfos[i].OCR1A));
      UARTWrite(') ');
    end;
    UARTWriteLn('');
    UARTWrite('ServoTakt = ');
    UARTWriteLn(IntToStr(ServoTakt));
    c := UARTReadChar;
    case c of
      '1': ActiveServo^.Angle := ActiveServo^.Angle + 50;
      '2': ActiveServo^.Angle := ActiveServo^.Angle - 50;
      //'3': ActiveServo^.Angle := FULL_CIRCLE * 20 div 180;
      //'4': ActiveServo^.Angle := FULL_CIRCLE * 30 div 180;
      //'5': ActiveServo^.Angle := FULL_CIRCLE * 40 div 180;
      //'6': ActiveServo^.Angle := FULL_CIRCLE * 50 div 180;
      //'7': ActiveServo^.Angle := FULL_CIRCLE * 60 div 180;
      //'8': ActiveServo^.Angle := FULL_CIRCLE * 70 div 180;
      //'9': ActiveServo^.Angle := FULL_CIRCLE * 80 div 180;
      //'0': ActiveServo^.Angle := FULL_CIRCLE * 90 div 180;
      //'q': ActiveServo^.Angle := FULL_CIRCLE * 100 div 180;
      //'w': ActiveServo^.Angle := FULL_CIRCLE * 110 div 180;
      //'e': ActiveServo^.Angle := FULL_CIRCLE * 120 div 180;
      //'r': ActiveServo^.Angle := FULL_CIRCLE * 130 div 180;
      //'t': ActiveServo^.Angle := FULL_CIRCLE * 140 div 180;
      //'y': ActiveServo^.Angle := FULL_CIRCLE * 150 div 180;
      //'u': ActiveServo^.Angle := FULL_CIRCLE * 160 div 180;
      //'i': ActiveServo^.Angle := FULL_CIRCLE * 170 div 180;
      'o': ActiveServo^.Angle := 600;
      'a': ActiveServo := @VServo1;
      's': ActiveServo := @VServo2;
      else
        Sleep10ms(10);
    end;
  until False;
end.
