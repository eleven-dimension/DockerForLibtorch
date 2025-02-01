#include <torch/torch.h>
#include <iostream>
#include "model.h"

int main() {
  torch::Device device(torch::cuda::is_available() ? torch::kCUDA
                                                   : torch::kCPU);
  std::cout << "Using device: " << (device.is_cuda() ? "CUDA" : "CPU")
            << std::endl;

  SimpleNet model;
  model.to(device);

  torch::optim::SGD optimizer(model.parameters(),
                              torch::optim::SGDOptions(0.01));
  torch::nn::MSELoss loss_fn;

  auto x = torch::randn({10, 1}).to(device);
  auto y = torch::full({10, 1}, 5.0).to(device);

  for (int epoch = 0; epoch < 100; ++epoch) {
    optimizer.zero_grad();

    auto y_pred = model.forward(x);
    auto loss = loss_fn(y_pred, y);

    loss.backward();
    optimizer.step();

    if (epoch % 10 == 0) {
      std::cout << "Epoch [" << epoch << "] Loss: " << loss.item<float>()
                << std::endl;
    }
  }

  return 0;
}
