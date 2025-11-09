from ultralytics import YOLO

# 1. Load the bigger "small" model
model = YOLO("yolov8m-obb.pt") 

# 2. Train with strong augmentation to fight overfitting
results = model.train(
    data="train_info.yaml", 
    epochs=200, 
    imgsz=640,
    batch=8, 
    workers=1,  # Use more workers if you can
    
    # --- ADD THESE AUGMENTATION ARGS ---
    # These create "fake" data and make training harder,
    # which forces the model to generalize better.
    
    #degrees=25.0,     # random rotations (0-25 degrees)
    #
    #flipud=0.5,       # random vertical flip (50% chance)
    #fliplr=0.5,       # random horizontal flip (50% chance)
    #
    #hsv_h=0.015,      # change hue (color)
    #hsv_s=0.7,        # change saturation (color)
    #hsv_v=0.4,        # change value (brightness)    
)