#ifndef _LR_OSD_H_
#define _LR_OSD_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//#define ALLEGRO_STATICLINK

#define OSD_KEY_I     ('I' & 0x3f)
#define OSD_KEY_J     ('J' & 0x3f)
#define OSD_KEY_K     ('K' & 0x3f)
#define OSD_KEY_L     ('L' & 0x3f)
#define OSD_KEY_U     ('U' & 0x3f)
#define OSD_KEY_O     ('O' & 0x3f)
#define OSD_KEY_X     ('X' & 0x3f)
#define OSD_KEY_Z     ('Z' & 0x3f)
#define OSD_KEY_ESC   0x3b

#define OSD_PRINTF(format...)		fprintf (stderr,format)

#ifdef __cplusplus
extern "C"
{
#endif
  
void osd_gcls (uint8_t page);
void osd_display_char_pg (uint8_t page, uint8_t chr, uint8_t x, uint8_t y);
void osd_draw_separator (uint8_t page, uint8_t byte, uint8_t y);
void osd_wipe_circle (void);
void osd_draw_circle (void);
int osd_keypressed (void);
void osd_delay (unsigned ms);
int osd_readkey (void);
int osd_key (int key);
void osd_wipe_char (int8_t sprite, uint8_t chr, uint8_t x_div_2, uint8_t y);
void osd_display_transparent_char (int8_t sprite, uint8_t chr, uint8_t x_div_2, uint8_t y);
void osd_hgr (uint8_t page);
#define OSD_HGR1  osd_hgr (0)
#define OSD_HGR2  osd_hgr (1)
void osd_flush_keybd (void);
void osd_display_title_screen (uint8_t page);
void osd_game_over_frame (uint8_t frame, const uint8_t game_over_frame[][14], const uint8_t gol[][26]);

#ifdef __cplusplus
}
#endif

#endif