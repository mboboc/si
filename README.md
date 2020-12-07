# si
Embedded Systems Labs

### Hardware
##### Physical board
* SoC-ul Broadcom BCM2835
* Procesor: 64-bit quad-core ARM Cortex-A53, 1.2GHz
* 1GB RAM
* 4 USB ports 2.0
* 1 Ethernet conector
* microSD card
* HDMI, jack audio, RCA
* GPIO, UART-uri, I²C, SPI, I²S

##### Emulator
* Versatile Platform Baseboard 
* ARM926EJ-S
* ARMv6

### Software
* Recomended host os: Ubuntu 18.04 Bionic Beaver
* Target OS: Raspbian Wheezy
* modified Kernel for Versatile PB --> https://drive.google.com/open?id=0B0lgiPZNMMyvaEtfN3V4VVBxRjg
* modified rootfs for Versatile PB --> https://drive.google.com/open?id=0B0lgiPZNMMyvOTFMakFuY1N2Q1E

### Lab01: Intro & QEMU
For initial configuration and packet download use the config-si.sh script.
```
chmod 777 config-si.sh
./config-si.sh
```

## Exercise 1
```
arm-linux-gnueabihf-gcc -static hello_world.c
qemu-arm a.out
```
------

## Exercise 2

```
arm-linux-gnueabihf-gcc hello_world -static file.c
qemu-arm hello_world
```
------

## Exercise 3

Pay attention:
* orders of arguments matters
* check the spelling

```
qemu-system-arm -machine versatilepb  -cpu arm1176 -kernel zImage-qemu -append "root=/dev/sda2" -drive  file=2015-05-05-raspbian-wheezy-qemu.img,index=0,media=disk,format=raw
```
------

## Exercise 4

```
Asks for password. Don't know why.

qemu-system-arm -machine versatilepb  -cpu arm1176 -kernel zImage-qemu -append "root=/dev/sda2" -drive  file=2015-05-05-raspbian-wheezy-qemu.img,index=0,media=disk,format=raw -monitor stdio
```
------

## Exercise 5

```
qemu-system-arm -machine versatilepb  -cpu arm1176 -kernel zImage-qemu -append "root=/dev/sda2 console=ttyAMA0" -drive  file=2015-05-05-raspbian-wheezy-qemu.img,index=0,media=disk,format=raw -monitor stdio
```

```
qemu-system-arm -machine versatilepb  -cpu arm1176 -kernel zImage-qemu -append "root=/dev/sda2 console=tty1" -drive  file=2015-05-05-raspbian-wheezy-qemu.img,index=0,media=disk,format=raw -monitor stdio
```
------

## Exercise 6

```
-net nic,model=<device>,netdev=<id> -netdev bridge,br=<nume bridge>,id=<id>
```

Pentru a crea și configura bridge-uri se folosește utilitarul brctl din pachetul bridge-utils. Crearea unui bridge care să ofere unui guest accesul la rețea fizică a host-ului se face astfel:
```
sudo brctl addbr virbr0								# creăm bridge-ul
sudo brctl addif virbr0 <interfata fizica>			# adăugam interfața fizică a host-ului la bridge
sudo ip address flush dev <interfata fizica>	    # ștergem adresa IP de pe interfața fizică, doar dacă avem o adresă
													# IP pe interfață. Va șterge și ruta default automat          
sudo dhclient virbr0 								
```

Dacă nu merge obținerea adreselor prin DHCP, se poate configura manual adresa și ruta default:
```
ip address show												# notăm ip-ul și prefixul interfeței fizice
ip route show												# notăm ruta implicită
sudo brctl addbr virbr0										# creăm bridge-ul
sudo brctl addif virbr0 <interfata fizica>					# adaugăm interfața fizică a host-ului la bridge
sudo ip address del <ip>/<prefix> dev <interfata fizica>	# mutăm adresa interfeței fizice
sudo ip address add <ip>/<prefix> dev virbr0				# pe bridge
sudo ip link set dev virbr0 up
sudo ip route add default via <gateway>	
```

Pentru ca bridge-ul să fie acceptat de QEMU el trebuie configurat și în fișierul /etc/qemu/bridge.conf sub forma:
```
# bridge.conf
allow virbr0
```

## Exercise 7
```
scp
```

### Lab02: Tools
.bash_profile - este executat când se pornește un shell de login (ex: primul shell după logare);
.bashrc - este executat cand se pornește orice shell interactiv (ex: orice terminal deschis);
.bash_logout - este executat când shell-ul de login se închide.


### Lab03: Kernel

### Lab06: Yocto

### Initializam mediul de compilare si directorul de lucru
```
source oe-init-build-env <path_to_working_directory>/<rpi_build_folder>/
```

### Adaugam intrari in fisierele de configurare a mediului pentru a ne asigura că parametrii folosiți la compilare sunt corecți și că va fi inclus layer-ul pentru RaspberryPi.
```
<path_to_working_directory>/<rpi_build_folder>/conf/local.conf
```

1. **BB_NUMBER_THREADS** are valoarea egală cu numărul de thread-uri de build ce dorim să fie create. Valoarea inițială este 4

2. **PARALLEL_MAKE** are valoarea egală cu numărul de procesoare disponibile.

Valoarea trebuie să aibă forma -j x, unde x este numărul de procesoare disponibile.

3. **MACHINE** are valoarea “raspberrypi”

4. **BBMASK** va exclude pachetele ce nu sunt suportate de core-ul Yocto.

Spre exemplu, în unele versiuni mai vechi ale layer-ului de RaspberryPi, acestea erau: “meta-raspberrypi/recipes-multimedia/libav|meta-raspberrypi/recipes-core/systemd”

!!! Toate valorile acestor variabile sunt șiruri de caractere!
O atribuire precum MACHINE = my_machine_name va genera eroare la parsare. Atribuirea corectă este MACHINE = “my_machine_name”

### <path_to_working_directory>/<rpi_build_folder>/conf/bblayers.conf

Contine informatie despre layere care urmeaza sa fie compilate. 

1. **BBLAYERS** - adaugam o cale catre layerul de RPI

### Instalam utilitarele folosite de bitbake
```
sudo apt-get install sed wget cvs subversion git-core coreutils \
unzip texi2html texinfo libsdl1.2-dev docbook-utils gawk \
python-pysqlite2 diffstat help2man make gcc build-essential \
g++ desktop-file-utils chrpath libgl1-mesa-dev libglu1-mesa-dev \
mercurial autoconf automake groff libtool xterm
```
