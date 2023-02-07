export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_AVD_HOME=$HOME/.android/avd

export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator
export PATH=$PATH:/home/4E656F/Android/Sdk/cmdline-tools/latest/bin

fridainstall() {
	adb root 
	if [ $? -ne 0 ]; then
	    echo "no root"
	    return
	fi

	adb disable-verity 
	if [ $? -ne 0 ]; then
	    echo "disable verify failed"
	    return
	fi

	adb shell "su 0 mount -o rw,remount /" 
	if [ $? -ne 0 ]; then
		echo "no remount"
		return
	fi
	
	if [ $1 -eq "64" ]; then
		echo "Installing frida 64"
		adb push /home/4E656F/src/frida/frida-server-15.1.14-android-x86_64 /data/local/tmp/frida-server
		
	else
		adb push /home/4E656F/src/frida/frida-server-15.1.14-android-x86 /data/local/tmp/frida-server
	fi
	
	
	if [ $? -ne 0 ]; then
		echo "frida install failed"
		return
	fi

	adb shell "chmod 755 /data/local/tmp/frida-server"
	if [ $? -ne 0 ]; then
		echo "frida chmod failed"
		return
	fi

	echo "finished!"
}

burpinstall() {
	CERT="/home/4E656F/src/frida/9a5ba575.0"
	CERT2="/home/4E656F/src/frida/burp.pem"
	adb root 
	if [ $? -ne 0 ]; then
	    echo "no root"
	fi

	adb disable-verity 
	if [ $? -ne 0 ]; then
	    echo "disable verify failed"
		return
	fi

	adb shell "su 0 mount -o rw,remount /" 
	if [ $? -ne 0 ]; then
		echo "no remount"
		return
	fi

	adb push $CERT /system/etc/security/cacerts/9a5ba575.0
	adb push $CERT2 /data/local/tmp/burp.pem
	if [ $? -ne 0 ]; then
	    echo "copy failed"
	    return
	fi

	adb shell "chmod 644 /system/etc/security/cacerts/9a5ba575.0"
	if [ $? -ne 0 ]; then
	    echo "chmod failed"
	    return
	fi

	adb shell "chmod 644 /data/local/tmp/burp.pem"
	if [ $? -ne 0 ]; then
	    echo "chmod failed"
	    return
	fi

	adb reboot
}	

frida-start() {
	adb root
	if [ $? -ne 0 ]; then
	    echo "no root"
	fi
	adb shell "/data/local/tmp/frida-server &"

}


alias pixel_9.0='emulator @pixel_9.0 -no-boot-anim -netdelay none -no-snapshot -wipe-data -skin 1080x1920 -writable-system &'
alias pixel_9_64='emulator @pixel_9.0_64 -no-boot-anim -netdelay none -no-snapshot -wipe-data -skin 1080x1920 -writable-system &'
