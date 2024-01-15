---
slug: 246-openslide-python-cut-mrxs-slide
date: '2022-05-28'
layout: post
title: 使用 OpenSlide Python 分割显微镜影像的 MRXS 文件
tags:
  - Python
  - Image Processing
issue: 246
---

我的姐姐是一位大学教授，她的课题研究中，需要处理一些显微镜影像图片，但是 MRXS 文件导出的 TIF 图片尺寸太大，通常能达到几万到十几万像素，文件体积也能达到六七百M甚至更大，这样巨大的文件，通常的看图软件或者图片处理软件根本无法打开。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/2dcccdd7-1d4f-4f9a-a60a-6fbaf49c2658)

我拿到图片后，也尝试了一些处理软件，均以失败告终，于是想到使用 Python 的图像库来进行处理，尝试了 cv2, PIL, Pillow 等一些库，都没有能够解决。

```python
import cv2
large_image = cv2.imread("E:\\imagematch\\CMU-1-Saved-1_2.mrxs")
```

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/8dc6b5ca-f4f3-48ec-900d-dfca85a062f4)

即使手动设置 [OPENCV_IO_MAX_IMAGE_PIXELS](https://stackoverflow.com/questions/58070174/overcome-opencv-cv-io-max-image-pixels-limitation-in-python) 也无济于事。

* [h5py - out of core 4D image tif storage as hdf5 python - Stack Overflow](https://stackoverflow.com/questions/31951507/out-of-core-4d-image-tif-storage-as-hdf5-python)
* [python - OpenCV will not load a big image (~4GB) - Stack Overflow](https://stackoverflow.com/questions/35666761/opencv-will-not-load-a-big-image-4gb)

于是我转变了想法，可不可以直接处理 MRXS 文件呢，毕竟 [CaseViewer](https://www.sysmex-europe.com/products/products-detail/caseviewer.html) 本身就可以按照区域查看 Slide 中的图像。

网上搜索后，找到了 OpenSlide 这个库，尝试了下，发现可以解析 MRXS 文件，比如如下的脚本，可以正确的拿到各个缩放级别的图像尺寸，看样子有戏。

```python
slide = openslide.OpenSlide("E:\\imagematch\\CMU-1-Saved-1_2.mrxs")
print(slide.level_dimensions)

# ((57230, 117638), (28615, 58819), (14307, 29409), (7153, 14704), (3576, 7352), (1788, 3676), (894, 1838), (447, 919), (223, 459))
```

OpenSlide 是有一个 [read_region](https://github.com/openslide/openslide-python/blob/main/openslide/__init__.py#L215) 方法的，可以用来读取区域的图像，从而达到裁剪的目的。

```python
def read_region(self, location, level, size):
```

不过我们今天会使用另一个工具 - [DeepZoomGenerator](https://github.com/openslide/openslide-python/blob/main/openslide/deepzoom.py#L35)，它可以按照我们指定的尺寸来裁剪图像，例如按照 3000x3000 来裁剪的话，在不同的缩放级别下，会生成不同的“小”块， 在最高的缩放级别上面，会生成 20 列 40 行的图像。

```python
data_gen = DeepZoomGenerator(slide, tile_size=3000, overlap=0, limit_bounds=False)
print(data_gen.level_tiles)
# ((1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 2), (2, 3), (3, 5), (5, 10), (10, 20), (20, 40))
```

遍历这些行列，保存这些图像就可以完成裁剪了。

```python
data_gen = DeepZoomGenerator(slide, tile_size=3000, overlap=0, limit_bounds=False)
level = data_gen.level_count - 1
[cols, rows] = data_gen.level_tiles[-1]

for col in range(cols):
  for row in range(rows):
    im = data_gen.get_tile(level, (col, row))
    im.save("E:\\imagematch\\output\\%s_%s.jpg" % (col, row))
```

但是这样裁剪下来有一个问题，就是很多空白图片，一张 Slide 上面，实验数据只占一点点。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/2f568116-cdeb-4d64-9631-4b3c4102dbf8)

我们可以简单的丢弃掉纯白的图像，只保留有内容的。

```python
    extrema = im.convert("L").getextrema()
    if extrema[0] != extrema[1]:
      im.save("E:\\imagematch\\output\\%s_%s.jpg" % (col, row))
```

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/0bf95e9c-2fd0-4c6e-9826-b79deb26715d)

完整的脚本

```python
import os

# 如果脚本找不到 openslide 运行库，可以这样手动指定
os.add_dll_directory("C:\\tools\\openslide-win64-20171122\\bin")

import openslide
from openslide.deepzoom import DeepZoomGenerator

# 使用 Open Slide 打开 mrxs
img_path = "E:\\imagematch\\slide-8.mrxs"
slide = openslide.OpenSlide(img_path)

# 按照 3000 x 3000 切割图片，如果想要更大的图，可以自己调整，overlap 是指图片边界不重叠
data_gen = DeepZoomGenerator(slide, tile_size=3000, overlap=0, limit_bounds=False)
# 拿到最高像素的缩放级别
level = data_gen.level_count - 1

# 获取最高像素下分割后的列数和行数
[cols, rows] = data_gen.level_tiles[-1]
print(cols, rows)
# 循环读取各个行列的图像
for col in range(cols):
  for row in range(rows):
    print("Processing %s %s" % (col, row))
    im = data_gen.get_tile(level, (col, row))
    # 如果图像是纯白，则跳过
    extrema = im.convert("L").getextrema()
    if extrema[0] != extrema[1]:
      # 保存图像到 output 文件夹（需要提前创建这个文件夹）
      im.save("E:\\imagematch\\output\\%s_%s.jpg" % (col, row))
```

> 用到的 Slide 文件，可以在[这里](https://openslide.cs.cmu.edu/download/openslide-testdata/Mirax/)下载到。

参考资料

- [Use openslide-python to read and display the whole slide image (WSI), build pyramids, and generate tiles - Birost](https://blog.birost.com/a?ID=00800-af72b716-dcac-4855-876f-c149e0240726)
- [Python Openslide 自动切割病理图像 | We all are data.](http://blog.pointborn.com/article/2020/7/21/857.html)
- [MIRAX (MRXS) 示例数据](https://openslide.cs.cmu.edu/download/openslide-testdata/Mirax/)
- [openslide/openslide-python: Python bindings to OpenSlide](https://github.com/openslide/openslide-python)
- [Windows cdll.LoadLibrary('libopenslide-0.dll') OSError: [WinError 127] The specified procedure could not be found · Issue #51 · openslide/openslide-python](https://github.com/openslide/openslide-python/issues/51)
- [Downloading OpenSlide](https://openslide.org/download/#windows-binaries)
- [Python PIL Detect if an image is completely black or white - Stack Overflow](https://stackoverflow.com/questions/14041562/python-pil-detect-if-an-image-is-completely-black-or-white)
