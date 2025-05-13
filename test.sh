#!/usr/bin/env bash
set -e

url='https://raw.githubusercontent.com/alecjacobson/common-3d-test-models/master/data/bunny.ply'
tmp=$(mktemp -d)
curl -fsSL "$url" -o "$tmp/bunny.ply"

docker run --rm -v "$tmp":/data meshlab-xpra \
    meshlabserver -i /data/bunny.ply -o /data/bunny_out.stl -m vt -s

# very small STL ⇒ 3D conversion succeeded
if [ -s "$tmp/bunny_out.stl" ]; then
    echo "MeshLab CLI conversion ✔  ($(du -h "$tmp/bunny_out.stl" | cut -f1))"
else
    echo "❌  MeshLab did not create output"; exit 1
fi
