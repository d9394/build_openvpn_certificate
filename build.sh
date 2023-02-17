#!/bin/bash
read -p "Input project name : " project_name
if [ ! -d keys.$project_name ]; then
	mkdir -p keys.$project_name
fi
cd ./keys.$project_name
echo=
echo ----------- working dirc: `pwd` ---------------
if [ ! -f vars ]; then
	echo set_var EASYRSA_BATCH       "yes" >> vars
	echo set_var EASYRSA_CA_EXPIRE   3650 >> vars
	echo set_var EASYRSA_CERT_EXPIRE 3650 >> vars
	echo set EASYRSA_REQ_CN          "ham.com" >> vars
	echo set_var EASYRSA_DN          "org" >> vars
	echo set_var EASYRSA_REQ_COUNTRY     "CN" >> vars
	echo set_var EASYRSA_REQ_PROVINCE    "GD" >> vars
	echo set_var EASYRSA_REQ_CITY        "Canton" >> vars
	echo set_var EASYRSA_REQ_ORG         "$project_name" >> vars
	echo set_var EASYRSA_REQ_EMAIL       "$project_name@hamshop.cn" >> vars
	echo set_var EASYRSA_REQ_OU          "RHA" >> vars
	echo set_var EASYRSA_NS_SUPPORT      "yes" >> vars
	read -p "Input key size : 512/1024/2048 " keysize
	echo set_var KEY_SIZE                $keysize  >> vars
fi
cat vars
echo=
echo start init-pki
../easyrsa init-pki
echo=
echo ---------------  start build-ca -------------------------
../easyrsa --batch build-ca nopass
echo=
echo --------------- start build-server ----------------------
../easyrsa build-server-full server_$project_name nopass
echo=
echo --------------- start buile-client ----------------------
read -p "Input clients start number : " client_start
read -p "Input clients end number : " client_end
for i in $(seq $client_start $client_end)
do
  ../easyrsa build-client-full client_$i nopass
done
echo=
echo --------------- start build-dh --------------------------
../easyrsa gen-dh
echo=
echo --------------- build done ------------------------------


