/** \file
 * \brief IM Lua 5 Binding
 *
 * See Copyright Notice in im_lib.h
 */

module im.lua;

extern (C) @safe nothrow:

struct lua_State;

/** \defgroup imlua ImLua 5 Binding Reference
 * \par
 * Binding for the Lua 5 scripting language.           \n
 * Lua 5.1 Copyright (C) 1994-2005 Lua.org, PUC-Rio    \n
 * R. Ierusalimschy, L. H. de Figueiredo & W. Celes    \n
 * http://www.lua.org
 * \par
 * See \ref imlua.h
 * \ingroup util */

void imlua_open();

/** Initializes the Lua binding of the main IM library.  \n
 * Returns 1 (leaves the im table on the top of the stack).
 * You must link the application with the "imlua51" library.
 * \ingroup imlua */
int imlua_open(lua_State *L);

/** Calls \ref imFormatRemoveAll to release internal memory.
 * Also available in Lua as "im.Close()".
* \ingroup imlua */
int imlua_close(lua_State *L);

import im.image: imImage;
/** Pushes an image as a metatable on the stack.
 * \ingroup imlua */
void imlua_pushimage(lua_State *L, imImage* image);

/** Gets an image as a metatable from the stack, checks for correct type.
 * \ingroup imlua */
imImage* imlua_checkimage(lua_State *L, int param);

/** Initializes the Lua binding of the capture library.  \n
 * Returns 1 (leaves the im table on the top of the stack).
 * You must link the application with the "imlua_capture51" library.
 * \ingroup imlua */
int imlua_open_capture(lua_State *L);

/** Initializes the Lua binding of the process library.  \n
 * Returns 1 (leaves the im table on the top of the stack).
 * You must link the application with the "imlua_process51" library.
 * \ingroup imlua */
int imlua_open_process(lua_State *L);

/** Initializes the Lua binding of the fourier transform library.  \n
 * Returns 1 (leaves the im table on the top of the stack).
 * You must link the application with the "imlua_fftw51" library.
 * \ingroup imlua */
int imlua_open_fftw(lua_State *L);
