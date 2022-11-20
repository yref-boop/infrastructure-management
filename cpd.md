# Diseño de un cpd
## Tareas a realizar
1. identificar las dimensiones en rack units de los distintos elementos o cargas TI, distribuir los componentes y proponer refrigeración, preferiblemente modelo pasillo caliente
2. ethernet o almacenamiento, esquema de red switch de acceso en filas o en racks
3. sai modular (controladora y baterias), PDU modular por fila
4. elementos de refrigeracion necesarios y sistema de cerramiento de pasillo caliente
5. elementos necesarios para implantar sistema de control de accesos, y circuito cerrado de television

## Características del cpd 
● 18 Chasis HPE Synergy 12000 Frame (P06011-B21 2650W), cada uno de ellos  con capacidad para:  
    o 6 Power Supplies HPE 2650W Performance Hot Plug Titanium Plus FIO  Power Supply Kit (798096-B21).   
    o 12 HPE Synergy 480 Gen10 Compute Module (871940-B21)  
    o 2 HPE Synergy 10Gb Interconnect Link Module con 12x10GbE  downlinks (779215-B21)
    o 2 Brocade 32Gb/12 2SFP+ Fibre Channel SAN Switch Module for HPE  Synergy (Q2E55A)  
●  2 Switch Cisco MDS 9132T 32-Gbps 32-Port Fibre Channel (650 W)   
●  N Switches Cisco Nexus 3048 (120 W). El número de switches de acceso (N)  necesarios será calculado en función de las necesidades de interconexión,  basándose en la distribución de racks elegida.  
●  2 Switch Cisco Nexus 9316D-GX 10Gbps 16 QSFP-DD Ports (420W)  
●  Sistema de almacenamiento HPE 3PAR StoreServ 9450-2 (4900 W en global) con  la siguiente configuración (Physical specifications):  
    o 2 controladoras HPE 3PAR 9450 Storage Node (Q7F41A) con 2 SAS  adapter (Q0E96A) y 1 HPE 3PAR 9000 2-port 32Gb Fibre Channel Host  Bus Adapter cada una (Q2P67A). 
    o 20 HPE 3PAR 9000 24-disk 2U SFF (2.5in) SAS Drive Enclosure  (Q0E95A) con discos HPE 3PAR 9000 7.68 TB SFF (2.5in) SSD  (Q0F42A)  
●  2 Routers Cisco C8300-1N1S-6T (500 W).  
●  2 Firewall Cisco ASA 5516-X (100W).  
●  180 Servidores rack HPE Proliant DL20 Gen10 E-2224 1P 16Gb-U S100i 2 LFF PS de 290W (P17079-B21 290W)

### rack units
gracias a la informacion que aportan los fabricantes podemos calcular el numero de rack units (RU) necesarias:
18 * 10 + 2 * 1 + 2 * 1 + 2 * 8  + 2 * 2 + 20 * 2 + 2 * 1 + 2 * 1 + 180 * 1 * N
suma total de rack units: 428  + N  (switches)

### consumo 
de nuevo consultando la información oficial de los componentes, calulamos el consumo total
18 * 2650  + 2 * 650 + 2 * 420 + 4900 + 2 * 500 + 2 * 100 + 180 * 290 + N * 120

consumo total: 108140 W + N * 120

### distribución escogida
debido a que decidimos utilizar racks de 42 rack units, se necesitarán 9 racks mínimo para que quepan los componentes, por simetría y para permitir mayor holgura y posibilidad de ampliamiento, decidimos utilizar 10 racks,
estos racks se dispondrán en 2 filas, formando dos pasillos fríos fuera y uno caliente en el medio

```
| 0 | 2 | ir | 4 | ir | 6 | 8 | 9 |
| 1 | 3 | ir | 5 | ir | 7 |SAI|SAI|
```

rack 0:
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|1|Switch Cisco Nexus 3048 |1|120|
|22|Servidor rack HPE Proliant DL20 |22|6380|
|1|Firewall Cisco C8300-1N1S-6T|1|100|
|1|Router Cisco C8300-1N1S-6T |1|500|
|1|Switch Cisco Nexus 9316D-GX|1|420|

rack 1:
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|1|Switch Cisco Nexus 3048 |1|120|
|23|Servidor rack HPE Proliant DL20 |23|6670|
|1|Firewall Cisco C8300-1N1S-6T|1|100|
|1|Router Cisco C8300-1N1S-6T |1|500|
|1|Switch Cisco Nexus 9316D-GX|1|420|

rack 2:
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|1|Switch Cisco Nexus 3048 |1|120|
|22|Servidor rack HPE Proliant DL20 |22|6380|
 
rack 3:
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|1|Switch Cisco Nexus 3048 |1|120|
|23|Servidor rack HPE Proliant DL20 |23|6670|
 
rack 4:
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|1|Switch Cisco Nexus 3048 |1|120|
|22|Servidor rack HPE Proliant DL20 |22|6380|

rack 5:
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|1|Switch Cisco Nexus 3048 |1|120|
|23|Servidor rack HPE Proliant DL20 |23|6670|
 
rack 6:
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|1|Switch Cisco Nexus 3048 |1|120|
|22|Servidor rack HPE Proliant DL20 |22|6380|
 
rack 7 ():
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|1|Switch Cisco Nexus 3048 |1|120|
|23|Servidor rack HPE Proliant DL20 |23|6670|
 
rack 8 (llena):
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|2|Driver HPE 3PAR 9459 Storage Node ||-|
|10|HPE 3PAR 9000 24-disk|20|-|
|1|Switch Cisco Nexus 3048 |1|120|
|1|Switch Cisco MDS 9132T|1|650|
|-|HPE 3PAR 9000 7.68 TB |-|-|

rack 9 (llena):
|Unidades|        Elemento     |  RU  | Consumo(W) |
|--------|---------------------|------|------------|
|2|Chasis HPE Synergy 12000 Frame|20|5300|
|2|Driver HPE 3PAR 9459 Storage Node ||-|
|10|HPE 3PAR 9000 24-disk|20|-|
|1|Switch Cisco Nexus 3048 |1|120|
|1|Switch Cisco MDS 9132T|1|650|
|-|HPE 3PAR 9000 7.68 TB |-|-|

decidimos romper la simetría de las filas por dos motivos:
- no es conveniente separar las dos torres del SAI
- es conveniente tener juntos los racks de almacenamiento
además, añadimos los switches, 2, añadiendo uno en cada rack dedicado a almacenamiento (8,9)



### sistema de distribución de energía
como disponemos de 10 racks que consumen kW y teniendo en cuenta posibles expansiones, el conjunto SAI + baterías escogido es:

### sistema de refrigeración

### sistemas de control
