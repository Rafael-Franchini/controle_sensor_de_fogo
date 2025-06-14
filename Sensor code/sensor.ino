#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// --- Wi-Fi ---
const char* ssid = "Ap Alair";
const char* password = "16075825";

// --- Pinos ---
#define PIN_FIRE D0
#define PIN_MQ2 A0
#define PIN_BUZZER D7

// --- LCD ---
LiquidCrystal_I2C lcd(0x27, 16, 2);
// --- Servidor Web ---
ESP8266WebServer server(80);

// --- Variáveis globais ---
int mq2Value = 0;
bool fireDetected = false;
bool buzzerState = false;

void setup() {
  Serial.begin(115200);

  pinMode(PIN_FIRE, INPUT);
  pinMode(PIN_BUZZER, OUTPUT);
  lcd.init();
  lcd.backlight();

  // Conecta Wi-Fi
  WiFi.begin(ssid, password);
  lcd.setCursor(0, 0);
  lcd.print("Conectando WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("WiFi Conectado!");
  delay(1000);

  server.on("/", handleRoot);
  server.begin();

  Serial.println("IP: ");
  Serial.println(WiFi.localIP());
}

void loop() {
  server.handleClient();

  // Leitura de sensores
  fireDetected = digitalRead(PIN_FIRE) == LOW;
  mq2Value = analogRead(PIN_MQ2);

  // Controle do buzzer
  buzzerState = (fireDetected || mq2Value > 400 );
  if (buzzerState) {
    tone(PIN_BUZZER, 1000);
  } else {
    noTone(PIN_BUZZER);
  }

  // Atualiza LCD (sem usar clear)
  lcd.setCursor(0, 0);
  lcd.print(WiFi.localIP());
  lcd.setCursor(0, 1);
  lcd.print("Fg:");
  lcd.print(fireDetected ? "S" : "N");
  lcd.print(" G:");
  lcd.print(mq2Value);
  lcd.print(" b:");
  lcd.print(buzzerState ? "S" : "N");
  delay(1000);
}

void handleRoot() {
  String msg = "{";
  msg += "\"gas\":" + String(mq2Value) + ",";
  msg += "\"fogo\":" + String(fireDetected ? "true" : "false") + ",";
  msg += "\"buzzer\":" + String(buzzerState ? "true" : "false");
  msg += "}";
  server.send(200, "application/json", msg);
}
