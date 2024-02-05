#pragma once

#include <includeWorkaround.h>
#include <stdio.h>
#include <stdlib.h>
#include <png.h>

int loadPng(const char* path, int* width, int* height) {
    png_image img;
    memset(&img, 0, sizeof(img));
    img.version = PNG_IMAGE_VERSION;

    if (png_image_begin_read_from_file(&img, path) != 0) {
        img.format = PNG_FORMAT_RGBA;
        png_uint_32 row_stride = PNG_IMAGE_ROW_STRIDE(img);
        png_bytep buffer = (png_bytep)malloc(PNG_IMAGE_BUFFER_SIZE(img, row_stride));

        if (png_image_finish_read(&img, NULL, buffer, row_stride, NULL) != 0) {
            *width = img.width;
            *height = img.height;

            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, img.width, img.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
            png_image_free(&img);
            free(buffer);
            return 1;
        } else {
            printf("Failed to load \"%s\".\n", path);
            png_image_free(&img);
            free(buffer);
            return 0;
        }
    } else {
        printf("Failed to load \"%s\".\n", path);
        png_image_free(&img);
        return 0;
    }
}