"""
Tricholens AI — Complete Model Training Pipeline
=================================================
Multi-task EfficientNetB0 model for scalp analysis.

Tasks:
  1. AGA probability  (sigmoid, binary)
  2. Hair Density     (softmax, 3-class: Low/Normal/High)
  3. Scalp Condition  (softmax, 4-class: Healthy/Dry/Inflamed/Oily)
  4. Miniaturized Hair Ratio  (sigmoid → 0–100%)

Run:
  python train_model.py

Output:
  tricholens_v5.tflite   ← copy this to backend_python/
"""

import os, sys, warnings, csv, random
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "2"
warnings.filterwarnings("ignore")

import numpy as np  # type: ignore
import tensorflow as tf  # type: ignore
from tensorflow import keras  # type: ignore
from tensorflow.keras import layers, Model, regularizers  # type: ignore
from tensorflow.keras.applications import EfficientNetB0  # type: ignore
from tensorflow.keras.callbacks import (  # type: ignore
    EarlyStopping, ReduceLROnPlateau, ModelCheckpoint  # type: ignore
)
from PIL import Image, ImageOps, ImageFilter  # type: ignore
import math

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
LABELS_CSV   = r"c:\Users\Hemasundara Rao\OneDrive\Desktop\Tricholens\Tricholens2\backend_python\scalp_labels.csv"
OUTPUT_TFLITE = r"c:\Users\Hemasundara Rao\OneDrive\Desktop\Tricholens\Tricholens2\backend_python\tricholens_v5.tflite"
IMG_SIZE     = 224
BATCH_SIZE   = 16
EPOCHS_FREEZE = 20   # Phase 1: train head only
EPOCHS_FINE   = 30   # Phase 2: fine-tune top layers
SEED         = 42

# Label mappings
DENSITY_MAP   = {"Low": 0, "Medium": 1, "High": 2}   # model output: Low/Normal/High same mapping
CONDITION_MAP = {"Normal": 0, "Dry": 1, "Inflamed": 2, "Oily": 3}
# "Normal" scalp condition in training data → maps to "Healthy"

DENSITY_NAMES   = ["Low", "Normal", "High"]
CONDITION_NAMES = ["Healthy", "Dry", "Inflamed", "Oily"]

print("=" * 60)
print("  Tricholens AI — Multi-Task Model Trainer")
print("=" * 60)

# ─── 1. LOAD DATASET ──────────────────────────────────────────────────────────
print("\n[1] Loading dataset from CSV ...")

samples = []
missing = 0
with open(LABELS_CSV, "r") as f:
    reader = csv.DictReader(f)
    for row in reader:
        img_path  = row["filename"].strip()
        # ── PATH REMAP ──────────────────────────────────────────────────────
        # CSV references 'Tricholens\Tricholens2\data\IMG_XXXX.JPG'
        # Actual images are at 'Desktop\data\IMG_XXXX.JPG'
        img_path = img_path.replace(
            r"c:\Users\Hemasundara Rao\OneDrive\Desktop\Tricholens\Tricholens2\data",
            r"c:\Users\Hemasundara Rao\OneDrive\Desktop\data"
        )
        # ────────────────────────────────────────────────────────────────────
        if not os.path.exists(img_path):
            missing += 1  # type: ignore
            continue
        mini_ratio  = float(row["mini_ratio"])
        condition   = row["condition"].strip()
        label_aga   = int(row["label_aga"])
        label_density = row["label_density"].strip()

        cond_idx    = CONDITION_MAP.get(condition, 0)   # default Healthy
        density_idx = DENSITY_MAP.get(label_density, 1)

        samples.append({
            "path"        : img_path,
            "mini_ratio"  : mini_ratio,
            "condition"   : cond_idx,
            "label_aga"   : label_aga,
            "label_density": density_idx,
        })


print(f"   Loaded  : {len(samples)} samples")
print(f"   Missing : {missing} files not found")

if len(samples) < 20:
    print("\n[ERROR] Not enough images found!")
    print(f"  Check that file paths in '{LABELS_CSV}' are correct.")
    print(f"  CSV references paths like: {samples[0]['path'] if samples else 'N/A'}")
    sys.exit(1)

# Print class distribution
aga_pos = sum(1 for s in samples if s["label_aga"] == 1)
print(f"   AGA=1   : {aga_pos}   AGA=0: {len(samples)-aga_pos}")
print(f"   Density : Low={sum(1 for s in samples if s['label_density']==0)} "
      f"Medium={sum(1 for s in samples if s['label_density']==1)} "
      f"High={sum(1 for s in samples if s['label_density']==2)}")

# ─── 2. SPLIT DATASET ─────────────────────────────────────────────────────────
random.seed(SEED)
random.shuffle(samples)

n_total = len(samples)
n_val   = max(20, int(n_total * 0.20))
n_train = n_total - n_val

train_samples = samples[:n_train]  # type: ignore
val_samples   = samples[n_train:]  # type: ignore
print(f"\n[2] Split: {n_train} train / {n_val} val")

# ─── 3. DATA PIPELINE ─────────────────────────────────────────────────────────
def load_and_preprocess(img_path: str, augment: bool = False):
    """
    Load image + apply augmentation pipeline.
    Returns numpy array of shape (224, 224, 3) normalized 0-1.
    """
    try:
        img = Image.open(img_path).convert("RGB")
    except Exception as e:
        return np.zeros((IMG_SIZE, IMG_SIZE, 3), dtype=np.float32)

    # Center crop to remove lens vignette (take inner 85%)
    w, h = img.size
    margin_x, margin_y = int(w * 0.075), int(h * 0.075)
    img = img.crop((margin_x, margin_y, w - margin_x, h - margin_y))

    # Resize
    img = img.resize((IMG_SIZE, IMG_SIZE), Image.LANCZOS)

    if augment:
        # Random horizontal flip
        if random.random() > 0.5:
            img = ImageOps.mirror(img)
        # Random vertical flip
        if random.random() > 0.5:
            img = ImageOps.flip(img)
        # Random rotation
        angle = random.uniform(-20, 20)
        img = img.rotate(angle, resample=Image.BILINEAR, fillcolor=(128, 128, 128))
        # Random brightness/contrast
        from PIL import ImageEnhance  # type: ignore
        if random.random() > 0.4:
            factor = random.uniform(0.7, 1.3)
            img = ImageEnhance.Brightness(img).enhance(factor)
        if random.random() > 0.4:
            factor = random.uniform(0.8, 1.2)
            img = ImageEnhance.Contrast(img).enhance(factor)

    arr = np.array(img, dtype=np.float32) / 255.0
    return arr


def make_batch(samples_slice, augment=False):
    """Build a batch of (X, {aga, density, cond, ratio}) tensors."""
    X      = []
    y_aga  = []
    y_dens = []
    y_cond = []
    y_ratio= []
    for s in samples_slice:
        X.append(load_and_preprocess(s["path"], augment=augment))
        y_aga.append([float(s["label_aga"])])
        dens_oh = [0.0, 0.0, 0.0]; dens_oh[s["label_density"]] = 1.0
        y_dens.append(dens_oh)
        cond_oh = [0.0, 0.0, 0.0, 0.0]; cond_oh[s["condition"]] = 1.0
        y_cond.append(cond_oh)
        y_ratio.append([s["mini_ratio"]])
    return (
        np.array(X, dtype=np.float32),
        {
            "aga"     : np.array(y_aga,   dtype=np.float32),
            "density" : np.array(y_dens,  dtype=np.float32),
            "condition": np.array(y_cond,  dtype=np.float32),
            "ratio"   : np.array(y_ratio, dtype=np.float32),
        }
    )


def make_tf_dataset(samples_list, augment=False, shuffle=True):
    """Create tf.data.Dataset from list of sample dicts."""
    def gen():
        indices = list(range(len(samples_list)))
        if shuffle:
            random.shuffle(indices)
        for i in indices:
            s   = samples_list[i]
            arr = load_and_preprocess(s["path"], augment=augment)
            yield (
                arr,
                (
                    np.array([float(s["label_aga"])], dtype=np.float32),
                    np.eye(3, dtype=np.float32)[s["label_density"]],
                    np.eye(4, dtype=np.float32)[s["condition"]],
                    np.array([s["mini_ratio"]], dtype=np.float32),
                )
            )

    output_sig = (
        tf.TensorSpec(shape=(IMG_SIZE, IMG_SIZE, 3), dtype=tf.float32),
        (
            tf.TensorSpec(shape=(1,), dtype=tf.float32),
            tf.TensorSpec(shape=(3,), dtype=tf.float32),
            tf.TensorSpec(shape=(4,), dtype=tf.float32),
            tf.TensorSpec(shape=(1,), dtype=tf.float32),
        )
    )

    ds = tf.data.Dataset.from_generator(gen, output_signature=output_sig)
    ds = ds.batch(BATCH_SIZE).prefetch(tf.data.AUTOTUNE)
    return ds


print("\n[3] Building tf.data pipelines ...")
train_ds = make_tf_dataset(train_samples, augment=True,  shuffle=True)
val_ds   = make_tf_dataset(val_samples,   augment=False, shuffle=False)

# ─── 4. MODEL ARCHITECTURE ────────────────────────────────────────────────────
print("\n[4] Building EfficientNetB0 multi-task model ...")

def build_model():
    inp = keras.Input(shape=(IMG_SIZE, IMG_SIZE, 3), name="image_input")

    # EfficientNet backbone (frozen initially)
    backbone = EfficientNetB0(
        include_top=False,
        weights="imagenet",
        input_tensor=inp,
        pooling="avg"
    )
    backbone.trainable = False

    x = backbone.output

    # Shared dense layer
    x = layers.Dense(256, activation="relu",
                     kernel_regularizer=regularizers.l2(1e-4), name="shared_fc")(x)
    x = layers.BatchNormalization(name="shared_bn")(x)
    x = layers.Dropout(0.4, name="shared_dropout")(x)

    # ── Task heads ──────────────────────────────────────────────────────────

    # Head 1: AGA probability (binary sigmoid)
    aga_x   = layers.Dense(64, activation="relu", name="aga_fc")(x)
    aga_out = layers.Dense(1, activation="sigmoid", name="aga")(aga_x)

    # Head 2: Hair density (3-class softmax)
    dens_x   = layers.Dense(64, activation="relu", name="density_fc")(x)
    dens_out = layers.Dense(3, activation="softmax", name="density")(dens_x)

    # Head 3: Scalp condition (4-class softmax)
    cond_x   = layers.Dense(64, activation="relu", name="cond_fc")(x)
    cond_out = layers.Dense(4, activation="softmax", name="condition")(cond_x)

    # Head 4: Miniaturized ratio regression (sigmoid → 0–1, display as %)
    ratio_x   = layers.Dense(64, activation="relu", name="ratio_fc")(x)
    ratio_out = layers.Dense(1, activation="sigmoid", name="ratio")(ratio_x)

    model = Model(inputs=inp, outputs=[aga_out, dens_out, cond_out, ratio_out],
                  name="Tricholens_v5")
    return model, backbone


model, backbone = build_model()

# ─── 5. PHASE 1: TRAIN HEAD ONLY ─────────────────────────────────────────────
print("\n[5] Phase 1: Training head layers only ...")

model.compile(
    optimizer=keras.optimizers.Adam(1e-3),
    loss={
        "aga"     : "binary_crossentropy",
        "density" : "categorical_crossentropy",
        "condition": "categorical_crossentropy",
        "ratio"   : "mean_squared_error",
    },
    loss_weights={"aga": 2.0, "density": 1.5, "condition": 1.5, "ratio": 3.0},
    metrics={
        "aga"     : ["accuracy"],
        "density" : ["accuracy"],
        "condition": ["accuracy"],
        "ratio"   : ["mae"],
    }
)

model.summary()

callbacks_p1 = [
    EarlyStopping(monitor="val_loss", patience=6, restore_best_weights=True,
                  verbose=1),
    ReduceLROnPlateau(monitor="val_loss", factor=0.5, patience=3, verbose=1),
    ModelCheckpoint("best_head.keras", monitor="val_loss", save_best_only=True,
                    verbose=0),
]

h1 = model.fit(
    train_ds,
    validation_data=val_ds,
    epochs=EPOCHS_FREEZE,
    callbacks=callbacks_p1,
    verbose=1
)

# ─── 6. PHASE 2: FINE-TUNE TOP LAYERS ────────────────────────────────────────
print("\n[6] Phase 2: Fine-tuning top 40 backbone layers ...")

# Unfreeze top 40 layers of backbone
backbone.trainable = True
for layer in backbone.layers[:-40]:
    layer.trainable = False

model.compile(
    optimizer=keras.optimizers.Adam(1e-4),
    loss={
        "aga"     : "binary_crossentropy",
        "density" : "categorical_crossentropy",
        "condition": "categorical_crossentropy",
        "ratio"   : "mean_squared_error",
    },
    loss_weights={"aga": 2.0, "density": 1.5, "condition": 1.5, "ratio": 3.0},
    metrics={
        "aga"     : ["accuracy"],
        "density" : ["accuracy"],
        "condition": ["accuracy"],
        "ratio"   : ["mae"],
    }
)

callbacks_p2 = [
    EarlyStopping(monitor="val_loss", patience=8, restore_best_weights=True,
                  verbose=1),
    ReduceLROnPlateau(monitor="val_loss", factor=0.5, patience=4, verbose=1),
    ModelCheckpoint("best_finetune.keras", monitor="val_loss",
                    save_best_only=True, verbose=0),
]

h2 = model.fit(
    train_ds,
    validation_data=val_ds,
    epochs=EPOCHS_FINE,
    callbacks=callbacks_p2,
    verbose=1
)

# ─── 7. EVALUATE ──────────────────────────────────────────────────────────────
print("\n[7] Evaluating on validation set ...")
val_results = model.evaluate(val_ds, verbose=1)
print(f"   Validation metrics: {dict(zip(model.metrics_names, val_results))}")

# ─── 8. CONVERT TO TFLITE ─────────────────────────────────────────────────────
print(f"\n[8] Converting to TFLite -> {OUTPUT_TFLITE}")

converter = tf.lite.TFLiteConverter.from_keras_model(model)
converter.optimizations = [tf.lite.Optimize.DEFAULT]
converter.target_spec.supported_types = [tf.float16]   # FP16 quantization

try:
    tflite_model = converter.convert()
    with open(OUTPUT_TFLITE, "wb") as f:
        f.write(tflite_model)
    print(f"   Saved: {OUTPUT_TFLITE} ({len(tflite_model)//1024} KB)")
except Exception as e:
    print(f"   FP16 failed: {e}. Trying dynamic range ...")
    converter2 = tf.lite.TFLiteConverter.from_keras_model(model)
    converter2.optimizations = [tf.lite.Optimize.DEFAULT]
    tflite_model = converter2.convert()
    with open(OUTPUT_TFLITE, "wb") as f:
        f.write(tflite_model)
    print(f"   Saved (dynamic): {OUTPUT_TFLITE} ({len(tflite_model)//1024} KB)")

# ─── 9. VERIFY TFLITE ─────────────────────────────────────────────────────────
print("\n[9] Verifying TFLite model ...")
interp = tf.lite.Interpreter(model_path=OUTPUT_TFLITE)
interp.allocate_tensors()
in_details  = interp.get_input_details()
out_details = interp.get_output_details()

print("   Input :", in_details[0]["name"], in_details[0]["shape"])
print("   Outputs:")
for d in out_details:
    print(f"     {d['name']} -> {d['shape']}")

# Test inference
dummy = np.zeros((1, IMG_SIZE, IMG_SIZE, 3), dtype=np.float32)
interp.set_tensor(in_details[0]["index"], dummy)
interp.invoke()

print("   Dummy inference outputs:")
for d in out_details:
    t = interp.get_tensor(d["index"])
    print(f"     {d['name']}: {t}")

print("\n" + "=" * 60)
print("  TRAINING COMPLETE!")
print(f"  Model saved: {OUTPUT_TFLITE}")
print("  Copy file to backend_python/ and restart server.")
print("=" * 60)
