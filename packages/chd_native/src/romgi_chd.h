#ifndef ROMGI_CHD_H
#define ROMGI_CHD_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define ROMGI_CHD_OK 0
#define ROMGI_CHD_ERR_INPUT 1      // cue/iso/gdi missing or unreadable
#define ROMGI_CHD_ERR_OUTPUT 2     // cannot create or write the .chd
#define ROMGI_CHD_ERR_COMPRESS 3   // compression failed
#define ROMGI_CHD_ERR_CANCELLED 4
#define ROMGI_CHD_ERR_CORRUPT 5    // verification failed
#define ROMGI_CHD_ERR_INTERNAL 6

// Converts the disc described by [cue_path] (CUE, TOC, GDI or ISO) into a
// CHD at [chd_path], like `chdman createcd`. Blocks until done. [progress]
// (0..1) is updated while compressing; set *[cancel] to non-zero to stop.
// A failed or cancelled conversion removes [chd_path].
int32_t romgi_chd_create_cd(const char* cue_path, const char* chd_path,
                            double* progress, const int32_t* cancel);

// Reads every hunk of [chd_path] and checks its SHA-1s, like `chdman verify`.
int32_t romgi_chd_verify(const char* chd_path, double* progress,
                         const int32_t* cancel);

// Free bytes available to the app on the volume holding [path], or -1.
int64_t romgi_free_bytes(const char* path);

#ifdef __cplusplus
}
#endif

#endif
