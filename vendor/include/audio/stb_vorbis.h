/*
NOTE: A portion of this file was moved to a seperate c file.
      Please check "vendor/src/stb_vorbis.c"
*/

// Ogg Vorbis audio decoder - v1.22 - public domain
// http://nothings.org/stb_vorbis/
//
// Original version written by Sean Barrett in 2007.
//
// Originally sponsored by RAD Game Tools. Seeking implementation
// sponsored by Phillip Bennefall, Marc Andersen, Aaron Baker,
// Elias Software, Aras Pranckevicius, and Sean Barrett.
//
// LICENSE
//
//   See end of file for license information.
//
// Limitations:
//
//   - floor 0 not supported (used in old ogg vorbis files pre-2004)
//   - lossless sample-truncation at beginning ignored
//   - cannot concatenate multiple vorbis streams
//   - sample positions are 32-bit, limiting seekable 192Khz
//       files to around 6 hours (Ogg supports 64-bit)
//
// Feature contributors:
//    Dougall Johnson (sample-exact seeking)
//
// Bugfix/warning contributors:
//    Terje Mathisen     Niklas Frykholm     Andy Hill
//    Casey Muratori     John Bolton         Gargaj
//    Laurent Gomila     Marc LeBlanc        Ronny Chevalier
//    Bernhard Wodo      Evan Balster        github:alxprd
//    Tom Beaumont       Ingo Leitgeb        Nicolas Guillemot
//    Phillip Bennefall  Rohit               Thiago Goulart
//    github:manxorist   Saga Musix          github:infatum
//    Timur Gagiev       Maxwell Koo         Peter Waller
//    github:audinowho   Dougall Johnson     David Reid
//    github:Clownacy    Pedro J. Estebanez  Remi Verschelde
//    AnthoFoxo          github:morlat       Gabriel Ravier
//
// Partial history:
//    1.22    - 2021-07-11 - various small fixes
//    1.21    - 2021-07-02 - fix bug for files with no comments
//    1.20    - 2020-07-11 - several small fixes
//    1.19    - 2020-02-05 - warnings
//    1.18    - 2020-02-02 - fix seek bugs; parse header comments; misc warnings etc.
//    1.17    - 2019-07-08 - fix CVE-2019-13217..CVE-2019-13223 (by ForAllSecure)
//    1.16    - 2019-03-04 - fix warnings
//    1.15    - 2019-02-07 - explicit failure if Ogg Skeleton data is found
//    1.14    - 2018-02-11 - delete bogus dealloca usage
//    1.13    - 2018-01-29 - fix truncation of last frame (hopefully)
//    1.12    - 2017-11-21 - limit residue begin/end to blocksize/2 to avoid large temp allocs in bad/corrupt files
//    1.11    - 2017-07-23 - fix MinGW compilation
//    1.10    - 2017-03-03 - more robust seeking; fix negative ilog(); clear error in open_memory
//    1.09    - 2016-04-04 - back out 'truncation of last frame' fix from previous version
//    1.08    - 2016-04-02 - warnings; setup memory leaks; truncation of last frame
//    1.07    - 2015-01-16 - fixes for crashes on invalid files; warning fixes; const
//    1.06    - 2015-08-31 - full, correct support for seeking API (Dougall Johnson)
//                           some crash fixes when out of memory or with corrupt files
//                           fix some inappropriately signed shifts
//    1.05    - 2015-04-19 - don't define __forceinline if it's redundant
//    1.04    - 2014-08-27 - fix missing const-correct case in API
//    1.03    - 2014-08-07 - warning fixes
//    1.02    - 2014-07-09 - declare qsort comparison as explicitly _cdecl in Windows
//    1.01    - 2014-06-18 - fix stb_vorbis_get_samples_float (interleaved was correct)
//    1.0     - 2014-05-26 - fix memory leaks; fix warnings; fix bugs in >2-channel;
//                           (API change) report sample rate for decode-full-file funcs
//
// See end of file for full version history.


//////////////////////////////////////////////////////////////////////////////
//
//  HEADER BEGINS HERE
//

#pragma once

#ifndef STB_VORBIS_INCLUDE_STB_VORBIS_H
#define STB_VORBIS_INCLUDE_STB_VORBIS_H

#if defined(STB_VORBIS_NO_CRT) && !defined(STB_VORBIS_NO_STDIO)
#define STB_VORBIS_NO_STDIO 1
#endif

#ifndef STB_VORBIS_NO_STDIO
#include <stdio.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

///////////   THREAD SAFETY

// Individual stb_vorbis* handles are not thread-safe; you cannot decode from
// them from multiple threads at the same time. However, you can have multiple
// stb_vorbis* handles and decode from them independently in multiple thrads.


///////////   MEMORY ALLOCATION

// normally stb_vorbis uses malloc() to allocate memory at startup,
// and alloca() to allocate temporary memory during a frame on the
// stack. (Memory consumption will depend on the amount of setup
// data in the file and how you set the compile flags for speed
// vs. size. In my test files the maximal-size usage is ~150KB.)
//
// You can modify the wrapper functions in the source (setup_malloc,
// setup_temp_malloc, temp_malloc) to change this behavior, or you
// can use a simpler allocation model: you pass in a buffer from
// which stb_vorbis will allocate _all_ its memory (including the
// temp memory). "open" may fail with a VORBIS_outofmem if you
// do not pass in enough data; there is no way to determine how
// much you do need except to succeed (at which point you can
// query get_info to find the exact amount required. yes I know
// this is lame).
//
// If you pass in a non-NULL buffer of the type below, allocation
// will occur from it as described above. Otherwise just pass NULL
// to use malloc()/alloca()

typedef struct
{
   char *alloc_buffer;
   int   alloc_buffer_length_in_bytes;
} stb_vorbis_alloc;


///////////   FUNCTIONS USEABLE WITH ALL INPUT MODES

typedef struct stb_vorbis stb_vorbis;

typedef struct
{
   unsigned int sample_rate;
   int channels;

   unsigned int setup_memory_required;
   unsigned int setup_temp_memory_required;
   unsigned int temp_memory_required;

   int max_frame_size;
} stb_vorbis_info;

typedef struct
{
   char *vendor;

   int comment_list_length;
   char **comment_list;
} stb_vorbis_comment;

// get general information about the file
extern stb_vorbis_info stb_vorbis_get_info(stb_vorbis *f);

// get ogg comments
extern stb_vorbis_comment stb_vorbis_get_comment(stb_vorbis *f);

// get the last error detected (clears it, too)
extern int stb_vorbis_get_error(stb_vorbis *f);

// close an ogg vorbis file and free all memory in use
extern void stb_vorbis_close(stb_vorbis *f);

// this function returns the offset (in samples) from the beginning of the
// file that will be returned by the next decode, if it is known, or -1
// otherwise. after a flush_pushdata() call, this may take a while before
// it becomes valid again.
// NOT WORKING YET after a seek with PULLDATA API
extern int stb_vorbis_get_sample_offset(stb_vorbis *f);

// returns the current seek point within the file, or offset from the beginning
// of the memory buffer. In pushdata mode it returns 0.
extern unsigned int stb_vorbis_get_file_offset(stb_vorbis *f);

///////////   PUSHDATA API

#ifndef STB_VORBIS_NO_PUSHDATA_API

// this API allows you to get blocks of data from any source and hand
// them to stb_vorbis. you have to buffer them; stb_vorbis will tell
// you how much it used, and you have to give it the rest next time;
// and stb_vorbis may not have enough data to work with and you will
// need to give it the same data again PLUS more. Note that the Vorbis
// specification does not bound the size of an individual frame.

extern stb_vorbis *stb_vorbis_open_pushdata(
         const unsigned char * datablock, int datablock_length_in_bytes,
         int *datablock_memory_consumed_in_bytes,
         int *error,
         const stb_vorbis_alloc *alloc_buffer);
// create a vorbis decoder by passing in the initial data block containing
//    the ogg&vorbis headers (you don't need to do parse them, just provide
//    the first N bytes of the file--you're told if it's not enough, see below)
// on success, returns an stb_vorbis *, does not set error, returns the amount of
//    data parsed/consumed on this call in *datablock_memory_consumed_in_bytes;
// on failure, returns NULL on error and sets *error, does not change *datablock_memory_consumed
// if returns NULL and *error is VORBIS_need_more_data, then the input block was
//       incomplete and you need to pass in a larger block from the start of the file

extern int stb_vorbis_decode_frame_pushdata(
         stb_vorbis *f,
         const unsigned char *datablock, int datablock_length_in_bytes,
         int *channels,             // place to write number of float * buffers
         float ***output,           // place to write float ** array of float * buffers
         int *samples               // place to write number of output samples
     );
// decode a frame of audio sample data if possible from the passed-in data block
//
// return value: number of bytes we used from datablock
//
// possible cases:
//     0 bytes used, 0 samples output (need more data)
//     N bytes used, 0 samples output (resynching the stream, keep going)
//     N bytes used, M samples output (one frame of data)
// note that after opening a file, you will ALWAYS get one N-bytes,0-sample
// frame, because Vorbis always "discards" the first frame.
//
// Note that on resynch, stb_vorbis will rarely consume all of the buffer,
// instead only datablock_length_in_bytes-3 or less. This is because it wants
// to avoid missing parts of a page header if they cross a datablock boundary,
// without writing state-machiney code to record a partial detection.
//
// The number of channels returned are stored in *channels (which can be
// NULL--it is always the same as the number of channels reported by
// get_info). *output will contain an array of float* buffers, one per
// channel. In other words, (*output)[0][0] contains the first sample from
// the first channel, and (*output)[1][0] contains the first sample from
// the second channel.
//
// *output points into stb_vorbis's internal output buffer storage; these
// buffers are owned by stb_vorbis and application code should not free
// them or modify their contents. They are transient and will be overwritten
// once you ask for more data to get decoded, so be sure to grab any data
// you need before then.

extern void stb_vorbis_flush_pushdata(stb_vorbis *f);
// inform stb_vorbis that your next datablock will not be contiguous with
// previous ones (e.g. you've seeked in the data); future attempts to decode
// frames will cause stb_vorbis to resynchronize (as noted above), and
// once it sees a valid Ogg page (typically 4-8KB, as large as 64KB), it
// will begin decoding the _next_ frame.
//
// if you want to seek using pushdata, you need to seek in your file, then
// call stb_vorbis_flush_pushdata(), then start calling decoding, then once
// decoding is returning you data, call stb_vorbis_get_sample_offset, and
// if you don't like the result, seek your file again and repeat.
#endif


//////////   PULLING INPUT API

#ifndef STB_VORBIS_NO_PULLDATA_API
// This API assumes stb_vorbis is allowed to pull data from a source--
// either a block of memory containing the _entire_ vorbis stream, or a
// FILE * that you or it create, or possibly some other reading mechanism
// if you go modify the source to replace the FILE * case with some kind
// of callback to your code. (But if you don't support seeking, you may
// just want to go ahead and use pushdata.)

#if !defined(STB_VORBIS_NO_STDIO) && !defined(STB_VORBIS_NO_INTEGER_CONVERSION)
extern int stb_vorbis_decode_filename(const char *filename, int *channels, int *sample_rate, short **output);
#endif
#if !defined(STB_VORBIS_NO_INTEGER_CONVERSION)
extern int stb_vorbis_decode_memory(const unsigned char *mem, int len, int *channels, int *sample_rate, short **output);
#endif
// decode an entire file and output the data interleaved into a malloc()ed
// buffer stored in *output. The return value is the number of samples
// decoded, or -1 if the file could not be opened or was not an ogg vorbis file.
// When you're done with it, just free() the pointer returned in *output.

extern stb_vorbis * stb_vorbis_open_memory(const unsigned char *data, int len,
                                  int *error, const stb_vorbis_alloc *alloc_buffer);
// create an ogg vorbis decoder from an ogg vorbis stream in memory (note
// this must be the entire stream!). on failure, returns NULL and sets *error

#ifndef STB_VORBIS_NO_STDIO
extern stb_vorbis * stb_vorbis_open_filename(const char *filename,
                                  int *error, const stb_vorbis_alloc *alloc_buffer);
// create an ogg vorbis decoder from a filename via fopen(). on failure,
// returns NULL and sets *error (possibly to VORBIS_file_open_failure).

extern stb_vorbis * stb_vorbis_open_file(FILE *f, int close_handle_on_close,
                                  int *error, const stb_vorbis_alloc *alloc_buffer);
// create an ogg vorbis decoder from an open FILE *, looking for a stream at
// the _current_ seek point (ftell). on failure, returns NULL and sets *error.
// note that stb_vorbis must "own" this stream; if you seek it in between
// calls to stb_vorbis, it will become confused. Moreover, if you attempt to
// perform stb_vorbis_seek_*() operations on this file, it will assume it
// owns the _entire_ rest of the file after the start point. Use the next
// function, stb_vorbis_open_file_section(), to limit it.

extern stb_vorbis * stb_vorbis_open_file_section(FILE *f, int close_handle_on_close,
                int *error, const stb_vorbis_alloc *alloc_buffer, unsigned int len);
// create an ogg vorbis decoder from an open FILE *, looking for a stream at
// the _current_ seek point (ftell); the stream will be of length 'len' bytes.
// on failure, returns NULL and sets *error. note that stb_vorbis must "own"
// this stream; if you seek it in between calls to stb_vorbis, it will become
// confused.
#endif

extern int stb_vorbis_seek_frame(stb_vorbis *f, unsigned int sample_number);
extern int stb_vorbis_seek(stb_vorbis *f, unsigned int sample_number);
// these functions seek in the Vorbis file to (approximately) 'sample_number'.
// after calling seek_frame(), the next call to get_frame_*() will include
// the specified sample. after calling stb_vorbis_seek(), the next call to
// stb_vorbis_get_samples_* will start with the specified sample. If you
// do not need to seek to EXACTLY the target sample when using get_samples_*,
// you can also use seek_frame().

extern int stb_vorbis_seek_start(stb_vorbis *f);
// this function is equivalent to stb_vorbis_seek(f,0)

extern unsigned int stb_vorbis_stream_length_in_samples(stb_vorbis *f);
extern float        stb_vorbis_stream_length_in_seconds(stb_vorbis *f);
// these functions return the total length of the vorbis stream

extern int stb_vorbis_get_frame_float(stb_vorbis *f, int *channels, float ***output);
// decode the next frame and return the number of samples. the number of
// channels returned are stored in *channels (which can be NULL--it is always
// the same as the number of channels reported by get_info). *output will
// contain an array of float* buffers, one per channel. These outputs will
// be overwritten on the next call to stb_vorbis_get_frame_*.
//
// You generally should not intermix calls to stb_vorbis_get_frame_*()
// and stb_vorbis_get_samples_*(), since the latter calls the former.

#ifndef STB_VORBIS_NO_INTEGER_CONVERSION
extern int stb_vorbis_get_frame_short_interleaved(stb_vorbis *f, int num_c, short *buffer, int num_shorts);
extern int stb_vorbis_get_frame_short            (stb_vorbis *f, int num_c, short **buffer, int num_samples);
#endif
// decode the next frame and return the number of *samples* per channel.
// Note that for interleaved data, you pass in the number of shorts (the
// size of your array), but the return value is the number of samples per
// channel, not the total number of samples.
//
// The data is coerced to the number of channels you request according to the
// channel coercion rules (see below). You must pass in the size of your
// buffer(s) so that stb_vorbis will not overwrite the end of the buffer.
// The maximum buffer size needed can be gotten from get_info(); however,
// the Vorbis I specification implies an absolute maximum of 4096 samples
// per channel.

// Channel coercion rules:
//    Let M be the number of channels requested, and N the number of channels present,
//    and Cn be the nth channel; let stereo L be the sum of all L and center channels,
//    and stereo R be the sum of all R and center channels (channel assignment from the
//    vorbis spec).
//        M    N       output
//        1    k      sum(Ck) for all k
//        2    *      stereo L, stereo R
//        k    l      k > l, the first l channels, then 0s
//        k    l      k <= l, the first k channels
//    Note that this is not _good_ surround etc. mixing at all! It's just so
//    you get something useful.

extern int stb_vorbis_get_samples_float_interleaved(stb_vorbis *f, int channels, float *buffer, int num_floats);
extern int stb_vorbis_get_samples_float(stb_vorbis *f, int channels, float **buffer, int num_samples);
// gets num_samples samples, not necessarily on a frame boundary--this requires
// buffering so you have to supply the buffers. DOES NOT APPLY THE COERCION RULES.
// Returns the number of samples stored per channel; it may be less than requested
// at the end of the file. If there are no more samples in the file, returns 0.

#ifndef STB_VORBIS_NO_INTEGER_CONVERSION
extern int stb_vorbis_get_samples_short_interleaved(stb_vorbis *f, int channels, short *buffer, int num_shorts);
extern int stb_vorbis_get_samples_short(stb_vorbis *f, int channels, short **buffer, int num_samples);
#endif
// gets num_samples samples, not necessarily on a frame boundary--this requires
// buffering so you have to supply the buffers. Applies the coercion rules above
// to produce 'channels' channels. Returns the number of samples stored per channel;
// it may be less than requested at the end of the file. If there are no more
// samples in the file, returns 0.

#endif

////////   ERROR CODES

enum STBVorbisError
{
   VORBIS__no_error,

   VORBIS_need_more_data=1,             // not a real error

   VORBIS_invalid_api_mixing,           // can't mix API modes
   VORBIS_outofmem,                     // not enough memory
   VORBIS_feature_not_supported,        // uses floor 0
   VORBIS_too_many_channels,            // STB_VORBIS_MAX_CHANNELS is too small
   VORBIS_file_open_failure,            // fopen() failed
   VORBIS_seek_without_length,          // can't seek in unknown-length file

   VORBIS_unexpected_eof=10,            // file is truncated?
   VORBIS_seek_invalid,                 // seek past EOF

   // decoding errors (corrupt/invalid stream) -- you probably
   // don't care about the exact details of these

   // vorbis errors:
   VORBIS_invalid_setup=20,
   VORBIS_invalid_stream,

   // ogg errors:
   VORBIS_missing_capture_pattern=30,
   VORBIS_invalid_stream_structure_version,
   VORBIS_continued_packet_flag_invalid,
   VORBIS_incorrect_stream_serial_number,
   VORBIS_invalid_first_page,
   VORBIS_bad_packet_type,
   VORBIS_cant_find_last_page,
   VORBIS_seek_failed,
   VORBIS_ogg_skeleton_not_supported
};

// global configuration settings (e.g. set these in the project/makefile),
// or just set them in this file at the top (although ideally the first few
// should be visible when the header file is compiled too, although it's not
// crucial)

// STB_VORBIS_NO_PUSHDATA_API
//     does not compile the code for the various stb_vorbis_*_pushdata()
//     functions
// #define STB_VORBIS_NO_PUSHDATA_API

// STB_VORBIS_NO_PULLDATA_API
//     does not compile the code for the non-pushdata APIs
// #define STB_VORBIS_NO_PULLDATA_API

// STB_VORBIS_NO_STDIO
//     does not compile the code for the APIs that use FILE *s internally
//     or externally (implied by STB_VORBIS_NO_PULLDATA_API)
// #define STB_VORBIS_NO_STDIO

// STB_VORBIS_NO_INTEGER_CONVERSION
//     does not compile the code for converting audio sample data from
//     float to integer (implied by STB_VORBIS_NO_PULLDATA_API)
// #define STB_VORBIS_NO_INTEGER_CONVERSION

// STB_VORBIS_NO_FAST_SCALED_FLOAT
//      does not use a fast float-to-int trick to accelerate float-to-int on
//      most platforms which requires endianness be defined correctly.
//#define STB_VORBIS_NO_FAST_SCALED_FLOAT


// STB_VORBIS_MAX_CHANNELS [number]
//     globally define this to the maximum number of channels you need.
//     The spec does not put a restriction on channels except that
//     the count is stored in a byte, so 255 is the hard limit.
//     Reducing this saves about 16 bytes per value, so using 16 saves
//     (255-16)*16 or around 4KB. Plus anything other memory usage
//     I forgot to account for. Can probably go as low as 8 (7.1 audio),
//     6 (5.1 audio), or 2 (stereo only).
#ifndef STB_VORBIS_MAX_CHANNELS
#define STB_VORBIS_MAX_CHANNELS    16  // enough for anyone?
#endif

// STB_VORBIS_PUSHDATA_CRC_COUNT [number]
//     after a flush_pushdata(), stb_vorbis begins scanning for the
//     next valid page, without backtracking. when it finds something
//     that looks like a page, it streams through it and verifies its
//     CRC32. Should that validation fail, it keeps scanning. But it's
//     possible that _while_ streaming through to check the CRC32 of
//     one candidate page, it sees another candidate page. This #define
//     determines how many "overlapping" candidate pages it can search
//     at once. Note that "real" pages are typically ~4KB to ~8KB, whereas
//     garbage pages could be as big as 64KB, but probably average ~16KB.
//     So don't hose ourselves by scanning an apparent 64KB page and
//     missing a ton of real ones in the interim; so minimum of 2
#ifndef STB_VORBIS_PUSHDATA_CRC_COUNT
#define STB_VORBIS_PUSHDATA_CRC_COUNT  4
#endif

// STB_VORBIS_FAST_HUFFMAN_LENGTH [number]
//     sets the log size of the huffman-acceleration table.  Maximum
//     supported value is 24. with larger numbers, more decodings are O(1),
//     but the table size is larger so worse cache missing, so you'll have
//     to probe (and try multiple ogg vorbis files) to find the sweet spot.
#ifndef STB_VORBIS_FAST_HUFFMAN_LENGTH
#define STB_VORBIS_FAST_HUFFMAN_LENGTH   10
#endif

// STB_VORBIS_FAST_BINARY_LENGTH [number]
//     sets the log size of the binary-search acceleration table. this
//     is used in similar fashion to the fast-huffman size to set initial
//     parameters for the binary search

// STB_VORBIS_FAST_HUFFMAN_INT
//     The fast huffman tables are much more efficient if they can be
//     stored as 16-bit results instead of 32-bit results. This restricts
//     the codebooks to having only 65535 possible outcomes, though.
//     (At least, accelerated by the huffman table.)
#ifndef STB_VORBIS_FAST_HUFFMAN_INT
#define STB_VORBIS_FAST_HUFFMAN_SHORT
#endif

// STB_VORBIS_NO_HUFFMAN_BINARY_SEARCH
//     If the 'fast huffman' search doesn't succeed, then stb_vorbis falls
//     back on binary searching for the correct one. This requires storing
//     extra tables with the huffman codes in sorted order. Defining this
//     symbol trades off space for speed by forcing a linear search in the
//     non-fast case, except for "sparse" codebooks.
// #define STB_VORBIS_NO_HUFFMAN_BINARY_SEARCH

// STB_VORBIS_DIVIDES_IN_RESIDUE
//     stb_vorbis precomputes the result of the scalar residue decoding
//     that would otherwise require a divide per chunk. you can trade off
//     space for time by defining this symbol.
// #define STB_VORBIS_DIVIDES_IN_RESIDUE

// STB_VORBIS_DIVIDES_IN_CODEBOOK
//     vorbis VQ codebooks can be encoded two ways: with every case explicitly
//     stored, or with all elements being chosen from a small range of values,
//     and all values possible in all elements. By default, stb_vorbis expands
//     this latter kind out to look like the former kind for ease of decoding,
//     because otherwise an integer divide-per-vector-element is required to
//     unpack the index. If you define STB_VORBIS_DIVIDES_IN_CODEBOOK, you can
//     trade off storage for speed.
//#define STB_VORBIS_DIVIDES_IN_CODEBOOK

#ifdef STB_VORBIS_CODEBOOK_SHORTS
#error "STB_VORBIS_CODEBOOK_SHORTS is no longer supported as it produced incorrect results for some input formats"
#endif

// STB_VORBIS_DIVIDE_TABLE
//     this replaces small integer divides in the floor decode loop with
//     table lookups. made less than 1% difference, so disabled by default.

// STB_VORBIS_NO_INLINE_DECODE
//     disables the inlining of the scalar codebook fast-huffman decode.
//     might save a little codespace; useful for debugging
// #define STB_VORBIS_NO_INLINE_DECODE

// STB_VORBIS_NO_DEFER_FLOOR
//     Normally we only decode the floor without synthesizing the actual
//     full curve. We can instead synthesize the curve immediately. This
//     requires more memory and is very likely slower, so I don't think
//     you'd ever want to do it except for debugging.
// #define STB_VORBIS_NO_DEFER_FLOOR




//////////////////////////////////////////////////////////////////////////////

#ifdef STB_VORBIS_NO_PULLDATA_API
   #define STB_VORBIS_NO_INTEGER_CONVERSION
   #define STB_VORBIS_NO_STDIO
#endif

#if defined(STB_VORBIS_NO_CRT) && !defined(STB_VORBIS_NO_STDIO)
   #define STB_VORBIS_NO_STDIO 1
#endif

#ifndef STB_VORBIS_NO_INTEGER_CONVERSION
#ifndef STB_VORBIS_NO_FAST_SCALED_FLOAT

   // only need endianness for fast-float-to-int, which we don't
   // use for pushdata

   #ifndef STB_VORBIS_BIG_ENDIAN
     #define STB_VORBIS_ENDIAN  0
   #else
     #define STB_VORBIS_ENDIAN  1
   #endif

#endif
#endif


#ifndef STB_VORBIS_NO_STDIO
#include <stdio.h>
#endif

#ifndef STB_VORBIS_NO_CRT
   #include <stdlib.h>
   #include <string.h>
   #include <assert.h>
   #include <math.h>

   // find definition of alloca if it's not in stdlib.h:
   #if defined(_MSC_VER) || defined(__MINGW32__)
      #include <malloc.h>
   #endif
   #if defined(__linux__) || defined(__linux) || defined(__sun__) || defined(__EMSCRIPTEN__) || defined(__NEWLIB__)
      #include <alloca.h>
   #endif
#else // STB_VORBIS_NO_CRT
   #define NULL 0
   #define malloc(s)   0
   #define free(s)     ((void) 0)
   #define realloc(s)  0
#endif // STB_VORBIS_NO_CRT

#include <limits.h>

#ifdef __MINGW32__
   // eff you mingw:
   //     "fixed":
   //         http://sourceforge.net/p/mingw-w64/mailman/message/32882927/
   //     "no that broke the build, reverted, who cares about C":
   //         http://sourceforge.net/p/mingw-w64/mailman/message/32890381/
   #ifdef __forceinline
   #undef __forceinline
   #endif
   #define __forceinline
   #ifndef alloca
   #define alloca __builtin_alloca
   #endif
#elif !defined(_MSC_VER)
   #if __GNUC__
      #define __forceinline inline
   #else
      #define __forceinline
   #endif
#endif

#if STB_VORBIS_MAX_CHANNELS > 256
#error "Value of STB_VORBIS_MAX_CHANNELS outside of allowed range"
#endif

#if STB_VORBIS_FAST_HUFFMAN_LENGTH > 24
#error "Value of STB_VORBIS_FAST_HUFFMAN_LENGTH outside of allowed range"
#endif


#if 0
#include <crtdbg.h>
#define CHECK(f)   _CrtIsValidHeapPointer(f->channel_buffers[1])
#else
#define CHECK(f)   ((void) 0)
#endif

#define MAX_BLOCKSIZE_LOG  13   // from specification
#define MAX_BLOCKSIZE      (1 << MAX_BLOCKSIZE_LOG)


typedef unsigned char  uint8;
typedef   signed char   int8;
typedef unsigned short uint16;
typedef   signed short  int16;
typedef unsigned int   uint32;
typedef   signed int    int32;

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

typedef float codetype;

#ifdef _MSC_VER
#define STBV_NOTUSED(v)  (void)(v)
#else
#define STBV_NOTUSED(v)  (void)sizeof(v)
#endif

// @NOTE
//
// Some arrays below are tagged "//varies", which means it's actually
// a variable-sized piece of data, but rather than malloc I assume it's
// small enough it's better to just allocate it all together with the
// main thing
//
// Most of the variables are specified with the smallest size I could pack
// them into. It might give better performance to make them all full-sized
// integers. It should be safe to freely rearrange the structures or change
// the sizes larger--nothing relies on silently truncating etc., nor the
// order of variables.

#define FAST_HUFFMAN_TABLE_SIZE   (1 << STB_VORBIS_FAST_HUFFMAN_LENGTH)
#define FAST_HUFFMAN_TABLE_MASK   (FAST_HUFFMAN_TABLE_SIZE - 1)


typedef struct
{
   int dimensions, entries;
   uint8 *codeword_lengths;
   float  minimum_value;
   float  delta_value;
   uint8  value_bits;
   uint8  lookup_type;
   uint8  sequence_p;
   uint8  sparse;
   uint32 lookup_values;
   codetype *multiplicands;
   uint32 *codewords;
   #ifdef STB_VORBIS_FAST_HUFFMAN_SHORT
    int16  fast_huffman[FAST_HUFFMAN_TABLE_SIZE];
   #else
    int32  fast_huffman[FAST_HUFFMAN_TABLE_SIZE];
   #endif
   uint32 *sorted_codewords;
   int    *sorted_values;
   int     sorted_entries;
} Codebook;

typedef struct
{
   uint8 order;
   uint16 rate;
   uint16 bark_map_size;
   uint8 amplitude_bits;
   uint8 amplitude_offset;
   uint8 number_of_books;
   uint8 book_list[16]; // varies
} Floor0;

typedef struct
{
   uint8 partitions;
   uint8 partition_class_list[32]; // varies
   uint8 class_dimensions[16]; // varies
   uint8 class_subclasses[16]; // varies
   uint8 class_masterbooks[16]; // varies
   int16 subclass_books[16][8]; // varies
   uint16 Xlist[31*8+2]; // varies
   uint8 sorted_order[31*8+2];
   uint8 neighbors[31*8+2][2];
   uint8 floor1_multiplier;
   uint8 rangebits;
   int values;
} Floor1;

typedef union
{
   Floor0 floor0;
   Floor1 floor1;
} Floor;

typedef struct
{
   uint32 begin, end;
   uint32 part_size;
   uint8 classifications;
   uint8 classbook;
   uint8 **classdata;
   int16 (*residue_books)[8];
} Residue;

typedef struct
{
   uint8 magnitude;
   uint8 angle;
   uint8 mux;
} MappingChannel;

typedef struct
{
   uint16 coupling_steps;
   MappingChannel *chan;
   uint8  submaps;
   uint8  submap_floor[15]; // varies
   uint8  submap_residue[15]; // varies
} Mapping;

typedef struct
{
   uint8 blockflag;
   uint8 mapping;
   uint16 windowtype;
   uint16 transformtype;
} Mode;

typedef struct
{
   uint32  goal_crc;    // expected crc if match
   int     bytes_left;  // bytes left in packet
   uint32  crc_so_far;  // running crc
   int     bytes_done;  // bytes processed in _current_ chunk
   uint32  sample_loc;  // granule pos encoded in page
} CRCscan;

typedef struct
{
   uint32 page_start, page_end;
   uint32 last_decoded_sample;
} ProbedPage;

struct stb_vorbis
{
  // user-accessible info
   unsigned int sample_rate;
   int channels;

   unsigned int setup_memory_required;
   unsigned int temp_memory_required;
   unsigned int setup_temp_memory_required;

   char *vendor;
   int comment_list_length;
   char **comment_list;

  // input config
#ifndef STB_VORBIS_NO_STDIO
   FILE *f;
   uint32 f_start;
   int close_on_free;
#endif

   uint8 *stream;
   uint8 *stream_start;
   uint8 *stream_end;

   uint32 stream_len;

   uint8  push_mode;

   // the page to seek to when seeking to start, may be zero
   uint32 first_audio_page_offset;

   // p_first is the page on which the first audio packet ends
   // (but not necessarily the page on which it starts)
   ProbedPage p_first, p_last;

  // memory management
   stb_vorbis_alloc alloc;
   int setup_offset;
   int temp_offset;

  // run-time results
   int eof;
   enum STBVorbisError error;

  // user-useful data

  // header info
   int blocksize[2];
   int blocksize_0, blocksize_1;
   int codebook_count;
   Codebook *codebooks;
   int floor_count;
   uint16 floor_types[64]; // varies
   Floor *floor_config;
   int residue_count;
   uint16 residue_types[64]; // varies
   Residue *residue_config;
   int mapping_count;
   Mapping *mapping;
   int mode_count;
   Mode mode_config[64];  // varies

   uint32 total_samples;

  // decode buffer
   float *channel_buffers[STB_VORBIS_MAX_CHANNELS];
   float *outputs        [STB_VORBIS_MAX_CHANNELS];

   float *previous_window[STB_VORBIS_MAX_CHANNELS];
   int previous_length;

   #ifndef STB_VORBIS_NO_DEFER_FLOOR
   int16 *finalY[STB_VORBIS_MAX_CHANNELS];
   #else
   float *floor_buffers[STB_VORBIS_MAX_CHANNELS];
   #endif

   uint32 current_loc; // sample location of next frame to decode
   int    current_loc_valid;

  // per-blocksize precomputed data

   // twiddle factors
   float *A[2],*B[2],*C[2];
   float *window[2];
   uint16 *bit_reverse[2];

  // current page/packet/segment streaming info
   uint32 serial; // stream serial number for verification
   int last_page;
   int segment_count;
   uint8 segments[255];
   uint8 page_flag;
   uint8 bytes_in_seg;
   uint8 first_decode;
   int next_seg;
   int last_seg;  // flag that we're on the last segment
   int last_seg_which; // what was the segment number of the last seg?
   uint32 acc;
   int valid_bits;
   int packet_bytes;
   int end_seg_with_known_loc;
   uint32 known_loc_for_packet;
   int discard_samples_deferred;
   uint32 samples_output;

  // push mode scanning
   int page_crc_tests; // only in push_mode: number of tests active; -1 if not searching
#ifndef STB_VORBIS_NO_PUSHDATA_API
   CRCscan scan[STB_VORBIS_PUSHDATA_CRC_COUNT];
#endif

  // sample-access
   int channel_buffer_start;
   int channel_buffer_end;
};

#ifdef __cplusplus
}
#endif

#endif // STB_VORBIS_INCLUDE_STB_VORBIS_H
//
//  HEADER ENDS HERE
//
//////////////////////////////////////////////////////////////////////////////

/*
------------------------------------------------------------------------------
This software is available under 2 licenses -- choose whichever you prefer.
------------------------------------------------------------------------------
ALTERNATIVE A - MIT License
Copyright (c) 2017 Sean Barrett
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
------------------------------------------------------------------------------
ALTERNATIVE B - Public Domain (www.unlicense.org)
This is free and unencumbered software released into the public domain.
Anyone is free to copy, modify, publish, use, compile, sell, or distribute this
software, either in source code form or as a compiled binary, for any purpose,
commercial or non-commercial, and by any means.
In jurisdictions that recognize copyright laws, the author or authors of this
software dedicate any and all copyright interest in the software to the public
domain. We make this dedication for the benefit of the public at large and to
the detriment of our heirs and successors. We intend this dedication to be an
overt act of relinquishment in perpetuity of all present and future rights to
this software under copyright law.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
------------------------------------------------------------------------------
*/
