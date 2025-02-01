#pragma once
#include <torch/torch.h>

struct SimpleNet : torch::nn::Module {
  torch::nn::Linear fc;

  SimpleNet() : fc(register_module("fc", torch::nn::Linear(1, 1))) {}

  torch::Tensor forward(torch::Tensor x) { return fc(x); }
};
