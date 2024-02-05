#pragma once

#ifndef INCLUDED_Sys
#include <Sys.h>
#endif

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
        png_bytep buffer = (png_bytep)malloc(PNG_IMAGE_SIZE(img));

        if (png_image_finish_read(&img, NULL, buffer, 0, NULL) != 0) {
            *width = (int)img.width;
            *height = (int)img.height;

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