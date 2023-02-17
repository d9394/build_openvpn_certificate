# build_openvpn_certificate
a tools to build openvpn certificate


usage:   
1, download easyrsa   
  wget https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.4/EasyRSA-3.0.4.tgz   
2, decompile   
  tar -xvf EasyRSA-3.0.4.tgz   
3, change right    
  chown -R root:root EasyRSA-3.0.4   
4, go into directory   
  cd EasyRSA-3.0.4 4   
5, run this script   
  ./build.sh   
   
