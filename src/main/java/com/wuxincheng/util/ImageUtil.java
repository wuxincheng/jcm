package com.wuxincheng.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ImageUtil {
	
	public static Map<String, Object> getImageSize(InputStream fis) throws IOException {
        BufferedImage image = ImageIO.read(fis);
        Map<String, Object> size = new HashMap<String, Object>();
        size.put("width", image.getWidth());
        size.put("height", image.getHeight());
        return size;
    }

	public static String getSuffix(String fileName) {
        int index = fileName.lastIndexOf(".");
        if (index < 0){
        	return null;
        }

        return fileName.substring(index);
    }
	
	public static void crop(String src, String dest, int scaledWith, int scaledHeight, int x,
            int y, int w, int h) throws IOException {
        BufferedImage image = ImageIO.read(new File(src));
        int widthOrigin = image.getWidth();
        int heightOrigin = image.getHeight();

        if (x < 0 || y < 0 || w <= 0 || h <= 0) {
            throw new IllegalArgumentException("裁剪参数不正确");
        }

        // 需要缩放
        if (scaledWith > 0 && scaledHeight > 0 && scaledWith != heightOrigin
                && scaledHeight != widthOrigin) {
            BufferedImage imageScale = new BufferedImage(scaledWith, scaledHeight,
                    BufferedImage.TYPE_INT_RGB);
            imageScale.getGraphics().drawImage(
                    image.getScaledInstance(scaledWith, scaledHeight, java.awt.Image.SCALE_SMOOTH),
                    0, 0, null);
            image = imageScale;
        } else {
            scaledWith = widthOrigin;
            scaledHeight = heightOrigin;
        }

        if (x + w > scaledWith || y + h > scaledHeight) {
            throw new IllegalArgumentException("裁剪参数不正确");
        }

        // 开始裁剪
        BufferedImage imageCrop = image.getSubimage(x, y, w, h);

        FileOutputStream newimage = null;
        try {
            newimage = new FileOutputStream(dest);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimage);
            JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(imageCrop);
            jep.setQuality(1.0f, true);
            encoder.encode(imageCrop, jep);
        } finally {
            if (newimage != null) {
                newimage.close();
            }
        }
    }
	
}
