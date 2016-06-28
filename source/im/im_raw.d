/** \file
 * \brief RAW File Format
 *
 * See Copyright Notice in im_lib.h
 */


module im.raw;

import im.image;
import im.file: imFile;

extern (C) @safe nothrow:


/** Opens a RAW image file.
 * See also \ref imErrorCodes.
 *
 * \verbatim im.FileOpenRaw(file_name: string) -> ifile: imFile, error: number [in Lua 5] \endverbatim
 * \ingroup raw */
imFile* imFileOpenRaw(const(char) * file_name, int *error);

/** Creates a RAW image file.
 * See also \ref imErrorCodes.
 *
 * \verbatim im.FileNewRaw(file_name: string) -> ifile: imFile, error: number [in Lua 5] \endverbatim
 * \ingroup raw */
imFile* imFileNewRaw(const(char) * file_name, int *error);

