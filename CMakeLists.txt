cmake_minimum_required(VERSION 3.18)
project(LibTorchHelloWorld)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_PREFIX_PATH ${LIBTORCH_PATH})

set(CAFFE2_USE_CUDNN ON)
set(USE_CUSPARSELT OFF)
find_package(Torch REQUIRED)

include_directories(${PROJECT_SOURCE_DIR}/include)

add_executable(hello-world src/main.cpp src/model.cpp)
target_link_libraries(hello-world "${TORCH_LIBRARIES}")
set_property(TARGET hello-world PROPERTY CXX_STANDARD 17)
