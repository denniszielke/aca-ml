import torch
import time
import sys

# Check if CUDA is available and the first command-line argument
if len(sys.argv) > 1 and sys.argv[1] == "gpu" and torch.cuda.is_available():
    device = torch.device("cuda")
    print("CUDA is available. Running on GPU.")
else:
    device = torch.device("cpu")
    print("CUDA is not available or 'cpu' argument provided. Running on CPU.")

# matrix size of 30000 results in 1.8B multiplications (30000*30000*2)
matrix_size = 30000

# Create tensors and move them to the device
a = torch.randn(matrix_size, matrix_size, device=device)
b = torch.randn(matrix_size, matrix_size, device=device)

# Create CUDA events for measuring time
start_event = torch.cuda.Event(enable_timing=True)
end_event = torch.cuda.Event(enable_timing=True)

# Record the start event
start_event.record()

# Perform matrix multiplication
c = torch.matmul(a, b)

# Record the end event
end_event.record()

# Wait for the events to complete
torch.cuda.synchronize()

# Calculate the elapsed time
elapsed_time = start_event.elapsed_time(end_event) / 1000  # Convert to seconds

# Move the result back to the CPU if needed
c = c.to("cpu")

print("Result:")
print(c)
print("Elapsed Time:", elapsed_time, "seconds")