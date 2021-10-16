# Developer PowerShell for VS 2019で実行する
python -m pip install --upgrade pip
pip install --upgrade wheel
pip install --upgrade six
pip install --upgrade pycuda
pip install --upgrade scikit-learn
pip install --upgrade lightgbm --install-option=--gpu --install-option="--opencl-include-dir=$env:CUDA_HOME\include" --install-option="--opencl-library=$env:CUDA_HOME\lib\x64\OpenCL.lib" --install-option="--boost-root=$env:BOOST_HOME" --install-option="--boost-librarydir=$env:BOOST_HOME\lib64-msvc-14.2"
pip install --upgrade tensorflow
pip install --upgrade tensorflow-addons
pip install --upgrade pandas
pip install --upgrade protobuf
pip install --upgrade pelican
pip install --upgrade fabric2
pip install --upgrade seaborn
pip install --upgrade pynvim

npm install --global yarn
npm install --global neovim
npm install --global tree-sitter-cli

