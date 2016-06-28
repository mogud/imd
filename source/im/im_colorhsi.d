/** \file
 * \brief HSI Color Manipulation
 *
 * See Copyright Notice in im_lib.d
 */

module im.colorhsi;

extern (C) @safe nothrow:


/** \defgroup hsi HSI Color Coordinate System Conversions
 *
 * \par
 * HSI is just the RGB color space written in a different coordinate system.
 * \par
 * "I" is defined along the cube diagonal. It ranges from 0 (black) to 1 (white). \n
 * HS are the polar coordinates of a plane normal to "I". \n
 * "S" is the normal distance from the diagonal of the RGB cube. It ranges from 0 to 1. \n
 * "H" is the angle starting from the red vector, given in degrees.
 * \par
 * This is not a new color space, this is exactly the same gamut as RGB. \n
 * \par
 * See \ref im_colorhsi.h
 * \ingroup color */


/** Returns I where S is maximum given H (here in radians).
 * \ingroup hsi */
float imColorHSI_ImaxS(float h, double cosh, double sinh);

/** Converts from RGB to HSI.
 * \ingroup hsi */
void imColorRGB2HSI(float r, float g, float b, float *h, float *s, float *i);

/** Converts from RGB (byte) to HSI.
 * \ingroup hsi */
void imColorRGB2HSIbyte(ubyte r, ubyte g, ubyte b, float *h, float *s, float *i);

/** Converts from HSI to RGB.
 * \ingroup hsi */
void imColorHSI2RGB(float h, float s, float i, float *r, float *g, float *b);

/** Converts from HSI to RGB (byte).
 * \ingroup hsi */
void imColorHSI2RGBbyte(float h, float s, float i, ubyte *r, ubyte *g, ubyte *b);
