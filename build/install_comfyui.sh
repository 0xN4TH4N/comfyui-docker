#!/usr/bin/env bash
set -e

# Clone the repo
git clone https://github.com/comfyanonymous/ComfyUI.git /ComfyUI
cd /ComfyUI
git checkout ${COMFYUI_VERSION}

# Create and activate the venv
python3 -m venv --system-site-packages venv
source venv/bin/activate

# Upgrade pip
pip3 install --upgrade pip

# Install torch
pip3 install --no-cache-dir torch=="${TORCH_VERSION}" torchvision torchaudio --index-url ${INDEX_URL}

# Install xformers if version is specified
if [ -n "${XFORMERS_VERSION}" ]; then
    pip3 install --no-cache-dir xformers=="${XFORMERS_VERSION}" --index-url ${INDEX_URL}
fi

# Install requirements
pip3 install -r requirements.txt
pip3 install accelerate
pip3 install sageattention==1.0.6
pip install setuptools --upgrade

# ═══════════════════════════════════════════════════════════════
# Install ComfyUI Custom Nodes
# ═══════════════════════════════════════════════════════════════

echo "📦 Installing ComfyUI Manager..."
git clone https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager
cd custom_nodes/ComfyUI-Manager
pip3 install -r requirements.txt
cd ../..

echo "📦 Installing rgthree-comfy..."
git clone https://github.com/rgthree/rgthree-comfy.git custom_nodes/rgthree-comfy
cd custom_nodes/rgthree-comfy
pip3 install -r requirements.txt 2>/dev/null || echo "No requirements.txt for rgthree-comfy"
cd ../..

echo "📦 Installing ComfyUI-Impact-Pack..."
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git custom_nodes/ComfyUI-Impact-Pack
cd custom_nodes/ComfyUI-Impact-Pack
pip3 install -r requirements.txt
cd ../..

echo "📦 Installing ComfyUI-Easy-Use..."
git clone https://github.com/yolain/ComfyUI-Easy-Use.git custom_nodes/ComfyUI-Easy-Use
cd custom_nodes/ComfyUI-Easy-Use
pip3 install -r requirements.txt
cd ../..

echo "📦 Installing ComfyUI_UltimateSDUpscale..."
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git custom_nodes/ComfyUI_UltimateSDUpscale
cd custom_nodes/ComfyUI_UltimateSDUpscale
pip3 install -r requirements.txt 2>/dev/null || echo "No requirements.txt for UltimateSDUpscale"
cd ../..

echo "📦 Installing comfyui-art-venture..."
git clone https://github.com/sipherxyz/comfyui-art-venture.git custom_nodes/comfyui-art-venture
cd custom_nodes/comfyui-art-venture
pip3 install -r requirements.txt
cd ../..

echo "📦 Installing ComfyUI-Impact-Subpack..."
git clone https://github.com/ltdrdata/ComfyUI-Impact-Subpack.git custom_nodes/ComfyUI-Impact-Subpack
cd custom_nodes/ComfyUI-Impact-Subpack
pip3 install -r requirements.txt 2>/dev/null || echo "No requirements.txt for Impact-Subpack"
cd ../..

echo "📦 Installing comfyui-moonpack..."
git clone https://github.com/moonwhaler/comfyui-moonpack.git custom_nodes/comfyui-moonpack
cd custom_nodes/comfyui-moonpack
pip3 install -r requirements.txt 2>/dev/null || echo "No requirements.txt for moonpack"
cd ../..

echo "📦 Installing ControlAltAI-Nodes..."
git clone https://github.com/gseth/ControlAltAI-Nodes.git custom_nodes/ControlAltAI-Nodes
cd custom_nodes/ControlAltAI-Nodes
pip3 install -r requirements.txt 2>/dev/null || echo "No requirements.txt for ControlAltAI"
cd ../..

echo "📦 Installing comfyui-vrgamedevgirl..."
git clone https://github.com/vrgamegirl19/comfyui-vrgamedevgirl.git custom_nodes/comfyui-vrgamedevgirl
cd custom_nodes/comfyui-vrgamedevgirl
pip3 install -r requirements.txt 2>/dev/null || echo "No requirements.txt for vrgamedevgirl"
cd ../..

echo "📦 Installing ComfyUI-SeedVR2_VideoUpscaler..."
git clone https://github.com/numz/ComfyUI-SeedVR2_VideoUpscaler.git custom_nodes/ComfyUI-SeedVR2_VideoUpscaler
cd custom_nodes/ComfyUI-SeedVR2_VideoUpscaler
pip3 install -r requirements.txt 2>/dev/null || echo "No requirements.txt for SeedVR2"
cd ../..

echo "📦 Installing ComfyUI-Flux-Continuum..."
git clone https://github.com/robertvoy/ComfyUI-Flux-Continuum.git custom_nodes/ComfyUI-Flux-Continuum
cd custom_nodes/ComfyUI-Flux-Continuum
pip3 install -r requirements.txt 2>/dev/null || echo "No requirements.txt for Flux-Continuum"
cd ../..

echo "📦 Installing was-node-suite-comfyui..."
git clone https://github.com/ltdrdata/was-node-suite-comfyui.git custom_nodes/was-node-suite-comfyui
cd custom_nodes/was-node-suite-comfyui
pip3 install -r requirements.txt
cd ../..

echo "📦 Installing SeedVarianceEnhancer..."
git clone https://github.com/ChangeTheConstants/SeedVarianceEnhancer.git custom_nodes/SeedVarianceEnhancer
cd custom_nodes/SeedVarianceEnhancer
pip3 install -r requirements.txt 2>/dev/null || echo "No requirements.txt for SeedVarianceEnhancer"
cd ../..

# ═══════════════════════════════════════════════════════════════

# Clear pip cache
pip3 cache purge

# Fix some incorrect modules
pip3 install numpy==1.26.4

deactivate

echo "✅ All custom nodes installed successfully!"