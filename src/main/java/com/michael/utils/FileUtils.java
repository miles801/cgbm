package com.michael.utils;

import java.io.File;
import java.io.IOException;

/**
 * @author Michael
 */
public class FileUtils {

    /**
     * 创建文件，如果上级文件不存在，则同时创建
     * 如果false，则表示文件已经是存在的，没有创建新的
     * 如果true，则表示创建成功
     *
     * @param path 文件路径
     */
    public static boolean createFile(String path) {
        if (path == null || "".equals(path.trim())) {
            throw new RuntimeException("创建文件失败：文件路径不能为空!");
        }

        File file = new File(path);
        if (file.exists()) {
            file.delete();
//            return false;
        }
        path = path.replaceAll("\\\\", "/");
        String directoryPah = path.substring(0, path.lastIndexOf("/"));
        File directory = new File(directoryPah);
        if (!directory.exists()) {
            boolean success = directory.mkdirs();
            if (!success) {
                throw new RuntimeException("创建目录失败：" + directoryPah);
            }
        }
        try {
            return file.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
}
