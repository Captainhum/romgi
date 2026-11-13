// CHD conversion entry points for romgi.
//
// create_cd follows chdman's `createcd` (MAME 0.289, src/tools/chdman.cpp,
// BSD-3-Clause, Aaron Giles): same TOC parsing, track padding, metadata and
// default codecs (cdlz, cdzl, cdfl), so output matches chdman for the same
// input. verify follows chdman's `verify`.

#include "romgi_chd.h"

#include "chd.h"
#include "cdrom.h"
#include "chdcodec.h"
#include "hashing.h"

#include "chd_shim.h"

#include <algorithm>
#include <sys/statvfs.h>
#include <cstdio>
#include <memory>
#include <vector>

namespace {

struct TocHandle {
    chd_shim_toc_t* toc = chd_shim_toc_alloc();
    ~TocHandle() { if (toc) chd_shim_toc_free(toc); }
};

struct CompressorHandle {
    chd_file_compressor_t* compressor = nullptr;
    ~CompressorHandle() { if (compressor) chd_shim_compressor_free(compressor); }
};

bool cancelled(const int32_t* cancel) {
    return cancel != nullptr && __atomic_load_n(cancel, __ATOMIC_RELAXED) != 0;
}

void report(double* progress, double value) {
    if (progress != nullptr) __atomic_store(progress, &value, __ATOMIC_RELAXED);
}

} // namespace

extern "C" {

int32_t romgi_chd_create_cd(const char* cue_path, const char* chd_path,
                            double* progress, const int32_t* cancel) {
    TocHandle toc;
    if (toc.toc == nullptr) return ROMGI_CHD_ERR_INTERNAL;
    if (chd_shim_toc_parse(toc.toc, cue_path) != 0) return ROMGI_CHD_ERR_INPUT;

    // pad each track to a 4-frame boundary, as chdman does
    chd_shim_toc_pad_tracks(toc.toc);
    const uint64_t logical_bytes = chd_shim_toc_logical_bytes(toc.toc);

    CompressorHandle chd;
    chd.compressor = chd_shim_cd_compressor_alloc(toc.toc);
    if (chd.compressor == nullptr) return ROMGI_CHD_ERR_INTERNAL;

    const uint32_t compression[4] = {
        CHD_CODEC_CD_LZMA, CHD_CODEC_CD_ZLIB, CHD_CODEC_CD_FLAC, CHD_CODEC_NONE,
    };
    const uint32_t frame_size = cdrom_file::FRAME_SIZE;
    const uint32_t hunk_bytes = cdrom_file::FRAMES_PER_HUNK * frame_size;

    int32_t result = ROMGI_CHD_OK;
    if (chd_shim_compressor_create_file(chd.compressor, chd_path, logical_bytes,
                                        hunk_bytes, frame_size, compression) != 0) {
        return ROMGI_CHD_ERR_OUTPUT;
    }
    if (chd_shim_cd_write_metadata(reinterpret_cast<chd_file_t*>(chd.compressor),
                                   toc.toc) != 0) {
        result = ROMGI_CHD_ERR_OUTPUT;
    } else {
        chd_shim_compressor_begin(chd.compressor);
        double complete = 0, ratio = 0;
        for (;;) {
            if (cancelled(cancel)) {
                result = ROMGI_CHD_ERR_CANCELLED;
                break;
            }
            const chd_error_t err =
                chd_shim_compressor_continue(chd.compressor, &complete, &ratio);
            report(progress, complete);
            if (err == static_cast<chd_error_t>(chd_file::error::COMPRESSING) ||
                err == static_cast<chd_error_t>(chd_file::error::WALKING_PARENT)) {
                continue;
            }
            if (err != 0) result = ROMGI_CHD_ERR_COMPRESS;
            break;
        }
    }

    // close before deleting a failed output
    chd_shim_compressor_free(chd.compressor);
    chd.compressor = nullptr;
    if (result != ROMGI_CHD_OK) {
        std::remove(chd_path);
    } else {
        report(progress, 1.0);
    }
    return result;
}

int32_t romgi_chd_verify(const char* chd_path, double* progress,
                         const int32_t* cancel) {
    chd_file chd;
    if (chd.open(chd_path)) return ROMGI_CHD_ERR_INPUT;

    util::sha1_creator rawsha1;
    std::vector<uint8_t> buffer(chd.hunk_bytes());
    const uint64_t total = chd.logical_bytes();
    uint64_t offset = 0;
    for (uint32_t hunk = 0; offset < total; hunk++) {
        if (cancelled(cancel)) return ROMGI_CHD_ERR_CANCELLED;
        if (chd.read_hunk(hunk, buffer.data())) return ROMGI_CHD_ERR_CORRUPT;
        const uint64_t length =
            std::min<uint64_t>(chd.hunk_bytes(), total - offset);
        rawsha1.append(buffer.data(), uint32_t(length));
        offset += length;
        report(progress, double(offset) / double(total));
    }

    const util::sha1_t computed = rawsha1.finish();
    if (computed != chd.raw_sha1()) return ROMGI_CHD_ERR_CORRUPT;
    if (chd.version() >= 4 && chd.compute_overall_sha1(computed) != chd.sha1()) {
        return ROMGI_CHD_ERR_CORRUPT;
    }
    report(progress, 1.0);
    return ROMGI_CHD_OK;
}

int64_t romgi_free_bytes(const char* path) {
    struct statvfs stats;
    if (statvfs(path, &stats) != 0) return -1;
    return int64_t(stats.f_bavail) * int64_t(stats.f_frsize);
}

} // extern "C"
