## ✅ ESP8266 OTA System (Using Arduino OTA via WiFi)

ESP8266 OTA আপডেট করার জন্য দরকার:

### ১. প্রথমবার USB দিয়ে OTA firmware আপলোড করা

### ২. পরবর্তীতে WiFi দিয়েই নতুন স্কেচ আপলোড করা যাবে

---

## ✅ প্রথমবারের জন্য OTA সক্রিয় করা ফার্মওয়্যার (Arduino Sketch)

```cpp
// OTA-Enabled Base Sketch

#include <ESP8266WiFi.h>
#include <ArduinoOTA.h>

const char* ssid = "Your_WiFi_Name";
const char* password = "Your_WiFi_Password";

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, password);

  // Wait for WiFi
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("WiFi connected");

  // OTA Config
  ArduinoOTA.setHostname("esp8266-ota");
  ArduinoOTA.setPassword("admin123");

  ArduinoOTA.onStart([]() {
    Serial.println("Start OTA Update");
  });
  ArduinoOTA.onEnd([]() {
    Serial.println("\nEnd OTA");
  });
  ArduinoOTA.onProgress([](unsigned int progress, unsigned int total) {
    Serial.printf("Progress: %u%%\r", (progress / (total / 100)));
  });
  ArduinoOTA.onError([](ota_error_t error) {
    Serial.printf("Error[%u]: ", error);
  });

  ArduinoOTA.begin();
  Serial.println("OTA Ready");
}

void loop() {
  ArduinoOTA.handle();
}
```

---

## ✅ ফার্মওয়্যার আপলোড (প্রথমবার Serial দিয়ে)

**USB দিয়ে প্রথমবার কোডটি ESP8266-এ আপলোড করুন**। এরপর ডিভাইসটি WiFi-তে কানেক্ট হবে এবং OTA রেডি থাকবে।

---

## ✅ এরপর OTA দিয়ে আপলোড কিভাবে করবেন?

### Step 1: Ensure ESP8266 and your computer/phone are on the same WiFi

### Step 2: OTA Upload (Linux, Termux-এ `arduino-cli` দিয়ে, বা PC দিয়ে)

#### আপনি যদি PC বা Arduino IDE ব্যবহার করেন:

**Tools > Port > Network Ports > esp8266-ota.local**
তারপর নরমালি Upload করলেই OTA দিয়ে হবে

#### আপনি যদি Command line ব্যবহার করতে চান:

1. Arduino CLI ইনস্টল করুন
2. তারপর রান করুন:

```bash
arduino-cli upload -p esp8266-ota.local --fqbn esp8266:esp8266:nodemcuv2
```

---

## ✅ OTA Sketch Features:

| ফিচার                  | আছে |
| ---------------------- | --- |
| WiFi Auto Connect      | ✅   |
| OTA Update Support     | ✅   |
| Password Protected OTA | ✅   |
| Serial Debug           | ✅   |

---

## ✅ আপনার জন্য কাজের পরিকল্পনা:

| কাজ                                 | করবেন                                    |
| ----------------------------------- | ---------------------------------------- |
| OTA স্কেচ প্রথমবার USB দিয়ে ফ্ল্যাশ | `Arduino IDE` / `Termux+Serial App` দিয়ে |
| পরবর্তীতে WiFi দিয়ে আপডেট           | `arduino-cli` / `Arduino IDE`            |
| ESP8266 কোড লেখবেন                  | Termux + Nano / Vim                      |
| .ino → OTA Upload                   | WiFi দিয়ে `arduino-cli` অথবা Arduino IDE |

---

**আপনি যদি Termux-এ `arduino-cli` দিয়ে পুরো OTA upload প্রক্রিয়াও চান, আমি তার জন্য আরেকটা `setup_ota.sh` স্ক্রিপ্ট দিতে পারি। সেটার দরকার হবে কি?**
