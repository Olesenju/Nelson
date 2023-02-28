const int IR_PIN = 2;         // Pin al que está conectado el sensor infrarrojo
unsigned long last_time = 0;  // Último tiempo registrado
unsigned long time_diff = 0;  // Diferencia de tiempo entre las últimas dos mediciones
volatile int rev_count = 0;   // Contador de revoluciones del sensor infrarrojo
float rpm = 0;                // Velocidad en revoluciones por minuto

//variables tiraled
#include <Adafruit_NeoPixel.h>
#define PIN 12       //PIN DIN
#define NUM_LEDS 10  //NUMERO DE LEDS
Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, PIN, NEO_GRB + NEO_KHZ800);

//configurar cada que mostrar
byte led1[37][3] = {
  ///cambiar el color cada 10 grados
  { 0, 0, 0 },  // 0grados
  { 0, 0, 0 },  //10" grados
  { 0, 0, 0 },  // 20grados
  { 0, 0, 0 },  // 30 grados
  { 0, 0, 0 },  // 40 grados
  { 0, 0, 0 },  // 50 grados
  { 0, 0, 0 },  // 60 grados
  { 0, 0, 0 },  // 70 grados
  { 0, 0, 0 },  // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },  // 100grados
  { 200, 0, 0 },  //110 grados
  { 200, 0, 0 },  //   120grados
  { 200, 0, 0 },  // 130grados
  { 200, 0, 0 },  // 140grados
  { 200, 0, 0 },  // 150grados
  { 200, 0, 0 },  // 160grados
  { 0, 0, 0 },  //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },  //190grados
  { 0, 0, 0 },  // 200grados
  { 0, 0, 0 },  //210
  { 0, 0, 0 },  // 220
  { 0, 0, 0 },  //230
  { 0, 0, 0 },  // 240
  { 0, 0, 0 },  // 250
  { 0, 0, 0 },  // 260
  { 0, 0, 0 },  //270
  { 0, 0, 0 },  //280
  { 0, 0, 0 },  // 290
  { 0, 0, 0 },  //300
  { 0, 0, 0 },  //310
  { 0, 0, 0 },  //320
  { 0, 0, 0 },  // 330
  { 0, 0, 0 },  //340
  { 0, 0, 0 },  // 350
  { 0, 0, 0 }   //360
};
//configurar cada que mostrar
byte led2[37][3] = {
  ///cambiar el color cada 10 grados
 { 0, 0, 0 },    // 0grados
  { 0, 0, 0 },    //10" grados
  { 0, 0, 0 },    // 20grados
  { 0, 0, 0 },    // 30 grados
  { 0, 0, 0 },    // 40 grados
  { 0, 0, 0 },    // 50 grados
  { 0, 0, 0 },    // 60 grados
  { 0, 0, 0 },    // 70 grados
  { 0, 0, 0 },    // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },    // 100grados
  { 0, 0, 0 },  //110 grados
  { 0, 0, 0 },  //   120grados
  { 0, 0, 0 },  // 130grados
  { 0, 0, 0 },    // 140grados
  { 0, 0, 0 },  // 150grados
  { 0, 0, 0 },    // 160grados
  { 0, 0, 0 },    //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },    //190grados
  { 0, 0, 0 },    // 200grados
  { 0, 0, 0 },    //210
  { 0, 0, 0 },    // 220
  { 0, 0, 0 },    //230
  { 0, 0, 0 },    // 240
  { 0, 0, 0 },    // 250
  { 0, 0, 0 },    // 260
  { 0, 0, 0 },    //270
  { 0, 0, 0 },    //280
  { 0, 0, 0 },    // 290
  { 0, 0, 0 },    //300
  { 0, 0, 0 },    //310
  { 0, 0, 0 },    //320
  { 0, 0, 0 },    // 330
  { 0, 0, 0 },    //340
  { 0, 0, 0 },    // 350
  { 0, 0, 0 }     //360
};
//configurar cada que mostrar
byte led3[37][3] = {
  ///cambiar el color cada 10 grados
  { 0, 0, 0 },    // 0grados
  { 0, 0, 0 },    //10" grados
  { 0, 0, 0 },    // 20grados
  { 0, 0, 0 },    // 30 grados
  { 0, 0, 0 },    // 40 grados
  { 0, 0, 0 },    // 50 grados
  { 0, 0, 0 },    // 60 grados
  { 0, 0, 0 },    // 70 grados
  { 0, 0, 0 },    // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },    // 100grados
  { 0, 0, 0 },  //110 grados
    { 0, 200, 0 },  //   120grados
  { 0, 0, 0 },  // 130grados
  { 0, 0, 0 },    // 140grados
  { 0, 200, 0 },  // 150grados
  { 0, 0, 0 },    // 160grados
  { 0, 0, 0 },    //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },    //190grados
  { 0, 0, 0 },    // 200grados
  { 0, 0, 0 },    //210
  { 0, 0, 0 },    // 220
  { 0, 0, 0 },    //230
  { 0, 0, 0 },    // 240
  { 0, 0, 0 },    // 250
  { 0, 0, 0 },    // 260
  { 0, 0, 0 },    //270
  { 0, 0, 0 },    //280
  { 0, 0, 0 },    // 290
  { 0, 0, 0 },    //300
  { 0, 0, 0 },    //310
  { 0, 0, 0 },    //320
  { 0, 0, 0 },    // 330
  { 0, 0, 0 },    //340
  { 0, 0, 0 },    // 350
  { 0, 0, 0 }     //360
};
//configurar cada que mostrar
byte led4[37][3] = {
  ///cambiar el color cada 10 grados
    { 0, 0, 0 },    // 0grados
  { 0, 0, 0 },    //10" grados
  { 0, 0, 0 },    // 20grados
  { 0, 0, 0 },    // 30 grados
  { 0, 0, 0 },    // 40 grados
  { 0, 0, 0 },    // 50 grados
  { 0, 0, 0 },    // 60 grados
  { 0, 0, 0 },    // 70 grados
  { 0, 0, 0 },    // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },    // 100grados
  { 0, 0, 0 },  //110 grados
  { 0, 200, 0 },  //   120grados
  { 0, 0, 0 },  // 130grados
  { 0, 0, 0 },    // 140grados
  { 0, 200, 0 },  // 150grados
  { 0, 0, 0 },    // 160grados
  { 0, 0, 0 },    //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },    //190grados
  { 0, 0, 0 },    // 200grados
  { 0, 0, 0 },    //210
  { 0, 0, 0 },    // 220
  { 0, 0, 0 },    //230
  { 0, 0, 0 },    // 240
  { 0, 0, 0 },    // 250
  { 0, 0, 0 },    // 260
  { 0, 0, 0 },    //270
  { 0, 0, 0 },    //280
  { 0, 0, 0 },    // 290
  { 0, 0, 0 },    //300
  { 0, 0, 0 },    //310
  { 0, 0, 0 },    //320
  { 0, 0, 0 },    // 330
  { 0, 0, 0 },    //340
  { 0, 0, 0 },    // 350
  { 0, 0, 0 }     //360
};
//configurar cada que mostrar
byte led5[37][3] = {
  ///cambiar el color cada 10 grados
   { 0, 0, 0 },    // 0grados
  { 0, 0, 0 },    //10" grados
  { 0, 0, 0 },    // 20grados
  { 0, 0, 0 },    // 30 grados
  { 0, 0, 0 },    // 40 grados
  { 0, 0, 0 },    // 50 grados
  { 0, 0, 0 },    // 60 grados
  { 0, 0, 0 },    // 70 grados
  { 0, 0, 0 },    // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },    // 100grados
  { 0, 0, 0 },  //110 grados
    { 0, 200, 0 },  //   120grados
  { 0, 0, 0 },  // 130grados
  { 0, 0, 0 },    // 140grados
  { 0, 200, 0 },  // 150grados
  { 0, 0, 0 },    // 160grados
  { 0, 0, 0 },    //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },    //190grados
  { 0, 0, 0 },    // 200grados
  { 0, 0, 0 },    //210
  { 0, 0, 0 },    // 220
  { 0, 0, 0 },    //230
  { 0, 0, 0 },    // 240
  { 0, 0, 0 },    // 250
  { 0, 0, 0 },    // 260
  { 0, 0, 0 },    //270
  { 0, 0, 0 },    //280
  { 0, 0, 0 },    // 290
  { 0, 0, 0 },    //300
  { 0, 0, 0 },    //310
  { 0, 0, 0 },    //320
  { 0, 0, 0 },    // 330
  { 0, 0, 0 },    //340
  { 0, 0, 0 },    // 350
  { 0, 0, 0 }     //360
};
byte led6[37][3] = {
  ///cambiar el color cada 10 grados
   { 0, 0, 0 },    // 0grados
  { 0, 0, 0 },    //10" grados
  { 0, 0, 0 },    // 20grados
  { 0, 0, 0 },    // 30 grados
  { 0, 0, 0 },    // 40 grados
  { 0, 0, 0 },    // 50 grados
  { 0, 0, 0 },    // 60 grados
  { 0, 0, 0 },    // 70 grados
  { 0, 0, 0 },    // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },    // 100grados
  { 0, 0, 0 },  //110 grados
    { 0, 200, 0 },  //   120grados
  { 0, 0, 0 },  // 130grados
  { 0, 0, 0 },    // 140grados
  { 0, 200, 0 },  // 150grados
  { 0, 0, 0 },    // 160grados
  { 0, 0, 0 },    //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },    //190grados
  { 0, 0, 0 },    // 200grados
  { 0, 0, 0 },    //210
  { 0, 0, 0 },    // 220
  { 0, 0, 0 },    //230
  { 0, 0, 0 },    // 240
  { 0, 0, 0 },    // 250
  { 0, 0, 0 },    // 260
  { 0, 0, 0 },    //270
  { 0, 0, 0 },    //280
  { 0, 0, 0 },    // 290
  { 0, 0, 0 },    //300
  { 0, 0, 0 },    //310
  { 0, 0, 0 },    //320
  { 0, 0, 0 },    // 330
  { 0, 0, 0 },    //340
  { 0, 0, 0 },    // 350
  { 0, 0, 0 }     //360
};
byte led7[37][3] = {
  ///cambiar el color cada 10 grados
  { 0, 0, 0 },    // 0grados
  { 0, 0, 0 },    //10" grados
  { 0, 0, 0 },    // 20grados
  { 0, 0, 0 },    // 30 grados
  { 0, 0, 0 },    // 40 grados
  { 0, 0, 0 },    // 50 grados
  { 0, 0, 0 },    // 60 grados
  { 0, 0, 0 },    // 70 grados
  { 0, 0, 0 },    // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },    // 100grados
  { 0, 0, 0 },  //110 grados
  { 0, 0, 0 },  //   120grados
  { 0, 0, 0 },  // 130grados
  { 0, 0, 0 },    // 140grados
  { 0, 0, 0 },  // 150grados
  { 0, 0, 0 },    // 160grados
  { 0, 0, 0 },    //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },    //190grados
  { 0, 0, 0 },    // 200grados
  { 0, 0, 0 },    //210
  { 0, 0, 0 },    // 220
  { 0, 0, 0 },    //230
  { 0, 0, 0 },    // 240
  { 0, 0, 0 },    // 250
  { 0, 0, 0 },    // 260
  { 0, 0, 0 },    //270
  { 0, 0, 0 },    //280
  { 0, 0, 0 },    // 290
  { 0, 0, 0 },    //300
  { 0, 0, 0 },    //310
  { 0, 0, 0 },    //320
  { 0, 0, 0 },    // 330
  { 0, 0, 0 },    //340
  { 0, 0, 0 },    // 350
  { 0, 0, 0 }     //360
};
byte led8[370][3] = {
  ///cambiar el color cada 10 grados
   { 0, 0, 0 },    // 0grados
  { 0, 0, 0 },    //10" grados
  { 0, 0, 0 },    // 20grados
  { 0, 0, 0 },    // 30 grados
  { 0, 0, 0 },    // 40 grados
  { 0, 0, 0 },    // 50 grados
  { 0, 0, 0 },    // 60 grados
  { 0, 0, 0 },    // 70 grados
  { 0, 0, 0 },    // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },    // 100grados
  { 0, 0, 0 },  //110 grados
  { 0, 0, 0 },  //   120grados
  { 0, 0, 0 },  // 130grados
  { 0, 0, 0 },    // 140grados
  { 0, 0, 0 },  // 150grados
  { 0, 0, 0 },    // 160grados
  { 0, 0, 0 },    //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },    //190grados
  { 0, 0, 0 },    // 200grados
  { 0, 0, 0 },    //210
  { 0, 0, 0 },    // 220
  { 0, 0, 0 },    //230
  { 0, 0, 0 },    // 240
  { 0, 0, 0 },    // 250
  { 0, 0, 0 },    // 260
  { 0, 0, 0 },    //270
  { 0, 0, 0 },    //280
  { 0, 0, 0 },    // 290
  { 0, 0, 0 },    //300
  { 0, 0, 0 },    //310
  { 0, 0, 0 },    //320
  { 0, 0, 0 },    // 330
  { 0, 0, 0 },    //340
  { 0, 0, 0 },    // 350
  { 0, 0, 0 }     //360
};
byte led9[37][3] = {
  ///cambiar el color cada 10 grados
  { 0, 0, 0 },  // 0grados
  { 0, 0, 0 },  //10" grados
  { 0, 0, 0 },  // 20grados
  { 0, 0, 0 },  // 30 grados
  { 0, 0, 0 },  // 40 grados
  { 0, 0, 0 },  // 50 grados
  { 0, 0, 0 },  // 60 grados
  { 0, 0, 0 },  // 70 grados
  { 0, 0, 0 },  // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },  // 100grados
  { 0, 0, 0 },  //110 grados
  { 0, 0, 0 },  //   120grados
  { 0, 0, 0 },  // 130grados
  { 0, 0, 0 },  // 140grados
  { 0, 0, 0 },  // 150grados
  { 0, 0, 0 },  // 160grados
  { 0, 0, 0 },  //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },  //190grados
  { 0, 0, 0 },  // 200grados
  { 0, 0, 0 },  //210
  { 0, 0, 0 },  // 220
  { 0, 0, 0 },  //230
  { 0, 0, 0 },  // 240
  { 0, 0, 0 },  // 250
  { 0, 0, 0 },  // 260
  { 0, 0, 0 },  //270
  { 0, 0, 0 },  //280
  { 0, 0, 0 },  // 290
  { 0, 0, 0 },  //300
  { 0, 0, 0 },  //310
  { 0, 0, 0 },  //320
  { 0, 0, 0 },  // 330
  { 0, 0, 0 },  //340
  { 0, 0, 0 },  // 350
  { 0, 0, 0 }   //360
};
byte led10[37][3] = {
  ///cambiar el color cada 10 grados
  { 0, 0, 0 },  // 0grados
  { 0, 0, 0 },  //10" grados
  { 0, 0, 0 },  // 20grados
  { 0, 0, 0 },  // 30 grados
  { 0, 0, 0 },  // 40 grados
  { 0, 0, 0 },  // 50 grados
  { 0, 0, 0 },  // 60 grados
  { 0, 0, 0 },  // 70 grados
  { 0, 0, 0 },  // 80 grados
  { 0, 0, 0 },  // 90grados
  { 0, 0, 0 },  // 100grados
  { 0, 0, 0 },  //110 grados
  { 0, 0, 0 },  //   120grados
  { 0, 0, 0 },  // 130grados
  { 0, 0, 0 },  // 140grados
  { 0, 0, 0 },  // 150grados
  { 0, 0, 0 },  // 160grados
  { 0, 0, 0 },  //170grados
  { 0, 0, 0 },  //180grados
  { 0, 0, 0 },  //190grados
  { 0, 0, 0 },  // 200grados
  { 0, 0, 0 },  //210
  { 0, 0, 0 },  // 220
  { 0, 0, 0 },  //230
  { 0, 0, 0 },  // 240
  { 0, 0, 0 },  // 250
  { 0, 0, 0 },  // 260
  { 0, 0, 0 },  //270
  { 0, 0, 0 },  //280
  { 0, 0, 0 },  // 290
  { 0, 0, 0 },  //300
  { 0, 0, 0 },  //310
  { 0, 0, 0 },  //320
  { 0, 0, 0 },  // 330
  { 0, 0, 0 },  //340
  { 0, 0, 0 },  // 350
  { 0, 0, 0 }   //360
};
void setup() {
  strip.begin();  //inicializa la comunicacion entre arduino y la tira
  strip.show();
  Serial.begin(9600);  // Inicia la comunicación serial a 9600 baudios
  pinMode(2, INPUT);
}

void loop() {
  for (int i = 0; i < 37; i++) {
    strip.setPixelColor(0, strip.Color(led1[i][0], led1[i][1], led1[i][2]));
    strip.setPixelColor(1, strip.Color(led2[i][0], led2[i][1], led2[i][2]));
    strip.setPixelColor(2, strip.Color(led3[i][0], led3[i][1], led3[i][2]));
    strip.setPixelColor(3, strip.Color(led4[i][0], led4[i][1], led4[i][2]));
    strip.setPixelColor(4, strip.Color(led5[i][0], led5[i][1], led5[i][2]));
    strip.setPixelColor(5, strip.Color(led6[i][0], led6[i][1], led6[i][2]));
    strip.setPixelColor(6, strip.Color(led7[i][0], led7[i][1], led7[i][2]));
    strip.setPixelColor(7, strip.Color(led8[i][0], led8[i][1], led8[i][2]));
    strip.setPixelColor(8, strip.Color(led9[i][0], led9[i][1], led9[i][2]));
    strip.setPixelColor(9, strip.Color(led10[i][0], led10[i][1], led10[i][2]));

    strip.show();
    delay(3);
  }
}

void countRevolutions() {
  rev_count++;  // Incrementa el contador de revoluciones cada vez que se detecta un flanco de bajada en el pin del sensor
}


void RPM() {
  // Realiza una medición cada segundo
  if (millis() - last_time >= 1000) {
    detachInterrupt(digitalPinToInterrupt(IR_PIN));  // Detiene la interrupción mientras se realiza la medición
    time_diff = millis() - last_time;                // Calcula la diferencia de tiempo entre las últimas dos mediciones
    rpm = (rev_count * 60) / (time_diff / 1000.0);   // Calcula la velocidad en revoluciones por minuto
    Serial.print("Velocidad de giro: ");
    Serial.print(rpm);
    Serial.println(" RPM");
    rev_count = 0;                                                              // Reinicia el contador de revoluciones
    last_time = millis();                                                       // Actualiza el último tiempo registrado
    attachInterrupt(digitalPinToInterrupt(IR_PIN), countRevolutions, FALLING);  // Vuelve a habilitar la interrupción
  }
}
