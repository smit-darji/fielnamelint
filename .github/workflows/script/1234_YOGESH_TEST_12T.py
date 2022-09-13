import os
hp_final_epochs = int(os.environ.get('HP_FINAL_EPOCHS'))
hp_final_lr = float(os.environ.get('HP_FINAL_LR'))
print(hp_final_epochs)