import os

print ("hello")
hp_final_epochs = int(os.environ.get('HP_FINAL_EPOCHS'))
hp_final_lr = float(os.environ.get('HP_FINAL_LR'))
print("from python",hp_final_epochs)