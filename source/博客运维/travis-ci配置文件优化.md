# 优化travis-ci配置文件

## 问题
* 旧版本的`.travis.yml`内容如下：
```yaml
language: python - "3.7"

before_install:
    - wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
    - chmod +x miniconda.sh
    - "./miniconda.sh -b"
    - export PATH=/home/travis/miniconda3/bin:$PATH
    - conda update --yes conda
    - sudo ln -s /run/shm /dev/shm
install:
    - conda install --yes python="3.7" psutil sphinx numpy scipy gdal cython h5py pycurl shapely mock matplotlib
    - pip install --user travis-sphinx recommonmark sphinx_rtd_theme
script:
    # travis-sphinx build --source=./
    travis-sphinx build --source=./source
after_success:
    # travis-sphinx deploy
    travis-sphinx deploy --cname www.xuezhisd.top
```
* 构建时间是2分钟多，作者认为时间太长，有优化空间。

## 优化方法
* **分析：** 时间都浪费在`miniconda`相关的操作上;
* **思路：** 将`miniconda`干掉，直接使用`系统自带的python3`；
* 使用`apt`安装pip3，并升级；
* 使用`pip`直接安装`sphinx`等相关的package。
* 新版本的`.travis.yml`内容如下所示：
```yaml
language: python - "3.7"

before_install:
    #- sudo apt-get update
    - sudo apt-get install python3-pip python3-setuptools python3-wheel
    - sudo pip3 install pip --upgrade
    - sudo apt-get remove python3-pip
install:
    - pip3 install --user sphinx travis-sphinx recommonmark sphinx_rtd_theme
script:
    # travis-sphinx build --source=./
    travis-sphinx build --source=./source
after_success:
    # travis-sphinx deploy
    travis-sphinx deploy --cname www.xuezhisd.top
```

## 结果
* 时间从`2分钟多`，减少到`一分钟左右`。
