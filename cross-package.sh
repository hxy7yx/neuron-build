#!/bin/bash

set -e

home=/home/neuron
branch=main
vendor=?
arch=?
version=?

while getopts ":a:v:o:l:" OPT; do
    case ${OPT} in
        a)
            arch=$OPTARG
            ;;
        o)
            vendor=$OPTARG
            ;;
		v)
	    	version=$OPTARG
	    	;;
    esac
done

neuron_dir=$home/$branch/Program/$vendor/neuron
neuron_modules_dir=$home/$branch/Program/$vendor/neuron-modules
package_dir=$home/$branch/Program/$vendor/package/neuron
library=$home/$branch/libs/$vendor
script_dir="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P  )"


rm -rf $package_dir

mkdir -p $package_dir
mkdir -p $package_dir/config
mkdir -p $package_dir/plugins/schema
mkdir -p $package_dir/logs
mkdir -p $package_dir/persistence
mkdir -p $package_dir/certs
mkdir -p $package_dir/simulator


cp .gitkeep $package_dir/logs/
cp .gitkeep $package_dir/persistence/
cp .gitkeep $package_dir/certs/

cp $neuron_dir/LICENSE $package_dir/config
cp $neuron_modules_dir/config/protobuf-LICENSE $package_dir/config/
cp $neuron_modules_dir/config/protobuf-c-LICENSE $package_dir/config/

cp $library/lib/libzlog.so.1.2 $package_dir/

cp $neuron_dir/LICENSE $package_dir/
cp $neuron_dir/build/libneuron-base.so $package_dir/
cp $neuron_modules_dir/build/liblicense.so $package_dir/

cp $neuron_dir/build/neuron $package_dir/
cp $neuron_dir/build/config/neuron.key \
	$neuron_dir/build/config/neuron.pem \
    $neuron_dir/build/config/neuron.json \
	$neuron_dir/build/config/zlog.conf \
	$neuron_dir/build/config/dev.conf \
	$neuron_dir/build/config/*.sql \
	$package_dir/config/

cp $neuron_modules_dir/build/config/neuron-default.lic \
	$package_dir/persistence/

cp $neuron_modules_dir/default_plugins.json \
	$neuron_modules_dir/build/config/opcua_cert.der \
 	$neuron_modules_dir/build/config/opcua_key.der \
	$package_dir/config/

cp $neuron_dir/build/plugins/libplugin-mqtt.so \
	$neuron_dir/build/plugins/libplugin-ekuiper.so \
	$neuron_dir/build/plugins/libplugin-monitor.so \
	$package_dir/plugins/

cp $neuron_dir/build/plugins/schema/*.json \
	$package_dir/plugins/schema/

cp $neuron_modules_dir/build/plugins/libplugin-websocket.so \
    	$neuron_modules_dir/build/plugins/libplugin-gewu.so \
    	$neuron_modules_dir/build/plugins/libplugin-sparkplugb.so \
    	$neuron_modules_dir/build/plugins/libplugin-opcua.so \
    	$neuron_modules_dir/build/plugins/libplugin-EtherNet-IP.so \
    	$neuron_modules_dir/build/plugins/libplugin-Profinet.so \
    	$neuron_modules_dir/build/plugins/libplugin-qna3e.so \
    	$neuron_modules_dir/build/plugins/libplugin-a1e.so \
    	$neuron_modules_dir/build/plugins/libplugin-fx.so \
    	$neuron_modules_dir/build/plugins/libplugin-s7comm.so \
    	$neuron_modules_dir/build/plugins/libplugin-s7comm-for-300.so \
    	$neuron_modules_dir/build/plugins/libplugin-s5fetch-write.so \
    	$neuron_modules_dir/build/plugins/libplugin-fins-tcp.so \
    	$neuron_modules_dir/build/plugins/libplugin-fins-udp.so \
    	$neuron_modules_dir/build/plugins/libplugin-hostlink-cmode.so \
    	$neuron_modules_dir/build/plugins/libplugin-ads.so \
    	$neuron_modules_dir/build/plugins/libplugin-df1.so \
    	$neuron_modules_dir/build/plugins/libplugin-comli.so \
    	$neuron_modules_dir/build/plugins/libplugin-mewtocol.so \
    	$neuron_modules_dir/build/plugins/libplugin-iec104.so \
    	$neuron_modules_dir/build/plugins/libplugin-iec61850.so \
    	$neuron_modules_dir/build/plugins/libplugin-dlt645-2007.so \
    	$neuron_modules_dir/build/plugins/libplugin-dlt645-1997.so \
    	$neuron_modules_dir/build/plugins/libplugin-bacnet.so \
    	$neuron_modules_dir/build/plugins/libplugin-knx.so \
    	$neuron_modules_dir/build/plugins/libplugin-HJ212.so \
    	$neuron_modules_dir/build/plugins/libplugin-nona11.so \
	$neuron_modules_dir/build/plugins/libplugin-modbus-tcp.so \
	$neuron_modules_dir/build/plugins/libplugin-modbus-rtu.so \
	$neuron_modules_dir/build/plugins/libplugin-modbus-qh-tcp.so \
	$neuron_modules_dir/build/plugins/libplugin-hsms.so \
	$neuron_modules_dir/build/plugins/libplugin-kuka.so \
    	$neuron_modules_dir/build/plugins/libplugin-license-server.so \
    	$neuron_modules_dir/build/plugins/libplugin-EtherNet-IP-1400.so \
    	$neuron_modules_dir/build/plugins/libplugin-EtherNet-IP-5500.so \
    	$package_dir/plugins/

# cp $neuron_modules_dir/build/plugins/focas/libfwlib32.so.1 $package_dir/

cp $neuron_modules_dir/build/plugins/schema/*.json \
	$package_dir/plugins/schema/

cp $neuron_dir/build/simulator/modbus_simulator \
	$package_dir/simulator/

cp $neuron_modules_dir/build/simulator/opcua_simulator \
	$neuron_modules_dir/build/simulator/hj_simulator \
	$neuron_modules_dir/build/simulator/comli_simulator \
	$neuron_modules_dir/build/simulator/mewtocol_simulator \
	$package_dir/simulator/


cd $package_dir/..
rm -rf neuron*.tar.gz

tar czf neuron-$version-linux-$arch.tar.gz neuron
echo "neuron-$version-linux-$arch.tar.gz";;
