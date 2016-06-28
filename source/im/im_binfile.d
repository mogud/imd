/** \file
 * \brief Binary File Access.
 *
 * See Copyright Notice in im_lib.d
 */

module im.binfile;

extern (C) @safe nothrow:

/** \defgroup binfile Binary File Access
 *
 * \par
 * These functions are very usefull for reading/writing binary files
 * that have headers or data that have to be converted depending on
 * the current CPU byte order. It can invert 2, 4 or 8 bytes numbers to/from little/big-endian orders.
 * \par
 * It will process the data only if the file format is diferent from the current CPU.
 * \par
 * Can read from disk or memory. In case of a memory buffer, the file name must be the \ref imBinMemoryFileName structure.
 * \par
 * See \ref im_binfile.h
 * \ingroup util */

/** \brief Binary File Structure (Private).
 * \ingroup binfile */
struct _imBinFile;
alias imBinFile = _imBinFile;

/** Opens an existant binary file for reading.
 * The default file byte order is the CPU byte order.
 * Returns NULL if failed.
 * \ingroup binfile */
imBinFile* imBinFileOpen(const(char) * pFileName);

/** Creates a new binary file for writing.
 * The default file byte order is the CPU byte order.
 * Returns NULL if failed.
 * \ingroup binfile */
imBinFile* imBinFileNew(const(char) * pFileName);

/** Closes the file.
 * \ingroup binfile */
void imBinFileClose(imBinFile* bfile);

/** Indicates that was an error on the last operation.
 * \ingroup binfile */
int imBinFileError(imBinFile* bfile);

/** Returns the file size in bytes.
 * \ingroup binfile */
ulong imBinFileSize(imBinFile* bfile);

/** Changes the file byte order. Returns the old one.
 * \ingroup binfile */
int imBinFileByteOrder(imBinFile* bfile, int pByteOrder);

/** Reads an array of count values with byte sizes: 1, 2, 4, or 8. And invert the byte order if necessary after read. \n
 * Returns the actual count of values read.
 * \ingroup binfile */
ulong imBinFileRead(imBinFile* bfile, void* pValues, ulong pCount, int pSizeOf);

/** Writes an array of values with sizes: 1, 2, 4, or 8. And invert the byte order if necessary before write.\n
 * <b>ATENTION</b>: The function will not make a temporary copy of the values to invert the byte order.\n
 * So after the call the values will be invalid, if the file byte order is diferent from the CPU byte order. \n
 * Returns the actual count of values writen.
 * \ingroup binfile */
ulong imBinFileWrite(imBinFile* bfile, void* pValues, ulong pCount, int pSizeOf);

/** Writes a string without the NULL terminator. The function uses sprintf to compose the string. \n
 * The internal buffer is fixed at 4096 bytes. \n
 * Returns the actual count of values writen.
 * \ingroup binfile */
ulong imBinFilePrintf(imBinFile* bfile, const(char) *format, ...);

/** Reads a line until line break. \n
 * Returns the line in array, must have room enough. Line break is discarted. \n
 * Use *size to inform buffer size. *size return the actual number os characters read.
 * \ingroup binfile */
int imBinFileReadLine(imBinFile* handle, char* comment, int *size);

/** Skips a line, including line break.
 * \ingroup binfile */
int imBinFileSkipLine(imBinFile* handle);

/** Reads an integer number from the current position until found a non integer character.
 * Returns a non zero value if sucessfull.
 * \ingroup binfile */
int imBinFileReadInteger(imBinFile* handle, int *value);

/** Reads an floating point number from the current position until found a non number character.
 * Returns a non zero value if sucessfull.
 * \ingroup binfile */
int imBinFileReadReal(imBinFile* handle, double *value);

/** Moves the file pointer from the begining of the file.\n
 * When writing to a file seeking can go beyond the end of the file.
 * \ingroup binfile */
void imBinFileSeekTo(imBinFile* bfile, ulong pOffset);

/** Moves the file pointer from current position.\n
 * If the offset is a negative value the pointer moves backwards.
 * \ingroup binfile */
void imBinFileSeekOffset(imBinFile* bfile, long pOffset);

/** Moves the file pointer from the end of the file.\n
 * The offset is usually a negative value.
 * \ingroup binfile */
void imBinFileSeekFrom(imBinFile* bfile, long pOffset);

/** Returns the current offset position.
 * \ingroup binfile */
ulong imBinFileTell(imBinFile* bfile);

/** Indicates that the file pointer is at the end of the file.
 * \ingroup binfile */
int imBinFileEndOfFile(imBinFile* bfile);

/** Predefined I/O Modules.
 * \ingroup binfile */
enum imBinFileModule
{
	IM_RAWFILE,   /**< System dependent file I/O Rotines. */
	IM_STREAM,    /**< Standard Ansi C Stream I/O Rotines. */
	IM_MEMFILE,   /**< Uses a memory buffer (see \ref imBinMemoryFileName). */
	IM_SUBFILE,   /**< It is a sub file. FileName is a imBinFile* pointer from any other module. */
  IM_FILEHANDLE,/**< System dependent file I/O Rotines, but FileName is a system file handle ("int" in UNIX and "HANDLE" in Windows). */
	IM_IOCUSTOM0  /**< Other registered modules starts from here. */
};

/** Sets the current I/O module.
 * \returns the previous function set, or -1 if failed.
 * See also \ref imBinFileModule.
 * \ingroup binfile */
int imBinFileSetCurrentModule(int pModule);

/** \brief Memory File Filename Parameter Structure
 *
 * \par
 *  Fake file name for the memory I/O module.
 * \ingroup binfile */
struct _imBinMemoryFileName
{
  ubyte *buffer; /**< The memory buffer. If you are reading the buffer must exists.
                          *   If you are writing the buffer can be internally allocated to the given size. The buffer is never free.
                          *   The buffer is allocated using "malloc", and reallocated using "realloc". Use "free" to release it.
                          *   To avoid RTL conflicts use the function imBinMemoryRelease. */
  int size;              /**< Size of the buffer. */
  float reallocate;      /**< Reallocate factor for the memory buffer when writing (size += reallocate*size).
                          *   Set reallocate to 0 to disable reallocation, in this case buffer must not be NULL. */
}
alias imBinMemoryFileName = _imBinMemoryFileName;

/** Release the internal memory allocated when writing a Memory File (see \ref imBinMemoryFileName).
 * \ingroup binfile */
void imBinMemoryRelease(ubyte *buffer);
