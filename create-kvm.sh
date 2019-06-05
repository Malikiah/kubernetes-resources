#!/bin/sh
#change according to spec
ram=2048
allocatedSpace=10
vCpus=2
osType=linux
graphics=none
osLocation=http://gb.archive.ubuntu.com/ubuntu/dists/disco/main/installer-amd64/


read -ep "Define virtual machine name : " name

if [ -n "$name" ] ;
        then
            echo ""
            echo "  ["
            echo "      [ memory = $ram ] "
            echo "      [ disk space = $allocatedSpace ] "
            echo "      [ vCpus = $vCpus ] "
            echo "      [ operating system type = $osType ] "
            echo "      [ operating system location = $osLocation ]"
            echo "      [ graphics = $graphics ]"
            echo "  ]"
            echo ""
        read -ep "Would you like to change default settings? " change

        if [ -n "$change" ]
            then
                if [ $(tr "[:upper:]" "[:lower:]" <<< $change) == "yes" ] || [ $(tr "[:upper:]" "[:lower:]" <<< $change) == "y" ] 
                    then
                        read -ep "  memory [default = $ram]  = " ramChange
                        if [ -n "$ramChange" ]
                            then
                            ram=$ramChange
                        fi

                        read -ep "  allocated space [default = "$allocatedSpace"Gb] = " allocatedSpaceChange
                        if [ -n "$allocatedSpaceChange" ]
                            then
                            allocatedSpace=$allocatedSpaceChange
                        fi

                        read -ep "  vCpus [default = $vCpus] = " vCpusChange
                        if [ -n "$vCpusChange" ]
                            then
                            vCpus=$vCpusChange
                        fi

                        read -ep "  operating system type [default = $osType] = " osTypeChange
                        if [ -n "$osTypeChange" ]
                            then
                            osType=$osTypeChange
                        fi

                        read -ep "  operating system location [default = $osLocation] = " osLocationChange
                        if [ -n "$osLocationChange" ]
                            then
                            osLocation=$osLocationChange
                        fi

                        read -ep "  graphics [default = $graphics] = " graphicsChange
                        if [ -n "$graphicsChange" ]
                            then
                            graphics=$graphicsChange
                        fi

                            echo ""
                            echo "settings :"
                            echo ""
                            echo "  ["
                            echo "      [ memory = $ram ] "
                            echo "      [ disk space = $allocatedSpace ] "
                            echo "      [ vCpus = $vCpus ] "
                            echo "      [ operating system type = $osType ] "
                            echo "      [ operating system location = $osLocation ]"
                            echo "      [ graphics = $graphics ]"
                            echo "  ]"
                            echo ""


                fi
        fi

        echo "Initializing virtual machine..."
            sudo virt-install \
                --name $name \
                --ram $ram \
                --disk path=/var/lib/libvirt/images/$name.img,size=$allocatedSpace \
                --vcpus $vCpus \
                --os-type $osType  \
                --os-variant ubuntu19.04 \
                --network bridge:br0,model=virtio \
                --graphics $graphics \
                --console pty,target_type=serial \
                --location $osLocation \
                --extra-args 'console=ttyS0,115200n8 serial'
    else
        echo "Virual machine name was not defined."
        echo "Exiting..."
        exit 1
fi