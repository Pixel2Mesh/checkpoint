#!/bin/bash
# clone
git clone https://github.com/nywang16/Pixel2Mesh.git
# 安装cuda8.0
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
apt-get update
apt-get install cuda=8.0.61-1
# 安装 g++4.8
apt-get install g++-4.8
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8  100
update-alternatives --config g++
# 安装 tensorflow-gpu1.3.0
pip uninstall -y tensorflow
pip install tensorflow-gpu==1.3.0
# 安装 tflearn0.3.2
pip install tflearn==0.3.2
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
make
# 生成train shell
echo -e "#!/bin/bash\ncd Pixel2Mesh\npython train.py" >> train.sh
chmod 777 train.sh
