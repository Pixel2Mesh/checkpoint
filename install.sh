#!/bin/bash
# clone
git clone https://github.com/SeanLi-OI/Pixel2Mesh.git
git clone https://github.com/SeanLi-OI/output.git
rm -rf output/.git
# 安装cuda8.0
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
apt-get update
apt-get install cuda=8.0.61-1
rm cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
# 安装 g++4.8
apt-get install g++-4.8
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8  100
update-alternatives --config g++
# 安装 gcc4.8
apt-get install gcc-4.8
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8  100
update-alternatives --config gcc
# 安装 tensorflow-gpu1.3.0
python2 -m pip uninstall -y tensorflow
python2 -m pip install tensorflow-gpu==1.3.0
# 安装 tflearn0.3.2
python2 -m pip install tflearn==0.3.2
# 链接 cudnn
cd checkpoint
dpkg -i "libcudnn6_6.0.21-1+cuda8.0_amd64.deb"
rm libcudnn6_6.0.21-1+cuda8.0_amd64.deb
# 修改makefile
mv makefile ../Pixel2Mesh/external/makefile
# 添加checkpoint
rm -rf .git
cd ..
mv checkpoint Pixel2Mesh/Data/
# make
cd Pixel2Mesh/external
make clean
make
# 生成train shell
cd ../../
rm -rf sample_data
echo -e "#!/bin/bash\ncd Pixel2Mesh\npython2 train.py" >> train.sh
chmod 777 train.sh
echo -e "#!/bin/bash\ncd Pixel2Mesh\ngit add -u\ngit commit -m \"commit message\"\ngit push" >> commit.sh
chmod 777 commit.sh
# 输出完成提示
echo "Installation Complete!"
