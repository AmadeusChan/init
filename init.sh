echo Updating Kernel
sudo atp-get update
mkdir kernel
cd kernel
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.3/linux-headers-4.9.3-040903_4.9.3-040903.201701120631_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.3/linux-headers-4.9.3-040903-generic_4.9.3-040903.201701120631_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.3/linux-image-4.9.3-040903-generic_4.9.3-040903.201701120631_amd64.deb 
sudo dpkg -i *.deb
cd ..

echo Initializing
echo y | sudo apt-get install git cmake build-essential indicator-cpufreq lm-sensors emacs r-base vim
echo y | sudo apt-get install openconnect
git clone https://github.com/AmadeusChan/vimsetting.git
cp ./vimsetting/.vimrc ~/.vimrc

echo Installing Opencv
echo y | sudo apt-get install libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
echo y | sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
wget https://codeload.github.com/opencv/opencv/zip/2.4.13
unzip 2.4.13
cd opencv-2.4.13/
mkdir build
cd build
cmake ..
make -j8
sudo make install -j8
echo /usr/local/lib > opencv.conf 
sudo cp ./opencv.conf /etc/ld.so.conf.d/opencv.conf
sudo ldconfig

echo Installing Caffe 
cd ../..
git clone https://github.com/BVLC/caffe.git
echo y | sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
echo y | sudo apt-get install --no-install-recommends libboost-all-dev
echo y | sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
echo y | sudo apt-get install libatlas-base-dev
cp Makefile.config ./caffe/Makefile.config
cd caffe
make all -j8
make test -j8
make runtest -j8

echo y | sudo apt-get install python-pip
echo y | sudo pip install shadowsocks
