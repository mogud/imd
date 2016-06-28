/** \file
 * \brief Old API
 *
 * See Copyright Notice in im_lib.d
 */

module im.old;

extern (C) @safe nothrow:

enum {IM_BMP, IM_PCX, IM_GIF, IM_TIF, IM_RAS, IM_SGI, IM_JPG, IM_LED, IM_TGA};
enum {IM_NONE = 0x0000, IM_DEFAULT = 0x0100, IM_COMPRESSED = 0x0200};

import im.im: imErrorCodes;

alias IM_ERR_READ = imErrorCodes.IM_ERR_ACCESS;
alias IM_ERR_WRITE = imErrorCodes.IM_ERR_ACCESS;
alias IM_ERR_TYPE = imErrorCodes.IM_ERR_DATA;
alias IM_ERR_COMP = imErrorCodes.IM_ERR_COMPRESS;

long imEncodeColor(char red, char green, char blue);
void imDecodeColor(char* red, char* green, char* blue, long palette);
int imFileFormat(char *filename, int* format);
int imImageInfo(char *filename, int *width, int *height, int *type, int *palette_count);
int imLoadRGB(char *filename, char *red, char *green, char *blue);
int imSaveRGB(int width, int height, int format, char *red, char *green, char *blue, char *filename);
int imLoadMap(char *filename, char *map, long *palette);
int imSaveMap(int width, int height, int format, char *map, int palette_count, long *palette, char *filename);
void imRGB2Map(int width, int height, char *red, char *green, char *blue, char *map, int palette_count, long *palette);
void imMap2RGB(int width, int height, char *map, int palette_count, long *colors, char *red, char *green, char *blue);
void imRGB2Gray(int width, int height, char *red, char *green, char *blue, char *map, long *grays);
void imMap2Gray(int width, int height, char *map, int palette_count, long *colors, char *grey_map, long *grays);
void imResize(int src_width, int src_height, char *src_map, int dst_width, int dst_height, char *dst_map);
void imStretch(int src_width, int src_height, char *src_map, int dst_width, int dst_height, char *dst_map);
alias imCallback = int function(char *filename);
int imRegisterCallback(imCallback cb, int cb_id, int format);

enum IM_INTERRUPTED = -1;
enum IM_ALL = -1;
enum IM_COUNTER_CB = 0;
alias imFileCounterCallback = int function(char *filename, int percent, int io);

enum IM_RESOLUTION_CB = 1;
alias imResolutionCallback = int function(char *filename, double* xres, double* yres, int* res_unit);

enum {IM_RES_NONE, IM_RES_DPI, IM_RES_DPC};

enum IM_GIF_TRANSPARENT_COLOR_CB = 0;
alias imGifTranspIndex = int function(char *filename, char *transp_index);

enum IM_TIF_IMAGE_DESCRIPTION_CB = 0;
alias imTiffImageDesc = int function(char *filename, char* img_desc);
